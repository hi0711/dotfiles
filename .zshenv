PATH=/usr/local/bin:$PATH
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
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
fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh-completions /usr/local/share/zsh/site-functions /usr/local/Cellar/zsh/5.2/share/zsh/functions)

### git diff-highlighterのパスを通す
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

### pyenvのPATHを通す
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
