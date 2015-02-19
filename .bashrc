# エイリアス
alias cask='brew cask'
alias rmdir='rm -rf'
alias up='cd ..; ls -l'
alias f='open .'
alias desktop='cd ~/desktop'
alias home='cd ~'
alias la='ls -a'
alias pw='pwgen -y'
# finderで開いているディレクトリに移動
cdf () {
        target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
        if [ "$target" != "" ]
        then
                cd "$target"
                pwd
        else
                echo 'No Finder window found' >&2
        fi
}
# git関連コマンド
alias gad='git add'
alias gco='git commit'
alias gpl='git pull'
alias glo='git log'
alias gbr='git branch'
alias gch='git checkout'
alias gme='git merge'
alias gbr='git branch'
alias gfe='git fetch'
alias gdi='git diff'
alias gst='git status'
alias gin='git init'
# virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
