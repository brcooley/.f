# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
ulimit -c unlimited

set -o notify
set -o emacs

export PATH="$PATH:~/bin"
export EDITOR=nano

alias ll="ls -l"
alias la="ls -lA"
alias ..="cd .."
alias yum="sudo yum"
alias edit="nano"
alias ebrc="nano ~/.bashrc"
alias upd="source ~/.bashrc"
alias o="less"
alias quota="quota -sQ"
alias top="top -U brcooley"
alias gitstatus="git status"
