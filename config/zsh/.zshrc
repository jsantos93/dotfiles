autoload -Uz compinit
compinit

eval "$(starship init zsh)"

source <(fzf --zsh)

#K8s
source <(kubectl completion zsh)

# Antidote (ZSH plugin Manager)
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load


# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~


HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions


#~~~~~~~~~~Environment Variables~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"


#Directories


export REPOS="$HOME/Repos"
export HOMELAB="$REPOS/homelab"
export ICLOUD="$HOME/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Second\ Brain/"

#~~~~~~~~~~PATH~~~~~~~~~~~~

export PATH="$HOME/Scripts:$PATH"

#~~~~~~~~~~Alias~~~~~~~~~~ 
alias ls="ls --color=auto"
alias v=nvim

# Github

alias gs="git status"
alias gcm="git commit -m"

# Repos

alias repos="cd $REPOS"
alias dot="cd $REPOS/dotfiles"

# Homelab

alias homelab="cd $HOMELAB"
alias notes="cd $ICLOUD"


# Kubernetes 

alias k=kubectl
alias ctx="kubectx"
alias ns="kubens"

# Claude

if [ -f ~/Repos/dotfiles/config/zsh/zsh-claude ]; then
  source ~/Repos/dotfiles/config/zsh/zsh-claude
fi



