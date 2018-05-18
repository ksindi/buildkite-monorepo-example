app_name:=buildkite-agent

include ../Makefile

local:
	$(eval NUM_CORES:=$(shell python -c 'import multiprocessing as mp; print(mp.cpu_count())'))
	docker-compose up --build -d --scale bk-agent=${NUM_CORES}
