.PHONY: container
container:
	@docker build --progress plain . -t junkos-builder:latest

.PHONY: shell
shell:
	echo docker container run --privileged --rm -it -v "$(git rev-parse --show-toplevel)":/junkos junkos-builder:latest bash