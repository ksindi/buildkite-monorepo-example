# set in buildkite agent
ifdef BUILDKITE_JOB_ID
export BUILD_GIT_TAG=bk${BUILDKITE_BUILD_NUMBER}
export JOB_ID:=${BUILDKITE_JOB_ID}
export COMPOSE_PROJECT_NAME:=${BUILDKITE_JOB_ID}
else
export JOB_ID:=local
export COMPOSE_PROJECT_NAME:=integration
endif

# avoid container name collision in agent nodes by suffixing with job id
ifdef app_name
export container_name=${app_name}-${JOB_ID}-c${BUILDKITE_PARALLEL_JOB}
endif

# PROJECT_NAME set by buildpipe
check-env:
ifndef PROJECT_NAME
	$(error PROJECT_NAME is undefined)
endif

# implemented in project
.PHONY: test

# implemented in project
.PHONY: local

# implemented in project and called by buildkite hook
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
	@echo "Deploying ${PROJECT_NAME} to $*"

# exit hook to remove unused networks
docker-network-prune:
	@docker network prune --force

generate-deploy-ssh-key:
	mkdir -p ~/buildkite-secrets/
	ssh-keygen -t rsa -b 4096 -N '' -C "deploy" -f ~/buildkite-secrets/id_rsa_buildkite_git
