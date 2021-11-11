#!/bin/sh

set -e

echo "git-mirror.sh"
# SOURCE_REPO="git@github.com:freefq/free.git"

SOURCE_REPO="git@github.com:wearerequired/git-mirror-action.git"
DESTINATION_REPO="git@gitee.com:talking-toaster/we.git"
SOURCE_DIR=$(basename "$SOURCE_REPO")

GIT_SSH_COMMAND="ssh -v"

echo "SOURCE=$SOURCE_REPO"
echo "DESTINATION=$DESTINATION_REPO"

git clone --mirror "$SOURCE_REPO" "$SOURCE_DIR" && cd "$SOURCE_DIR"
git remote set-url --push origin "$DESTINATION_REPO"
git fetch -p origin
# Exclude refs created by GitHub for pull request.
git for-each-ref --format 'delete %(refname)' refs/pull | git update-ref --stdin
git push --mirror