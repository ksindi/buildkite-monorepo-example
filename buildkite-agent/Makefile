app_name:=buildkite-agent

include ../Makefile

local:
	$(eval NUM_CORES:=$(shell python -c 'import multiprocessing as mp; print(mp.cpu_count())'))
	docker-compose up --build -d --scale bk-agent=${NUM_CORES}

clean:
	docker-compose down --remove-orphans || true
	docker network prune --force
