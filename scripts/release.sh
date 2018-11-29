#!/usr/bin/env bash

set -eu

GIT_ROOT="$(git rev-parse --show-toplevel)"

cd $GIT_ROOT
echo "Checking out develop"
git checkout develop
echo "Get latest develop branch"
git pull origin develop
echo "Check if all submodules are tagged"
git submodule foreach --recursive \
bash -c 'if [ "$(git tag --contains)" == "" ]
then echo "Untagged submodule found. Please make sure all submodules are released" && exit 1
else echo "contains tag: $(git tag --contains)"'

echo "Merge develop into master"
git checkout master
git pull origin master
git merge origin/develop

