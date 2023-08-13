#!/bin/sh -l

echo "Host $1" >> /root/.ssh/config
echo "ProxyCommand cloudflared access ssh --hostname %h" >> /root/.ssh/config
echo $4 >> /root/.ssh/key.pem

ssh -o StrictHostKeyChecking=no $3@$1 uptime
ssh -i /root/.ssh/key.pem $3@$1 -p $2 "$5"