# Avoid container name collision in agent nodes by suffixing with job id
ifdef app_name
export container_name=${app_name}-${JOB_ID}-c${BUILDKITE_PARALLEL_JOB}
endif

# Set in buildkite agent
ifdef BUILDKITE_JOB_ID
export BUILD_GIT_TAG=bk${BUILDKITE_BUILD_NUMBER}
export JOB_ID:=${BUILDKITE_JOB_ID}
export COMPOSE_PROJECT_NAME:=${BUILDPIPE_PROJECT_LABEL}-${BUILDKITE_JOB_ID}
else
export JOB_ID:=${app_name}-local
export COMPOSE_PROJECT_NAME:=integration
endif

# BUILDPIPE_PROJECT_LABEL set by buildpipe
check-env:
ifndef BUILDPIPE_PROJECT_LABEL
	$(error BUILDPIPE_PROJECT_LABEL is undefined)
endif

# Implemented in project
.PHONY: test

# Implemented in project
.PHONY: local

# Implemented in project and called by buildkite hook
.PHONY: clean

tag-release:
	(git tag ${BUILD_GIT_TAG} ${COMMIT} && git push origin ${BUILD_GIT_TAG}) || true

.PHONY: build
build:
	docker build ${extra_build_opts} --tag ${app_name} .

run-without-build:
	docker run --init -it --rm --name ${container_name} ${extra_run_opts} ${app_name} ${command} ${extra_args}

.PHONY: run
run: build run-without-build

deploy-%: check-env
	@echo "Deploying ${BUILDPIPE_PROJECT_LABEL} to $*"

# Exit hook to remove unused networks
docker-network-prune:
	@docker network prune --force

generate-deploy-ssh-key:
	ssh-keygen -t rsa -b 4096 -N '' -C "deploy" -f ~/.ssh/id_rsa_buildkite_git
