# Cloudflared SSH Remote Command Runner

A GitHub Action that runs a Docker container, which lets you SSH into a server behind a Cloudflare Tunnel and run a command

## Inputs

The following inputs can be used as `step.with` keys:

| Name                   | Type   | Default | Required | Description                                                             |
| ---------------------- | ------ | ------- | -------- | ----------------------------------------------------------------------- |
| `host`                 | String |         | `true`   | Tunnel address of the server you are connecting to                      |
| `port`                 | int    | `22`    | `true`   | SSH port                                                                |
| `username`             | String |         | `true`   | SSH username                                                            |
| `private_key_filename` | String |         | `true`   | Name of the private key file (used only in the action runner execution) |
| `private_key_value`    | String |         | `true`   | The actual SSH private key to authenticate to your server               |
| `commands         `    | List   |         | `true`   | The list of commands you want to execute on the remote server           |
| `service_token_id`     | String |         | `false`  | The Cloudflare Zero Trust Service Token ID (optional)                   |
| `service_token_secret` | String |         | `false`  | The Cloudflare Zero Trust Service Token Secret (optional)               |

For more info on service tokens, check this documentation: https://developers.cloudflare.com/cloudflare-one/identity/service-tokens/

## Updates

This repo is forked from [npgy/cloudflared-ssh-action](https://github.com/npgy/cloudflared-ssh-action)

The Dockerfile has been updated to:

- Pull the _latest_ alpine image tag.
- Install the latest Cloudflare Tunnel (cloudflared) binary.
- Utilise [service tokens](https://developers.cloudflare.com/cloudflare-one/identity/service-tokens/) for authentication, for SSH servers secured by [Cloudflare Access policies](https://developers.cloudflare.com/cloudflare-one/policies/access/).
- Utilise Dependabot to alert if this code depends on a package with a security vulnerability.

The updates are intended to

## Workflows

Branch protection rules require a PR before code can be merged into _main_. There are two PR workflows:

- Dependency review will check upstream base Apline Linux image or Github Actions for updates. If there are High or Critical vulnerabilities found in feature branch, the workflow will fail.
- [Trivy scanner](https://github.com/aquasecurity/trivy) will check the built Docker image for vulnerabilities. If there's a High or Critical CVEs found in the image, the workflow will fail.

A successful merge into _main_ will update the _latest_ release and update the _latest_ tagged container image uploaded to GitHub Packages.

## Contributions

Any help keeping this repo healthy and secure would be appreciated! \
Remaining in my to-do is automating semantic version releases in case users need to rollback to older, stable versions. \
This action is now meeting my project's needs, so I won't be releasing further updates unless required.

## Usage

Here is an example deploy.yaml file for the action:

```yaml
name: Run command on remote server
on:
  pull_request:
    types:
      - closed
jobs:
  ssh_command:
    if: github.event.pull_request.merged == true
    name: Run SSH command
    needs: terraform_apply
    runs-on: ubuntu-latest
    steps:
      - name: Connect and run command on remote server
        uses: and-fm/cloudflared-ssh-action@v3.0
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

## Big Thanks To:

[Nathan J Norris](https://github.com/nathanjnorris) for improving the maintanability and security of the project
