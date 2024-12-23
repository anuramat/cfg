#!/usr/bin/env sh

__clean_style() {
	sed 's/,\?\s*color="[a-z]*",\?/,/'
}

__dot() {
	__clean_style | xargs -a "$XDG_CACHE_HOME/wallust/graphviz" dot -Tpng -Gdpi=300
}

deps() {
	make ${1:-root} -Bnd | make2graph | __dot | swayimg - -s fit
}
