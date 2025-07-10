DOCKER_NAME    	= llvm
DOCKER_VERSION 	= 1.1
DOCKER_IMAGE   	= $(DOCKER_NAME):$(DOCKER_VERSION)

test: build
	./scripts/runtest.sh

build: config
	cmake --build ./build

clean:
	rm -rf build

config:
	@echo "Configure CMake"
	mkdir -p build
	#cmake -G Ninja .. -B build -S .
	cmake -G Ninja .. -B build -DCMAKE_BUILD_TYPE=Debug -S .

docker-build: ## Build docker
	@echo "Building Docker $(DOCKER_IMAGE)"
	docker build -t $(DOCKER_IMAGE) -f Dockerfile .

shell: ## Run container and enter with a bash shell
	docker run --rm \
	  -v "$(PWD):/work" \
	  -w /work -it $(DOCKER_IMAGE) bash

docker-stop: ## Stop and remove a running container
	-docker stop $(DOCKER_IMAGE)
	-docker rm -f $(DOCKER_IMAGE)

docker-size: ## Get the size of the Docker images
	@echo "Size of docker image $(DOCKER_IMAGE):"
	@docker images $(DOCKER_IMAGE) --format "{{.Size}}"