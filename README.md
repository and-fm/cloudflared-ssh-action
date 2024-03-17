# Cloudflared SSH Remote Command Runner
A GitHub Action that runs a Docker container, which lets you SSH into a server behind a Cloudflare tunnel and run a command

## Updates
This repo is forked from [npgy/cloudflared-ssh-action](https://github.com/npgy/cloudflared-ssh-action) 

The Dockerfile has been updated to:
- Pull the 'latest' alpine image tag
- Download the latest Cloudflare Tunnel (cloudflared) binary 

### PRs
Branch protection rules require a PR before code can be merged to main. \
The PR workflow in this repo also uses the [Trivy scanner](https://github.com/aquasecurity/trivy) to check the iamge for vulnerabilities. \
If there's a Critical or High CVE found in the image, the PR workflow will fail. \
Daily, dependabot will check upstream base Apline Linux image or Github Actions have been updated, and raise PRs. \
A successful merge into main will update the 'latest' tagged image uploaded to GitHub Packages.

## Usage

Here is an example deploy.yaml file for the action:  
```yaml
name: SSH on cloudflared remote server
on:
  pull_request:
    types:
      - closed
jobs:
  deploy:
    name: Run SSH command
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
