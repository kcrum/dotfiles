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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# My stuff below here...
source ~/.bash_passwords
source ~/.git-completion.bash
# Set editor
export EDITOR=/usr/bin/emacs
# Put your binaries in the path
export PATH=/Users/kcrum/bin/:$PATH
# Set Spark home, put Spark in path
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
# The below two variables mean calling `pyspark` will launch a jupyter notebook
# with the appropriate SparkContext set.
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'

export PATH="/home/kcrum/miniconda3/bin:$PATH"

# When psycopg2 was giving you trouble, you had this:
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin/
# so that pg_config was available when you called "pip install psycopg2"

# User specific aliases and functions
alias cp="cp -i"
alias mv="mv -i"
alias diff="diff -s"
alias emacs="/usr/bin/emacs -nw"
alias dockerpass="echo -n $DOCKER_PASSWORD | xclip -selection clipboard"
# Conda aliases
alias envlist="conda env list"
alias rootenv="source activate root; cd ."
alias nn_sandbox="source activate nn_sandbox; cd ~/coding_space/sandbox/nn_sandbox/"
alias sandbox="source activate sandbox; cd ~/coding_space/sandbox/"
alias surveys="source activate surveys; cd ~/src/Survey-Client/"
alias psb="source activate psb_predict; cd ~/src/psb_process_predict_job/; export AWS_ACCESS_KEY_ID=$AWS_LEGACY_KEY_ID; AWS_SECRET_ACCESS_KEY=$AWS_LEGACY_SECRET_ACCESS_KEY"
alias cmo="source activate cmo; cd /Users/kcrum/src/civis-optimize/"
alias weighting="source activate weighting; cd /Users/kcrum/src/survey-weighting"
alias testgeo="export DYLD_FALLBACK_LIBRARY_PATH=/lib:/usr/local/lib:/lib:/usr/lib; source activate testgeo; cd ."
alias model_deployment="source activate model_deployment; cd /Users/kcrum/src/model-deployment"
alias muffnn="source activate muffnn; cd /Users/kcrum/src/muffnn"

# misspellings
alias emcas="emacs"
alias emasc="emacs"

export CONDA_DEFAULT_ENV="root"

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

  export PS1="\[\e[1;208m\][${CONDA_DEFAULT_ENV##*/}]\[\e[m\]\[\e[1;34m\]${NAME}\[\e[m\] \[\e[1;32m\]>\[\e[m\] "
}

Xcd .

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
