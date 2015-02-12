PATH=/usr/local/bin:$PATH
### rbenvのPATHを通す
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
### nodebrewのPATHを通す
export PATH="$HOME/.nodebrew/current/bin:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
### alias設定
source ~/.bashrc
