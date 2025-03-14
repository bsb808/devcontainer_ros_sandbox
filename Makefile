# Make file used as aliases for docker commands

SHELL := /bin/bash

.PHONY: config-xauth 

DOCKERFILE := ./Dockerfile
COMPOSE := ./docker-compose.yml
TAG := humble

build:
	@echo "Building container..."
	docker build --tag $(TAG) --ssh=default .

# Build image from scratch - will always rebuild entire image
build-force:
	docker build --no-cache --tag $(TAG) --ssh=default $(DOCKERFILE)

# TODO: Build image with cache busting
build-update:
	docker build --build-arg CACHE_BUST=$(date +%s) --tag $(TAG) --ssh=default  .

# Configure xauth for Docker
config-xauth:
	@echo "Configuring xauth..."
	./docker_xauth.sh

# Start Yogi container in detached mode
compose-up: config-xauth
	@echo "Starting Yogi container..."
	docker compose -f $() up --remove-orphans --detach interactive

# Join the running Yogi container
compose-yogi-join:
	docker compose -f $(YOGI_COMPOSE) exec interactive bash

# Stop and remove Yogi container
compose-yogi-down:
	@echo "Stopping Yogi container..."
	docker compose -f $(YOGI_COMPOSE) down --remove-orphans
