PATH=/usr/local/bin:$PATH
typeset -U path PATH

### FDKのPATHを通す
export PATH=PATH=~/bin/FDK/Tools/osx:$PATH

### rbenvのPATHを通す
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
### rbenvの設定用
# rbenv
if [ -d ${HOME}/.rbenv  ] ; then
  export PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}"
  eval "$(rbenv init -)"
fi
# plenv
if [ -d ${HOME}/.plenv  ] ; then
  export PATH=${HOME}/.plenv/bin/:${HOME}/.plenv/shims:${PATH}
  eval "$(plenv init -)"
fi

### anyenvのパスを通す
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
# fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh-completions /usr/local/share/zsh/site-functions /usr/local/Cellar/zsh/5.2/share/zsh/functions)

### git diff-highlighterのパスを通す
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

### pyenvのPATHを通す
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"

### ndenvのPATHを通す
if [ -d ${HOME}/.anyenv ] ; then
export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
     for D in `ls $HOME/.anyenv/envs`
     do
         export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
     done

fi



