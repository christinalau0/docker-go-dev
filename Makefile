VERSION ?= 1.34.7.1
REGISTRY ?= jadarsie.azurecr.io/
IMAGE_PREFIX ?= aks-engine-azurestack
IMAGE := ${REGISTRY}${IMAGE_PREFIX}/go-dev:${VERSION}

# scripts are checked *after* build, so use paths inside the container
SHELL_SCRIPTS = /usr/local/bin/test-cover.sh

# dockerized development environment variables
DEV_ENV_PREFIX := docker run --rm
DEV_ENV_CMD := ${DEV_ENV_PREFIX} ${IMAGE}

info:
	@echo "REGISTRY: ${REGISTRY}"
	@echo "VERSION:  ${VERSION}"
	@echo "IMAGE:    ${IMAGE}"

build:
	docker build -t ${IMAGE} rootfs

push: build
	docker push ${IMAGE}

test: build
	${DEV_ENV_CMD} shellcheck $(SHELL_SCRIPTS)
