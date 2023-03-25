# Initialize completions
autoload -Uz compinit; compinit

# Initialize prompt
autoload -U promptinit; promptinit

# Use the "Pure" prompt
prompt pure

# Initialize zsh plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable Homebrew hints
HOMEBREW_NO_ENV_HINTS=1

# Change the symbol used in the "Pure" prompt
PURE_PROMPT_SYMBOL="◭"

# Modifications to PATH, MANPATH, etc.
path+=(
  "$HOME/.npm-packages/bin"
  "$HOME/Library/pnpm"
  "$HOME/.pyenv/bin"
  "$HOME/.poetry/bin"
  "/opt/homebrew/opt/postgresql@15/bin"
)
manpath+="$HOME/.npm-packages/share/man"

# Pyenv
eval "$(pyenv init -)"

# 1Password CLI
eval "$(op completion zsh)"; compdef _op op

# tabtab (e.g. for pnpm)
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Aliases
alias cat='bat --paging=never'

# GHCup (Haskell)
[ -f "/Users/antek/.ghcup/env" ] && source "/Users/antek/.ghcup/env" # ghcup-env

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
