.DEFAULT_GOAL := make_all
SHELL := /bin/bash

compiler_build:
	cd ./compiler && docker build -t sts/lambda/compiler:latest --squash .

compiler_shell:
	docker run --interactive --tty --entrypoint /bin/bash -e "TERM=xterm-256color" sts/lambda/compiler:latest

php_build:
	cd ./php && docker build -t sts/lambda/php:latest .

php_shell:
	docker run --interactive --tty --entrypoint "/bin/bash" -e "TERM=xterm-256color" sts/lambda/php:latest

extension_build:
	cd ./extension

make_all:
