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
    - name: Connect to remote server, run command
      uses: nathanjnorris/cloudflared-ssh-action@latest
      with:
        host: ${{ secrets.SSH_HOST }}
        username: ${{ secrets.SSH_USERNAME }}
        private_key_filename: ${{ secrets.SSH_PRIVATE_KEY }}
        private_key_value: ${{ secrets.SSH_PRIVATE_KEY }}
        port: ${{ secrets.SSH_PORT }}
        commands: mkdir hello-world -v
        service_token_id: ${{ secrets.SERVICE_TOKEN_ID }}
        service_token_secret: ${{ secrets.SERVICE_TOKEN_SECRET }}
```
