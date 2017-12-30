#!/bin/bash

PATH=$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:$HOME/.rvm/bin:$PATH
export PATH=/usr/local/bin:$PATH

. ~/.bash/alias
. ~/.bash/functions
. ~/.bash/env
. ~/.bash/app/docker
. ~/.bash/app/git

if [ -f ~/.bash/local ]; then
  . ~/.bash/local
fi

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
