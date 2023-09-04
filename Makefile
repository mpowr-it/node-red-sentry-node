.SILENT:

PROJECT = node-red-sentry-node
DOCKER_COMPOSE_OPTIONS = -p $(PROJECT) -f docker-compose.yml
DOCKER_COMPOSE_BASE_COMMAND = CURRENT_UID="$$(id -u):$$(id -g)" docker-compose $(DOCKER_COMPOSE_OPTIONS)
DOCKER_COMPOSE_EXEC_COMMAND = $(DOCKER_COMPOSE_BASE_COMMAND) exec
DOCKER_COMPOSE_RUN_COMMAND = $(DOCKER_COMPOSE_BASE_COMMAND) run --rm
DOCKER_COMPOSE_ISOLATED_RUN_COMMAND = $(DOCKER_COMPOSE_BASE_COMMAND) run --rm --no-deps

CONSOLE_VERBOSITY = -v

## Install whole setup & start docker-compose environment
serve: dcbuild dcpull dcup
	$(DOCKER_COMPOSE_EXEC_COMMAND) -w /data node-red npm install /repo
	open http://localhost:1880
.PHONY: serve

## Stop the whole docker-compose environment
stop: dcdown
.PHONY: stop

## Run all static code analysers and tests
test:
	npm ci
	npm run build --if-present
	npm test
.PHONY: test

## Start docker-compose services
dcup:
	$(DOCKER_COMPOSE_BASE_COMMAND) up -d --force-recreate
.PHONY: dcup

## Stop docker-compose services
dcdown:
	$(DOCKER_COMPOSE_BASE_COMMAND) down --remove-orphans
.PHONY: dcdown

## Pull all docker images for current compose-project
dcpull:
	$(DOCKER_COMPOSE_BASE_COMMAND) pull
.PHONY: dcpull

## Build all docker images for current compose-project
dcbuild:
	COMPOSE_DOCKER_CLI_BUILD=1 \
	DOCKER_BUILDKIT=1 \
	$(DOCKER_COMPOSE_BASE_COMMAND) build --pull --parallel
.PHONY: dcbuild

## Show container status for current compose-project
dcps:
	$(DOCKER_COMPOSE_BASE_COMMAND) ps
.PHONY: dcps

## Show docker images for current compose-project
dcimages:
	$(DOCKER_COMPOSE_BASE_COMMAND) images
.PHONY: dcimages

## Show docker logs for a service in the current compose-project
dclogs:
	printf "\n\e[33mService?\e[0m\n> "; \
	read SERVICE; \
	$(DOCKER_COMPOSE_BASE_COMMAND) logs -f "$$SERVICE"
.PHONY: dclogs

## Log into a container of the current compose-project
dclogin:
	printf "\n\e[33mService?\e[0m\n> "; \
	read SERVICE; \
	$(DOCKER_COMPOSE_EXEC_COMMAND) "$$SERVICE" sh
.PHONY: dclogin

## This help screen
help:
	printf "Available commands\n\n"
	awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "\033[33m%-25s\033[0m %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
.PHONY: help