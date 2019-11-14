#!/bin/bash

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

DIR_NAME=${PWD##*/}
printf "Project name: ${DIR_NAME}\n\n"

# Set new empty posts directory
rm -rf _posts
mkdir _posts

# Set git init
rm -rf .git
git init 
# vi .git/config
git remote add origin git@github.com:datalater/${DIR_NAME}.git
printf "Git repository:\n"
git remote -v

# Set wiki title
# sed -i -e "s/Template Wiki/${DIR_NAME}/g" ./_config.yml
vi ./_config.yml

# Git initialize commit
git add --all # to match current working tree
git commit -m "Initialize repo" # first commit
git l # show log
