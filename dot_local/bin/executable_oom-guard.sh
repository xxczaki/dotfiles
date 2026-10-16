#!/bin/bash
# Kills the largest user process when available memory drops below THRESHOLD_MB,
# so a runaway process can't push macOS into a swap-exhaustion panic.
THRESHOLD_MB=2048
# Never kill these (top truncates names to ~16 chars)
PROTECT='^(loginwindow|Finder|Dock|SystemUIServer|ControlCenter|Terminal|launchd)'
LOG="$HOME/Library/Logs/oom-guard.log"
total_mb=$(( $(sysctl -n hw.memsize) / 1048576 ))

while true; do
  # kern.memorystatus_level is the kernel's "% memory available" (free + reclaimable)
  avail_mb=$(( total_mb * $(sysctl -n kern.memorystatus_level) / 100 ))
  if (( avail_mb < THRESHOLD_MB )); then
    # top's MEM includes compressed memory, unlike ps RSS
    read -r pid mem cmd < <(top -l 1 -o mem -n 15 -U "$USER" -stats pid,mem,command \
      | awk -v re="$PROTECT" '/^PID/{f=1;next} f { c=$0; sub(/^ *[0-9]+ +[^ ]+ +/,"",c); if (c !~ re) {print; exit} }')
    if [[ -n "$pid" ]]; then
      echo "$(date '+%F %T') avail=${avail_mb}MB killing pid=$pid mem=$mem cmd=$cmd" >> "$LOG"
      kill -TERM "$pid"
      sleep 3
      kill -0 "$pid" 2>/dev/null && kill -KILL "$pid"
      osascript -e "display notification \"Killed $cmd ($mem)\" with title \"OOM guard\"" &
      # Let memory settle before re-checking
      sleep 10
    fi
  fi
  sleep 3
done
