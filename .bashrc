#### .bashrc ####
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
alias diff="diff -s"
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias civpass="echo -n $PLATFORM_PASSWORD | pbcopy"
alias dockerpass="echo -n $DOCKER_PASSWORD | pbcopy"
# Conda aliases
alias envlist="conda env list"
alias rootenv="source activate root; cd ."
alias automodeler="source activate automodeler; cd ~/src/automodeler/automodeler/"
alias paro="source activate paro; cd ~/src/paro/paro/"
alias kiwi="source activate kiwi; cd ~/src/kiwi/kiwi/"
alias civismodel="source activate civis-model; cd ~/src/civis-model/civismodel/"
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
