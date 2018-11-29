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
bash -c 'if [ "$(git tag --contains)" == "" ] ; \
then echo "Untagged submodule found. Please make sure all submodules are released. Aborting release procedure." && exit 1 ;\
else echo "contains tag: $(git tag --contains)" ;\
fi'
echo "Merge develop into master"
git checkout master
git pull origin master
git merge origin/develop
CURRENT_VERSION="$(cat VERSION)"
echo "Version to be released = $CURRENT_VERSION"
RELEASE_TAG="v$CURRENT_VERSION"
echo "Tagging release: $RELEASE_TAG"
git tag -a $RELEASE_TAG
