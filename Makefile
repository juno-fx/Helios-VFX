.PHONY: docs jammy noble rocky-9 alma-9 bookworm packages

# documentation
docs:
	.venv/bin/mkdocs serve

# development
format:
	@shfmt -l -w .

packages:
	@python ./hack/packages.py $(shell pwd)/packages.yaml $(shell pwd)/.packages/

# DEBIAN
bookworm:
	@docker compose build --build-arg IMAGE=debian:bookworm --build-arg SRC=bookworm
	@docker compose up

# UBUNTU
jammy:
	@docker compose build --build-arg IMAGE=ubuntu:jammy --build-arg SRC=jammy
	@docker compose up

noble:
	@docker compose build --build-arg IMAGE=ubuntu:noble --build-arg SRC=noble
	@docker compose up

# RHEL
rocky-9:
	@docker compose build --build-arg IMAGE=rockylinux:9 --build-arg SRC=rocky-9 --build-arg RHEL=true
	@docker compose up

alma-9:
	@docker compose build --build-arg IMAGE=almalinux:9 --build-arg SRC=alma-9 --build-arg RHEL=true
	@docker compose up
