CP_NAME ?= opensips_cp
CP_TAG ?= dave

all: build start

.PHONY: build start
build:
	docker build \
		--tag="$(CP_NAME):$(CP_TAG)" \
		.

start:
	docker run -d --name $(CP_NAME) -p 80:80 $(CP_NAME):$(CP_TAG)
