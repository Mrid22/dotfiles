# Add your own customizations below
bindkey -e

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Plugins

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit load Grafcube/zinit-git

# Completions
autoload -U compinit && compinit

alias -- npm=pnpm
alias -- npx=pnpx

eval "$(zoxide init zsh --cmd cd)"
eval "$(oh-my-posh init zsh)"
