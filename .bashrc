# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source machine specific definitions
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi

# User specific aliases and functions
ulimit -c unlimited

set -o notify

export PATH="$PATH:~/bin"
export EDITOR=nano

alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -lA"
alias ..="cd .."
alias yum="sudo yum"
alias apt="sudo apt-get"
alias pip="sudo pip"
alias edit="nano"
alias ebrc="nano ~/.bashrc"
alias upd="source ~/.bashrc"
alias o="less"
alias quota="quota -sQ"
alias gitstatus="git status"

alias sciclone="ssh -p2993 localhost"

gitclone() {
	git clone git@github.com:brcooley/$1
}
