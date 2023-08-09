.PHONY: check lua shell

check: lua shell

lua:
	luacheck . --globals=vim

shell:
	fd -ug "**.sh" --color=never | xargs shellcheck 
