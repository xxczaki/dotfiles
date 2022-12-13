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

# npm
sh $HOME/.zsh/npm-autocomplete.sh

# tabtab (e.g. for pnpm)
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true