FROM alpine:3.10

RUN apk update
RUN apk add openssh
RUN apk add curl
RUN curl -L https://github.com/cloudflare/cloudflared/releases/download/2023.7.3/cloudflared-linux-amd64 -o /usr/bin/cloudflared
RUN chmod +x /usr/bin/cloudflared

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]