set -eu

GIT_ROOT="$(git rev-parse --show-toplevel)"
cd $GIT_ROOT

# Determine the version
BRANCH="$(git branch | grep \* | cut -d ' ' -f2)"
if [ "${BRANCH}" == 'develop' ]
  then
    VERSION='develop'
  else
    VERSION=v`cat VERSION`
fi

# Checkout gh-pages and pull the docs over from the original branch
git checkout gh-pages
git checkout $BRANCH -- docs

# Rename the docs to the version
if [ -d "${VERSION}" ]
  then
    rm -r $VERSION
fi
mv docs $VERSION

# Adjust the config if necessary
echo "set version '${VERSION}' to latest?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sed -i "s/latest: .*/latest: ${VERSION}/" _config.yml; break;;
        No ) break;;
    esac
done
grep 'latest:' < _config.yml;

# commit and push
git add ${VERSION}/* _config.yml docs/*
git commit -m "update documention for version ${VERSION}"
# git push origin gh-pages #FIXME uncomment 

# switch back to $BRANCH
git checkout $BRANCH
