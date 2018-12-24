SHELL := /bin/bash
.DEFAULT_GOAL := make_pango

url_pango = https://download.gnome.org/sources/pango/${VERSION_PANGO_SHORT}/pango-${VERSION_PANGO}.tar.xz
build_dir_pango = ${DEPS}/pango

fetch_pango:
	mkdir -p ${build_dir_pango}
	${CURL} -Ls ${url_pango} | tar $(shell ${TARGS} ${url_pango}) ${build_dir_pango} --strip-components=1

configure_pango:
	cd ${build_dir_pango} && \
	${MESON} _build . \
        --prefix=${TARGET} \
		--sysconfdir=${TARGET}/etc \
		-Dgir=false

build_pango:
	cd ${build_dir_pango}/_build && \
	${NINJA} && \
	${NINJA} install

version_pango:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg pango${VERSION_PANGO} '.libraries += {pango: $$pango}' > ${VERSIONS_FILE}

make_pango: fetch_pango configure_pango build_pango version_pango
