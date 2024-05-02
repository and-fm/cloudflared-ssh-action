#!/bin/sh -l

echo "Host $1" >> /root/.ssh/config

if [ -z $7 ] && [ -z $8 ]
then
    echo "ProxyCommand cloudflared access ssh --hostname %h >> /root/.ssh/config
else
    echo "ProxyCommand cloudflared access ssh --hostname %h --id $7 --secret $8" >> /root/.ssh/config
fi

echo "$5" > /root/.ssh/key.pem
chmod 600 /root/.ssh/key.pem

ssh-keyscan $1 >> /root/.ssh/known_hosts

ssh -T -q -o StrictHostKeyChecking=no $3@$1

ssh -i /root/.ssh/key.pem $3@$1 -p $2 "$6"