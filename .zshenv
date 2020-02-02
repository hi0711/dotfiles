PATH=/usr/local/bin:$PATH

### FDKのPATHを通す
export PATH=PATH=~/bin/FDK/Tools/osx:$PATH

### anyenvのパスを通す
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - zsh)"
### rbenvのPATHを通す
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
### rbenvの設定用
# rbenv
if [ -d ${HOME}/.rbenv  ] ; then
  export PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}"
  eval "$(rbenv init - zsh)"
fi
## pyenvのPATHを通す
  # export PYENV_ROOT="${HOME}/.pyenv"
  # export PATH=${PYENV_ROOT}/bin:$PATH
  # eval "$(pyenv init - zsh)"
### ndenvのPATHを通す
if [ -d ${HOME}/.anyenv ] ; then
export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init - zsh)"
     for D in `ls $HOME/.anyenv/envs`
     do
         export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
     done

fi
### git diff-highlighterのパスを通す
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

