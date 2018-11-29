#!/usr/bin/env bash

set -eu

GIT_ROOT="$(git rev-parse --show-toplevel)"

# CHECKING OUT LATEST VERSION OF DEVELOP
cd $GIT_ROOT
echo "Checking out develop"
git checkout develop
echo "Get latest develop branch"
git pull origin develop

# CHECKING IF PIPELINE IS READY FOR RELEASE
echo "Check if all submodules are tagged"
git submodule foreach --recursive \
bash -c 'if [ "$(git tag --contains)" == "" ] ; \
then echo "Untagged submodule found. Please make sure all submodules are released. Aborting release procedure." && exit 1 ;\
else echo "contains tag: $(git tag --contains)" ;\
fi'
# TODO: Add command that does a quick test of the pipeline.
# Womtool validate maybe?

# MERGING INTO MASTER
echo "Merge develop into master"
git checkout master
git pull origin master
git merge origin/develop

# SET RELEASE VERSION
CURRENT_VERSION="$(cat VERSION)"
echo "Version to be released = $CURRENT_VERSION"
RELEASE_TAG="v$CURRENT_VERSION"
echo "Tagging release: $RELEASE_TAG"
git tag -a $RELEASE_TAG

echo "Tagging successfull"
echo "push release to remote repository?"

select yn in "Yes" "No"; do
    case $yn in
        Yes ) git push origin master && git push origin $RELEASE_TAG; break;;
        No ) echo "release aborted" && exit 1;;
    esac
done

