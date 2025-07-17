.PHONY: docs jammy noble rocky-9 alma-9 bookworm packages

# documentation
docs:
	.venv/bin/mkdocs serve

# development
format:
	@shfmt -l -w .

packages:
	@python ./hack/packages.py $(shell pwd)/packages.yaml $(shell pwd)/.packages/

build-all:
	@docker build . --build-arg IMAGE=alpine:3 --build-arg SRC=alpine-3 -t alpine-3
	@docker build . --build-arg IMAGE=debian:bookworm --build-arg SRC=bookworm -t bookworm
	@docker build . --build-arg IMAGE=debian:sid --build-arg SRC=sid -t sid
	@docker build . --build-arg IMAGE=kalilinux/kali-rolling:latest --build-arg SRC=kali -t kali
	@docker build . --build-arg IMAGE=ubuntu:jammy --build-arg SRC=jammy -t jammy
	@docker build . --build-arg IMAGE=ubuntu:noble --build-arg SRC=noble -t noble
	@docker build . --build-arg IMAGE=rockylinux:9 --build-arg SRC=rocky-9 --build-arg RHEL=true -t rocky-9
	@docker build . --build-arg IMAGE=almalinux:9 --build-arg SRC=alma-9 --build-arg RHEL=true -t alma-9

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
