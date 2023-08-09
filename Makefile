.PHONY: check lua shell

check: lua shell

lua:
	luacheck . --globals=vim

shell:
	fd -0ug "**.sh" | xargs -0I{} sh -c 'echo "Checking {}" && shellcheck -o all {}'
