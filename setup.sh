#!/bin/bash -e

########################################
# Password                             #
########################################
printf "password: "
read password

########################################
# Commands                             #
########################################
has() {
  type "$1" > /dev/null 2>&1
}

########################################
# Vars                                 #
########################################
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_TARBALL="https://github.com/hi0711/dotfiles"
REMOTE_URL="https://github.com/hi0711/dotfiles.git"
VIM_RUNTIME="${HOME}/.vim_runtime"
NEOVIM_DIRECTORY="${HOME}/.config/nvim"

########################################
# Options                              #
########################################
while getopts :f:h opt; do
  case ${opt} in
    f)
      OVERWRITE=true
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

########################################
# Downloads                            #
########################################
if [ ! -d ${DOT_DIRECTORY} ] ; then
  echo "Downloading dotfiles..."
  rm -rf ${DOT_DIRECTORY}
  mkdir -v ${DOT_DIRECTORY}

  if type "git" > /dev/null 2>&1 ; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/dotfiles.tar.gz
  fi
  echo "$(tput setaf 2)Download dotfiles complete! :)$(tput sgr0)"
fi

########################################
# Deploy                               #
########################################
echo "Start Deploy ..."
cd ${DOT_DIRECTORY}
for f in .??*
do
  # ignore file & directory
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = "init.vim" ]] && continue
  [[ ${f} = "dein.toml" ]] && continue
  [[ ${f} = "dein_lazy.toml" ]] && continue
  [[ ${f} = ".Brewfile" ]] && continue

  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

if [ ! -d ${NEOVIM_DIRECTORY} ] ; then
  mkdir -p ${NEOVIM_DIRECTORY}/backup ${NEOVIM_DIRECTORY}/swap ${NEOVIM_DIRECTORY}/undo
  cp -fv ${HOME}/dotfiles/init.vim ${HOME}/.config/nvim
  cp -fv ${HOME}/dotfiles/dein.toml ${HOME}/.config/nvim
  cp -fv ${HOME}/dotfiles/dein_lazy.toml ${HOME}/.config/nvim
  cp -fv ${HOME}/dotfiles/.Brewfile ${HOME}/.Brewfile
fi
echo "$(tput setaf 2)Deploy dotfiles complete! :)$(tput sgr0)"

########################################
# Initialize                           #
########################################
echo "Start Initialize ..."
# homebrew settings
if has "brew" ; then
  echo "$(tput setaf 2)Already installed Homebrew :)$(tput sgr0)"
else
  echo "Installing Homebrew ..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew bundle --global
fi
if has "brew" ; then
  echo "Updating Homebrew ..."
  brew update && brew upgrade
fi
echo "$(tput setaf 2)Update Homebrew complete :)$(tput sgr0)"
# vim settings
if [ ! -d ${VIM_RUNTIME} ] ; then
  git clone --depth=1 git://github.com/amix/vimrc.git ${HOME}/.vim_runtime
  sh ${HOME}/.vim_runtime/install_basic_vimrc.sh
  echo "$(tput setaf 2)Initialize vim settings complete! :)$(tput sgr0)"
fi
# zsh settings
echo "$password" | sudo -S sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
echo "$password" | sudo -S chsh -s /usr/local/bin/zsh
echo "$(tput setaf 2)Initialize zsh settings complete! :)$(tput sgr0)"
# defaults settings
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g NSInitialToolTipDelay -integer 0
defaults write -g NSWindowResizeTime 0.1 
defaults write -g QLPanelAnimationDuration -float 0.15
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain InitialKeyRepeat -int 9
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO
defaults write NSGlobalDomain com.apple.springing.delay -float 0
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock mineffect suck
defaults write com.apple.finder AnimateInfoPanes -boolean false
defaults write com.apple.finder AnimateWindowZoom -bool false
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false 
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder QLHidePanelOnDeactivate -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true 
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "jpg"
defaults write com.apple.terminal StringEncodings -array 4
echo "$(tput setaf 2)Initialize defaults settings complete! :)$(tput sgr0)"

exit 0
