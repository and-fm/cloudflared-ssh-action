#!/bin/sh -l

echo "Host $1" >> /root/.ssh/config
echo "ProxyCommand cloudflared access ssh --hostname %h" >> /root/.ssh/config
echo "$4" > /root/.ssh/key.pem
chmod 600 /root/.ssh/key.pem

ssh-keyscan $1 >> /root/.ssh/known_hosts

ssh -o StrictHostKeyChecking=no $3@$1

ssh -tt -i /root/.ssh/key.pem $3@$1 -p $2 "$5"
