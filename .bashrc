# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
ulimit -c unlimited

set -o notify

export EDITOR=nano

alias ls="ls --color=auto"
alias ll="ls -l --group-directories"
alias la="ls -lA --group-directories"
alias ..="cd .."
alias ebrc="nano ~/.bashrc"
alias upd="source ~/.bashrc"
alias o="less"
alias gitstatus="git status"

alias tsyslog="sudo tail -f /var/log/syslog"

gitclone() {
	git clone git@github.com:brcooley/$1
}

# Finally source machine specific definitions so we can overwrite these if needed
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
