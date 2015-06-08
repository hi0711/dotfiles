PATH=/usr/local/bin:$PATH
### rbenvのPATHを通す
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
### nodebrewのPATHを通す
export PATH="$HOME/.nodebrew/current/bin:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
### pythonのPATHを通す
export PATH=/usr/local/bin:/usr/local/share/python:$PATH
### pythonの設定
if [ -f ~/.bashrc ]; then
     . ~/.bashrc
fi
### FDKのPATHを通す
export PATH=PATH=~/bin/FDK/Tools/osx:$PATH
### git 助けて
export PATH=$HOME/git-tasukete:$PATH

