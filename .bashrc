#### .bashrc ####
source ~/.bash_passwords
source ~/.git-completion.bash
# Set editor
export EDITOR=/usr/bin/emacs

### Add anaconda to PATH. ---> Should you now delete this? It's not really
### under your package manager, and you've separately downloaded all of the
### packages in the SciPy stack...
#export PATH=/usr/local/anaconda/bin/:$PATH

# When psycopg2 was giving you trouble, you had this:
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin/
# so that pg_config was available when you called "pip install psycopg2"


# Add mpl_toolkits to PYTHONPATH which contains Basemap (there is another
# mpl_toolkits installed the python finds first which is missing Basemap).
#PYTHONPATH=/usr/lib/pymodules/python2.7/:$PYTHONPATH

# Add scikit-learn to PYTHONPATH --> NOW USING SKLEARN MANAGED BY pip
#export PYTHONPATH=$PYTHONPATH:/Users/kcrum/coding_space/scikit-learn/

# This next line is needed to make pyBayesTree work. Without it, symbols expected
# in libstdc++.6.dylib will not be found.
export DYLD_FALLBACK_LIBRARY_PATH=/Users/kcrum/miniconda3/envs/automodeler/lib/:$DYLD_FALLBACK_LIBRARY_PATH

# User specific aliases and functions
alias ll="ls -lh"
alias cp="cp -i"
alias mv="mv -i"
alias dragonfly="ssh kcrum@10.117.128.123"
alias diff="diff -s"
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias civpass="echo -n $PLATFORM_PASSWORD | pbcopy"
# Conda aliases
alias envlist="conda env list"
alias py34="source activate py34; cd ."
alias rootenv="source activate root; cd ."
alias automodeler="source activate automodeler; cd ~/src/automodeler/automodeler/"
alias paro="source activate paro; cd ~/src/paro/paro/"
alias civismodel="source activate civis-model; cd ~/src/civis-model/civismodel/"
alias nn_sandbox="source activate nn_sandbox; cd ~/coding_space/nn_sandbox/"
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
