#!/usr/bin/env sh
deps() {
	make root -Bnd | make2graph | dot -Tpng -Gdpi=300 | swayimg - -s fit
}
