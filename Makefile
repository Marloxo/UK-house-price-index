# Usage:
# make          # setup packages and install required dependencies
# make build    # build app docker image
# make start    # start and run app docker compose
# make run      # ssh into docker container and run app
# make db       # ssh into docker container and connect to db
# make test     # run unittest
# make stop     # switch off docker compose

SHELL := /bin/bash

.PHONY: all build start run db stop

all: build start run

build:
	@docker build --pull --no-cache -t gcr.io/bigpay/app:latest .

start:
	@docker-compose build --no-cache && docker-compose up -d --force-recreate

run:
	@docker exec -it bigpay-app-1 bash -c "poetry run python3 main.py"

db:
	@docker exec -it bigpay-db-1 bash -c "psql -U postgres -d reporting"

test:
	@docker exec -it bigpay-app-1 bash -c "poetry run python3 -m unittest discover -s /tests -p '*_test*.py' -v"

stop:
	@docker-compose down
