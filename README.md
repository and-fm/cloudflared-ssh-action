# Cloudflared SSH Remote Command Runner
A GitHub action that lets you SSH into a server behind a Cloudflare tunnel and run a command

# Updates
This repo is forked from [npgy/cloudflared-ssh-action](https://github.com/npgy/cloudflared-ssh-action)
- The Dockerfile has been updated to:
- Pull the 'latest' alpine image tag
- Download the latest Cloudflare Tunnel (cloudflared) binary

## Usage

Here is an example deploy.yaml file for the action:  
```yaml
name: Pull down and compose up
on: [push]
jobs:

  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
    - name: connect to remote server
      uses: nathanjnorris/cloudflared-ssh-action@v1.0
      with:
        host: ${{ vars.HOST }}
        username: ${{ secrets.USERNAME }}
        private_key: ${{ secrets.PRIVKEY }}
        port: ${{ secrets.PORT }}
        commands: cd repo_dir; git pull; /usr/local/bin/docker compose up --build -d
```
