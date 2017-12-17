#### .bashrc ####
source ~/.bash_passwords
source ~/.git-completion.bash
# Set editor
export EDITOR=/usr/bin/emacs
# Put your binaries in the path
export PATH=/home/kcrum/bin/:$PATH

export PATH="/home/kcrum/miniconda3/bin:$PATH"

# When psycopg2 was giving you trouble, you had this:
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin/
# so that pg_config was available when you called "pip install psycopg2"

# User specific aliases and functions
alias ll="ls -lh"
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
