# set -e

KEY=$PRIV_KEY



echo "start"
pwd
ls
chmod 777 /root
mkdir -p /root/.ssh
echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true
