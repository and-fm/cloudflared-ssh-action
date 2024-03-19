# Cloudflared SSH Remote Command Runner
A GitHub Action that runs a Docker container, which lets you SSH into a server behind a Cloudflare tunnel and run a command

## Updates
This repo is forked from [npgy/cloudflared-ssh-action](https://github.com/npgy/cloudflared-ssh-action) 

The Dockerfile has been updated to:
- Pull the _latest_ alpine image tag.
- Install the latest Cloudflare Tunnel (cloudflared) binary.
- Utilise [service tokens](https://developers.cloudflare.com/cloudflare-one/identity/service-tokens/) for authentication.

### PRs
Branch protection rules require a PR before code can be merged into _main_. The workflows will:
- Use the [Trivy scanner](https://github.com/aquasecurity/trivy) to check the image for vulnerabilities. If there's a High or Critical CVEs found in the image, the workflow will fail. \
- Dependabot will check upstream base Apline Linux image or Github Actions for updates. \
A successful merge into _main_ will update the _latest_ release and update the _latest_ tagged container image uploaded to GitHub Packages.

## Usage

Here is an example deploy.yaml file for the action:  
```yaml
name: Run command on remote server
on:
  pull_request:
    types:
      - closed
jobs:
  ssh:
    runs-on: ubuntu-latest
    steps:
    - name: SSH onto cloudflared server
      uses: nathanjnorris/cloudflared-ssh-action@latest
      with:
        host: ${{ secrets.SSH_HOST }}
        username: ${{ secrets.SSH_USERNAME }}
        private_key_filename: ${{ secrets.SSH_PRIVATE_KEY_FILENAME }}
        private_key_value: ${{ secrets.SSH_PRIVATE_KEY_VALUE }}
        port: ${{ secrets.SSH_PORT }}
        service_token_id: ${{ secrets.SERVICE_TOKEN_ID }}
        service_token_secret: ${{ secrets.SERVICE_TOKEN_SECRET }}
        commands: mkdir hello-world -v
```
