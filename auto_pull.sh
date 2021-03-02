#!/bin/bash -ex

git pull
/bin/cp -vpf ./dein.toml ./init.vim $HOME/.config/nvim
/bin/ln -f ./changelog.config.js ~/changelog.config.js
