!#/usr/bush

set -e

KEY=$PRIV_KEY

echo "start"

mkdir -p /root/.ssh
echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
