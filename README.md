# buildpipe-monorepo-example

Example monorepo using [buildpipe](https://github.com/ksindi/buildpipe/)

The monorepo config lives in [buildpipe.yml](https://github.com/ksindi/buildpipe-monorepo-example/blob/master/buildpipe.yml).
You can see there are 3 projects defined.

## Set up

1. Generate deploy key:
    ```bash
    make generate-deploy-ssh-key
    ```
1. Add the public key your Github repo under Settings > Deploy keys.
1. Run the agents:
    ```bash
    export BUILDKITE_AGENT_TOKEN=<token>

    # Start ssh agent in the background
    eval "$(ssh-agent -s)"

    # Add key
    ssh-add ~/buildkite-secrets/id_rsa_buildkite_git

    # Run agent in a docker container scaled to the number of cpus
    make local
    ```
