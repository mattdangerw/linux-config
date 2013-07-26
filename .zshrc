# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

# for gnome jhbuild
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi

#git uses sublime
export EDITOR="subl -w"

# resume downloads if dc'd
alias wget='wget -c'
alias chrome='google-chrome'
alias files='nautilus'
alias term='gnome-terminal'

# some more ls aliases
alias la='ls -A'
alias ll='ls -Al'
alias lt='ls -Altr'

# easy zsh move
autoload -U zmv
alias mmv='noglob zmv -W'

# sudo uses aliases
alias sudo='sudo '

# apt crap
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias search='apt-cache search'

# more dots
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'
alias logout='gnome-session-quit'

alias zedit='subl ~/.zshrc'
alias zup='source ~/.zshrc'

alias g='git'
alias py='python'

# cd commands for the stuff i'm currently working on
alias demo='cd ~/tgc-demo'

# ls after every cd
function chpwd() {
    emulate -LR zsh
    ls
}

# quick clone
function github()
{
    if [ "$#" -eq 0 ]; then
        echo "Enter a path!"
        return
    fi
    local gitpath=https://github.com/"$1".git
    shift
    git clone $gitpath "$@"
}
