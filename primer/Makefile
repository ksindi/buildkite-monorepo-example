app_name:=primer

include ../Makefile

test: command=pytest --cov=${app_name} --cov-report term-missing
test: run

local: extra_run_opts=-p 3000:3000
local: command=gunicorn -c gunicorn_config.py --log-level debug app:app
local: run

clean:
	@echo "Some clean job like docker-compose kill or removing artifacts"
