# .bashrc

# User specific aliases and functions
ulimit -c unlimited

set -o notify
shopt -s cdspell

export EDITOR=nano

alias ls="ls -G"
alias ll="ls -lGh"
alias la="ls -lGhA"
alias ..="cd .."
alias cdcode="cd ~/code"
alias ebrc="nano ~/.bashrc"
alias ebrcl="nano ~/.bashrc_local; upd"
alias upd="source ~/.bashrc"
alias gitstatus="git status"
alias gitlot="git l"

# Non-standard program shortcuts
alias tf='terraform'

# JJ
alias jjl='jj l'

# TODO: only finds branches prefixed by 'cooley' :thinking:
jj-sync() {
  cur_branches=$(jj branch l -r 'branches(cooley)' | grep -o "cooley/.*" | cut -d':' -f1)
  echo "Syncing $(echo $cur_branches | tr ' ' '\n' | wc -l) branch(es)"
  jj upd  \
  && for br in $cur_branches; do
       jj rebase -d main -b "$br"
  done
}

jj-clean() {
  # Find all empty branches authored by me
  stale_branches=$(jj stale | grep -o "cooley/.*" | cut -d':' -f1)
  echo "Removing $(echo $stale_branches | tr ' ' '\n' | wc -l) branch(es)"
  for br in $stale_branches; do
    jj branch delete "$br"
  done
}

# Function which runs ll or less depending on type of path
lo() {
  if [[ -d "$1" ]]; then
	ll $1
  else
    less $1
  fi
}

ghauth() {
  if [[ -z $SSH_KEYNAME ]]; then
    SSH_KEYNAME="id"
  fi
  ssh-add "$HOME/.ssh/$SSH_KEYNAME"
  if [[ "$?" = 2 ]]; then
    eval $(ssh-agent -s) && ssh-add "$HOME/.ssh/$SSH_KEYNAME"
  fi
}

# Finally source machine specific definitions so we can overwrite these if needed
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi
