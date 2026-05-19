# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE

setopt sharehistory
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Options
setopt autocd
setopt beep
setopt extendedglob
setopt nomatch
setopt notify

bindkey -e


# Tools
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"

# Aliases
alias -- ls="eza -lh --icons --git"
alias -- lsa="eza -lah --icons --git"
alias -- gd="git diff"

# Plugins

## Insall/Laad Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

## Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light Grafcube/zinit-git

zinit snippet OMZP::sudo

# Completions
zstyle :compinstall filename '/home/mridula/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' matcher-list "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

autoload -Uz compinit && compinit

zinit cdreplay -q
