# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# prompt
export PS1="[\u@\h \w]\\$ "

# alias
alias ls='ls -G'
alias ll='ls -l --color=always'
alias vimn='vim .'

# git
source ~/.git-completion.bash

# Attache tmux
if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
    if ( tmux has-session ); then
  session=`tmux list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]\+\).*$/\1/'`
      if [ -n "$session" ]; then
      echo "Attache tmux session $session."
          tmux attach-session -t $session
  else
      echo "Session has been already attached."
      tmux list-sessions
      fi
    else
  echo "Create new tmux session."
  tmux
    fi
fi
