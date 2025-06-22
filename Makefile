.PHONY: jammy kali noble rocky-9 alma-9 bookworm sid alpine-3 packages

# development
format:
	@shfmt -l -w .

packages:
	@python ./hack/packages.py $(shell pwd)/packages.yaml $(shell pwd)/.packages/

# ALPINE
alpine-3:
	@docker compose build --build-arg IMAGE=alpine:3 --build-arg SRC=alpine-3
	@docker compose up

# DEBIAN
bookworm:
	@docker compose build --build-arg IMAGE=debian:bookworm --build-arg SRC=bookworm
	@docker compose up

sid:
	@docker compose build --build-arg IMAGE=debian:sid --build-arg SRC=sid
	@docker compose up

kali:
	@docker compose build --build-arg IMAGE=kalilinux/kali-rolling:latest --build-arg SRC=kali
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
