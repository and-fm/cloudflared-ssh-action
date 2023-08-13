#!/bin/sh -l

echo "Host $1" >> /root/.ssh/config
echo "ProxyCommand cloudflared access ssh --hostname %h"
echo $4 > key.pem

ssh -i key.pem $3@$1 -p $2 "$5"