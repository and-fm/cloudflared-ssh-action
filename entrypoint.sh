#!/bin/sh -l

echo "Host $1" >> /root/.ssh/config
echo "ProxyCommand cloudflared access ssh --hostname %h --id $6 --secret $7" >> /root/.ssh/config
echo "$4" > /root/.ssh/id_ed25519
chmod 600 /root/.ssh/id_ed25519

ssh-keyscan $1 >> /root/.ssh/known_hosts

ssh -o StrictHostKeyChecking=no $3@$1

ssh -i /root/.ssh/id_ed25519 $3@$1 -p $2 "$5"
