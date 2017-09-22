# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
ulimit -c unlimited

set -o notify
shopt -s cdspell

export EDITOR=nano

alias ls="ls --color=auto"
alias ll="ls -lh --group-directories"
alias la="ls -lhA --group-directories"
alias ..="cd .."
alias ebrc="nano ~/.bashrc"
alias ebrcl="nano ~/.bashrc_local; upd"
alias upd="source ~/.bashrc"
alias gitstatus="git status"
alias gohome="git checkout master"

alias tsyslog="sudo tail -f /var/log/syslog"

# Function which runs ll or less depending on type of path
lo() {
  if [[ -d "$1" ]]; then
	ll $1
  else
    less $1
  fi
}

gitclone() {
	git clone git@github.com:brcooley/$1
}

# Finally source machine specific definitions so we can overwrite these if needed
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
