KEY=$PRIV_KEY

echo "hello"

mkdir -p /root/.ssh
echo "$KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/

GIT_SSH_COMMAND="ssh -v"
