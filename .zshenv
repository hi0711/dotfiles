PATH=/usr/local/bin:$PATH
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
