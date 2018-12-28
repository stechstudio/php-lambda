.DEFAULT_GOAL := all
SHELL := /bin/bash

compiler:
	cd ./compiler && docker build -t sts/lambda/compiler:latest --squash .

compiler_shell:
	docker run --interactive --tty -v ${PWD}:/host --entrypoint /bin/bash -e "TERM=xterm-256color" sts/lambda/compiler:latest

php:
	cd ./php && docker build -t sts/lambda/php:latest .

php_shell:
	docker run --interactive --tty -v ${PWD}:/host --entrypoint "/bin/bash" -e "TERM=xterm-256color" sts/lambda/php:latest

extensions:
	cd ./extensions && docker build -t sts/lambda/ext:latest .

extensions_shell:
	docker run --interactive --tty -v ${PWD}:/host --entrypoint "/bin/bash" -e "TERM=xterm-256color" sts/lambda/ext:latest

all: compiler_build php_build extension_build

clean:
	docker system prune -f