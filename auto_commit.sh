#!/bin/bash -ex

BRANCH_NAME='master'
branch=`git rev-parse --abbrev-ref HEAD` || exit

if [ ${branch} != ${BRANCH_NAME} ]; then
  echo "$(tput setaf 1)not master branch!$(tput sgr0)"
  sleep 3
  git stash && git checkout master && git stash pop
  git add .
else
  git add .
fi

echo "$(tput setaf 3)commit message:$(tput sgr0)"
read mess

case "$mess" in
  "") git commit -m "Updated files";;
  *) git commit -m $mess;;
esac

git push -u origin master
