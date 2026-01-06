#### .bashrc ####

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

alias julia="exec '/Applications/Julia-1.6.app/Contents/Resources/julia/bin/julia'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# My stuff below here...
source ~/.bash_passwords
source ~/.git-completion.bash
# Set editor
export EDITOR=/Applications/Emacs.app/Contents/MacOS/Emacs
# Put your binaries in the path
export PATH=/Users/kcrum/bin/:$PATH
# export PATH=/Users/kcrum/miniconda3/bin:$PATH

# Add spark stuff
export SPARK_HOME=/Users/kcrum/src/spark-2.2.1-bin-hadoop2.7
export PATH=$PATH:$SPARK_HOME/bin
# These two vars make pyspark open in a Jupyter notebook
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'

# When psycopg2 was giving you trouble, you had this:
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin/
# so that pg_config was available when you called "pip install psycopg2"

# User specific aliases and functions
alias cp="cp -i"
alias mv="mv -i"
alias diff="diff -s"
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
# alias dockerpass="echo -n $DOCKER_PASSWORD | xclip -selection clipboard"
alias dockerpass="echo -n $DOCKER_PASSWORD | pbcopy"
# Conda aliases
# alias envlist="conda env list"
# alias baseenv="source activate base; cd ."
# alias fastai="source activate nn_sandbox; cd ~/coding_space/sandbox/fast_ai"
# alias nn_sandbox="source activate nn_sandbox; cd ~/coding_space/sandbox/nn_sandbox"
# alias sandbox="conda activate sandbox; cd ~/coding_space/sandbox/"
# alias model_deployment="source activate model_deployment; cd /Users/kcrum/src/model-deployment"
# alias muffnn="source activate muffnn; cd /Users/kcrum/src/muffnn"
alias jnb="jupyter notebook"

## uv stuff below here ##
alias thisenv="source .venv/bin/activate; cd ."
alias defenv='source  "$HOME/.venvs/default/bin/activate"; cd .'
alias whichenv='echo "$VIRTUAL_ENV"'     # single quotes prevent bash from expanding the variable when creating the alias
# uv autocomplete
. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion bash)"

# If the "default" venv exists and no venv is currently active, activate it automatically
if [ -z "$VIRTUAL_ENV" ] && [ -d "$HOME/.venvs/default" ]; then
  # Use POSIX activation
  # (silence errors if activation file is missing)
  if [ -f "$HOME/.venvs/default/bin/activate" ]; then
    # comment out the next line if you don't want it auto-activated
    source "$HOME/.venvs/default/bin/activate"
  fi
fi


# misspellings
alias emcas="emacs"
alias emasc="emacs"

export gitbrt="git for-each-ref --sort='-committerdate:iso8601' --format=' %(committerdate:iso8601)%09%(refname)' refs/heads | head"

#
# Make the current directory display in PS1 (note: PS1 change disabled from
# Straitluv's original; see last lines of Xcd)  and in the xterm title, but
# only display as many directories up from PWD as fit in MAXPWDCHAR characters,
# not counting the leading slash if we're displaying the full path, unless the
# first one is longer than that, in which case, display it regardless.
#
alias cd=Xcd
MAXPWDCHAR=23

Xcd ()
{
  'cd' "$@"

  NAME=$(printf "$PWD" | tail -c $MAXPWDCHAR | cut -d/ -f 2-)
  if ! [ "$NAME" ]; then NAME=$(basename "$PWD"); fi
  if ! [ "$NAME" ]; then NAME=/; fi
  if [ "/$NAME" == "$PWD" ]; then NAME=$PWD; fi

  # reset name of xterm title bar & icon to $NAME
  if [ "$TERM" = xterm ] || [ "$TERM" = dtterm ]; then
      printf "\033]0;${NAME}\007"
  fi

  if [ "$VIRTUAL_ENV_PROMPT" ]; then
      VENVNAME="($VIRTUAL_ENV_PROMPT) ";
  elif [ "$VIRTUAL_ENV" ]; then
      VENVNAME="($(basename $VIRTUAL_ENV)) ";
  else VENVNAME=""; fi

  export PS1="${VENVNAME}\[\e[1;208m\]\[\e[m\]\[\e[1;34m\]${NAME}\[\e[m\] \[\e[1;32m\]>\[\e[m\] "
}

lstail ()
{
    ls "$@" | tail
}

lshead ()
{
    ls "$@" | head
}

lswc ()
{
    ls "$@" | wc -l
}

Xcd .
