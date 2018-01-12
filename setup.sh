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
if [ ! -d ${DOT_DIRECTORY} ]; then
  echo "Downloading dotfiles..."
  rm -rf ${DOT_DIRECTORY}
  mkdir -v ${DOT_DIRECTORY}

  if type "git" > /dev/null 2>&1; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/dotfiles.tar.gz
  fi
  echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
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
  mkdir -p ${NEOVIM_DIRECTORY}
  ln -fv ${HOME}/dotfiles/init.vim ${HOME}/.config/nvim
  ln -fv ${HOME}/dotfiles/dein.toml ${HOME}/.config/nvim
  ln -fv ${HOME}/dotfiles/dein_lazy.toml ${HOME}/.config/nvim
done
echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)

########################################
# Initialize                           #
########################################
echo "Start Initialize ..."
# vim settings
if [ ! -d ${VIM_RUNTIME} ]; then
  git clone --depth=1 git://github.com/amix/vimrc.git ${HOME}/.vim_runtime
  sh ${HOME}/.vim_runtime/install_basic_vimrc.sh
  echo $(tput setaf 2)Initialize vim settings complete!. ✔︎$(tput sgr0)
fi

# neovim settings
mkdir -p ${NEOVIM_DIRECTORY}/backup
mkdir -p ${NEOVIM_DIRECTORY}/swap
mkdir -p ${NEOVIM_DIRECTORY}/undo
echo $(tput setaf 2)Initialize neovim settings complete!. ✔︎$(tput sgr0)

# zsh settings
echo "$password" | sudo -S sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
echo "$password" | sudo -S chsh -s /usr/local/bin/zsh
echo $(tput setaf 2)Initialize zsh settings complete!. ✔︎$(tput sgr0)

exit 0
