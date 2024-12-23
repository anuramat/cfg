#!/usr/bin/env sh

__dot() {
	xargs -a "$XDG_CACHE_HOME/wallust/graphviz" dot -Tpng -Gdpi=300
}

deps() {
	make ${1:-root} -Bnd | make2graph | __dot | swayimg - -s fit
}
