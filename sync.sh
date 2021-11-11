# set -e

KEY=$PRIV_KEY



echo "start"
echo `pwd`
echo `ls`
mkdir -p  ~/.ssh
echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa


#echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

SOURCE_DIR=$(basename "$SOURCE_REPO")
git clone --mirror "git@github.com:freefq/free.git" "git@gitee.com:talking-toaster/we.git" && cd "$SOURCE_DIR"

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