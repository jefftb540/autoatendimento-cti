#check if docker compose or docker-compose
DOCKER_COMPOSE:="$(shell which docker-compose || echo 'docker compose')"
DOCKER_COMPOSE_API:=$(DOCKER_COMPOSE) run api 
DOCKER_COMPOSE_CLIENT:=$(DOCKER_COMPOSE) run client
AUTOATENDIMENTO_GITHUB_URL:=https://github.com/jefftb540/autoatendimento.git
API_GITHUB_URL:=https://github.com/jefftb540/api-autoatendimento.git

.PHONY: run-all
run-all: download install-packages migrations run

.PHONY: start-all
start-all: download install-packages migrations start

.PHONY: download
download:
	test -d api-autoatendimento || git clone $(API_GITHUB_URL)

.PHONY: install-packages
install-packages:
	$(DOCKER_COMPOSE_API) npm install

.PHONY: migrations
migrations:
	$(DOCKER_COMPOSE_API) npm run migrate
	$(DOCKER_COMPOSE_API) npm run seed 

.PHONY: run
run:
	$(DOCKER_COMPOSE) up -d

.PHONY: stop
stop:
	$(DOCKER_COMPOSE) down

.PHONY: start
start:
	$(DOCKER_COMPOSE) up

.PHONY: rebuild-client
rebuild-client:
	$(DOCKER_COMPOSE) build --no-cache

.PHONY: clean-git
clean-git:
	@rm -rf autoatendimento/
	@rm -rf api-autoatendimento/

.PHONY: clean-db-dev-environment
clean-db-dev-environment:
	@rm -rf banco/
