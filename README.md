# Buildpipe Monorepo Example

Example monorepo using buildkite tool [buildpipe](https://github.com/ksindi/buildpipe/).

The monorepo config lives in [buildpipe.yml](https://github.com/ksindi/buildpipe-monorepo-example/blob/master/buildpipe.yml).
You can see there are 3 projects defined and deploy steps only happen during Eastern time business hours.

## Getting started

### Create Buildkite pipeline
1. Create a pipeline adding the following initial buildpipe step:
![Create pipeline](images/0-create-pipeline.png)

### Add deploy key to Github
1. Generate deploy key and change permission:
    ```bash
    make generate-deploy-ssh-key
    chmod 600 ~/buildkite-secrets/id_rsa_buildkite_git
    ```
1. Add the public key `~/buildkite-secrets/id_rsa_buildkite_git.pub` to your Github repo under Settings > Deploy keys.
![Add deploy key](images/1-add-deploy-key.png)
1. Run the buildkite agents locally:
    ```bash
    export BUILDKITE_AGENT_TOKEN=<token>

    # Start ssh agent in the background
    eval "$(ssh-agent -s)"

    # Add key
    ssh-add ~/buildkite-secrets/id_rsa_buildkite_git

    # Run agent in a docker container scaled to the number of cpus
    make local
    ```
You should see the number of agents at the top bar in buildkite appear

## Examples
1. Updating primer project in master only triggers the primer pipeline to run
![Add deploy key](images/2-update-primer.png)
2. Updating both primer and hubots projects in master triggers both pipelines
![Add deploy key](images/3-update-primer-and-hubot.png)
