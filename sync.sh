# set -e

KEY=$PRIV_KEY



echo "start"
echo pwd
echo ls
mkdir -p  ~/.ssh
sudo echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

