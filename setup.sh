#!/bin/bash
set -e

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

  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

if [ ! -d ${NEOVIM_DIRECTORY} ] ; then
  mkdir -p ${NEOVIM_DIRECTORY}/backup ${NEOVIM_DIRECTORY}/swap ${NEOVIM_DIRECTORY}/undo
  ln -fv ${HOME}/dotfiles/init.vim ${HOME}/.config/nvim
  ln -fv ${HOME}/dotfiles/dein.toml ${HOME}/.config/nvim
  ln -fv ${HOME}/dotfiles/dein_lazy.toml ${HOME}/.config/nvim
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
  brew bundle
fi
if has"brew" ; then
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
# node install
if has "ndenv" ; then
  lts=`ndenv install -ls | grep v10. | tail -n 1`
  ndenv install ${lts}
  ndenv global ${lts}
fi
echo "$(tput setaf 2)Initialize ndenv settings complete! :)$(tput sgr0)"
# key repeat
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 9

exit 0
