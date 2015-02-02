# brew cask省略
alias cask="brew cask"
# rm -rfコマンド省略
alias rmdir='rm -rf'
# ディレクトリを一つ上の階層に
alias up="cd ..; ls -l"
# ターミナルからfinderを開く
alias f="open ."
# desktopディレクトリに移動
alias desktop='cd ~/desktop'
# homeディレクトリに移動
alias home='cd ~'
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
