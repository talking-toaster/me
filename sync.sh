KEY=$PRIV_KEY

echo "hello"

sudo mkdir -p /root/.ssh
sudo echo "$KEY" > /root/.ssh/id_rsa
sudo chmod 600 /root/.ssh/id_rsa
mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/

GIT_SSH_COMMAND="ssh -v"
