#!/usr/bin/env bash
PROJECT_PATH=$1
REPO_NAME=$2
DESCRIPTION=$3
if [[ -z "$PROJECT_PATH" ]]
then
    echo "PROJECT_PATH variable is empty. Exiting." && exit
elif [[ -z "$REPO_NAME" ]]
then
    echo "REPO_NAME variable is empty. Exiting." && exit
elif [[ -z "$DESCRIPTION" ]]
then
    echo "DESCRIPTION variable is empty. Exiting." && exit
fi

USERNAME=$(grep 'name' ~/.gitconfig | sed 's/^.*= //')
cd $PROJECT_PATH
mkdir $REPO_NAME
cd $REPO_NAME
# Move go directory, and environment paths, to under code, and retrieve language name to create a gitignore
git init
touch README.MD
git add .
git commit -m 'initial commit by gpi'

gh api \
--method POST \
-H "Accept: application/vnd.github+json" \
/user/repos \
-f name="$REPO_NAME" \
-f description="$DESCRIPTION" \
-F private=true \

git remote add origin https://github.com/${USERNAME}/${REPO_NAME}.git
git push --set-upstream origin main
