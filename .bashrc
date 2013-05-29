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

sublime() {
	os=`uname -a | awk '{ print $1 }'`
	if [ $os == "Darwin" ]; then
		alias sublime="/Applications/Sublime\ Text\ 2.app/Contents/MacOS/Sublime\ Text\ 2"
	# else
	#	alias sublime="/usr/bin/sublime"
	fi
}

# Finally source machine specific definitions so we can overwrite these if needed
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
