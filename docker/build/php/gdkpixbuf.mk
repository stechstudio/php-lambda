SHELL := /bin/bash
.DEFAULT_GOAL := make_gdkpixbuf
url_gdkpixbuf = https://github.com/GNOME/gdk-pixbuf/archive/${VERSION_GDKPIXBUF}.tar.gz
build_dir_gdkpixbuf = ${DEPS}/gdkpixbuf

fetch_gdkpixbuf:
	mkdir -p ${build_dir_gdkpixbuf}
	${CURL} -Ls ${url_gdkpixbuf} | tar $(shell ${TARGS} ${url_gdkpixbuf}) ${build_dir_gdkpixbuf} --strip-components=1

configure_gdkpixbuf:
	cd ${build_dir_gdkpixbuf} && \
	touch gdk-pixbuf/loaders.cache && \
    ${MESON} build . --prefix=${TARGET} -Dx11=false -Dbuiltin_loaders=png,jpeg -Dgir=false -Dman=false -Dinstalled_tests=false 

build_gdkpixbuf:
	cd ${build_dir_gdkpixbuf}/_build && \
	${NINJA} && \
	${NINJA} install

version_gdkpixbuf:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg gdkpixbuf ${VERSION_GDKPIXBUF} '.libraries += {gdkpixbuf: $$gdkpixbuf}' > ${VERSIONS_FILE}

make_gdkpixbuf: fetch_gdkpixbuf configure_gdkpixbuf build_gdkpixbuf version_gdkpixbuf
