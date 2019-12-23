#!/bin/bash -ex

BRANCH_NAME='master'

branch=`git rev-parse --abbrev-ref HEAD` || exit

if [ $# != 1 ]; then
  if [ ${branch} = ${BRANCH_NAME} ]; then
    git add .
    git commit -m "updated files"
    git push -u origin master
  else
    echo "$(tput setaf 2)not master branch!$(tput sgr0)"
    git checkout master
    git add .
    git commit -m "updated files"
    git push -u origin master
  fi
else
  if [ ${branch} = ${BRANCH_NAME} ]; then
    git add .
    git commit -m $1
    git push -u origin master
  else
    echo "$(tput setaf 2)not master branch!$(tput sgr0)"
    git checkout master
    git add .
    git commit -m $1
    git push -u origin master
  fi
fi
