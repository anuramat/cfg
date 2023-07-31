.PHONY: check

check:
	luacheck . --globals=vim
