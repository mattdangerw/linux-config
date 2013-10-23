# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="matt"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(github)

export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.bin

source $ZSH/oh-my-zsh.sh

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
alias l='ls'
alias la='ls -A'
alias ll='ls -Al'
alias lt='ls -Altr'

# easy zsh move
autoload -U zmv
alias mmv='noglob zmv -W'

alias sl='sl'

# sudo uses aliases
# alias sudo='sudo '

function say() {
    cowsay -s -f bong "$@" | cowsay -f ghostbusters -ns | cowsay -f dragon-and-cow -n -e "\$\$"
}

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
alias .....='cd ../../../..'

alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'
alias logout='gnome-session-quit'

alias zedit='subl ~/.zshrc'
alias zup='source ~/.zshrc'

# cd commands for the stuff i'm currently working on
alias sdk='cd ~/checkout/eos-sdk'
alias prog='cd ~/checkout/eos-programming-app'
alias off='cd ~/checkout/eos-wikipedia-offline'
alias photo='cd ~/checkout/eos-photos'
alias clut='cd ~/checkout/clutter'
alias gtk='cd ~/checkout/gtk+'
alias theme='cd ~/checkout/eos-theme'
alias jenkins='ssh ci@ci.endlessm.com -L 8080:localhost:8080'
# run command for different directories
function r() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        cowsay "No git no dice"
        return
    fi
    local repodir=$(git rev-parse --show-toplevel)
    local reponame="$(basename $repodir)"
    if [ "$reponame" = "eos-programming-app" ]; then
        gjs $repodir/src/endless_programming.js
    elif [ "$reponame" = "eos-photos" ]; then
        $repodir/endless-os-photos
    elif [ "$reponame" = "eos-weather" ]; then
        gjs $repodir/src/endless_weather.js
    else
        cowsay "Write a run rule"
    fi
}
alias m='make install'
alias mr='m && r'

# pipe to grep
alias -g '?'="| command grep"
alias pgrep="ps -e | command grep"
alias dgrep="dpkg -l | command grep"

# ls after every cd
function chpwd() {
    emulate -LR zsh
    ls
}

# quick clone
function gclone()
{
    if [ "$#" -eq 0 ]; then
        cowsay "Enter a path!"
        return
    fi
    local gitpath=https://github.com/"$1".git
    shift
    git clone $gitpath "$@"
}

# quick browser stuff
function huboard()
{
    if [ "$#" -eq 0 ]; then
        cowsay "Enter a path!"
        return
    fi
    chrome http://huboard.com/endlessm/eos-"$1"
}
function github()
{
    if [ "$#" -eq 0 ]; then
        cowsay "Enter a path!"
        return
    fi
    chrome https://github.com/endlessm/eos-"$1"
}

# Git mode! work in progress
function rm_git_mode()
{
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local output
        output=`git rm $@ 2>&1`
        local ret="$?"
        if [ $ret -ne 128 ]; then
            echo $output
            return $ret
        fi
    fi
    command rm "$@"
}
function mv_git_mode()
{
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local output
        output=`git mv $@ 2>&1`
        local ret="$?"
        if [ $ret -ne 128 ]; then
            echo $output
            return $ret
        fi
    fi
    command mv "$@"
}
function alias_git_mode()
{
    local aliases="$(git config --get-regexp '^alias.' | sed s/alias.// | awk '{print $1}')"
    local git_builtins="add am annotate apply archive bisect blame branch bundle cat-file check-attr check-ref-format checkout checkout-index cherry cherry-pick clean clone column commit commit-tree config count-objects credential credential-cache credential-store daemon describe diff diff-files diff-index diff-tree difftool fast-export fast-import fetch fetch-pack filter-branch fmt-merge-msg for-each-ref format-patch fsck fsck-objects gc get-tar-commit-id grep hash-object help http-backend http-fetch http-push imap-send index-pack init init-db instaweb log lost-found ls-files ls-remote ls-tree mailinfo mailsplit merge merge-base merge-file merge-index merge-octopus merge-one-file merge-ours merge-recursive merge-resolve merge-subtree merge-tree mergetool mktag mktree name-rev notes p4 pack-objects pack-redundant pack-refs patch-id peek-remote prune prune-packed pull push quiltimport read-tree rebase receive-pack reflog relink remote remote-ext remote-fd remote-ftp remote-ftps remote-http remote-https remote-testgit remote-testsvn repack replace repo-config request-pull rerere reset rev-list rev-parse revert send-pack sh-i18n--envsubst shell shortlog show show-branch show-index show-ref stage stash status stripspace submodule symbolic-ref tag tar-tree unpack-file unpack-objects update-index update-ref update-server-info upload-archive upload-pack var verify-pack verify-tag web--browse whatchanged write-tree"
    local hub_builtins="alias"
    _git_mode_commands=(${(ps:\n:)${aliases}} ${(ps: :)${git_builtins}})
    for word in $_git_mode_commands; do
        alias "$word"="git $word"
    done
    alias mv="mv_git_mode"
    alias rm="rm_git_mode"
}
function unalias_git_mode()
{
    for word in $_git_mode_commands
        do unalias "$word"
    done
    unalias mv
    unalias rm
}
# toggle git mode or run a single command with git
function g()
{
    if [ "$#" -eq 0 ]; then
        if [ $GIT_MODE ]; then
            unset GIT_MODE
            unalias_git_mode
        else
            export GIT_MODE='‹gm›'
            alias_git_mode
        fi
    else
        git $@
    fi
}
# remind me to not use old git aliases
alias gs='cowsay no'
alias gco='cowsay no'

# dir shortcuts
c() { cd ~/checkout/$1; }
_c() { _files -W ~/checkout -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

# TODO
# intergrate with hub
# autocomplete for huboard github commands
# cd commands for every eos repo
# version control!
