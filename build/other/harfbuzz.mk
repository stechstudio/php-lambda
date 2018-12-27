SHELL := /bin/bash
.DEFAULT_GOAL := make_harfbuzz
url_harfbuzz = https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${VERSION_HARFBUZZ}.tar.bz2
build_dir_harfbuzz = ${DEPS}/harfbuzz

fetch_harfbuzz:
	mkdir -p ${build_dir_harfbuzz}
	${CURL} -Ls ${url_harfbuzz} | tar $(shell ${TARGS} ${url_harfbuzz}) ${build_dir_harfbuzz} --strip-components=1

configure_harfbuzz:
	cd ${build_dir_harfbuzz} && \
	${build_dir_harfbuzz}/configure \
    --prefix=${TARGET} \
    --enable-shared \
    --disable-static \
    --disable-dependency-tracking

build_harfbuzz:
	cd ${build_dir_harfbuzz} && \
	$(MAKE) install-strip

version_harfbuzz:
	/usr/local/bin/versions.py add -s libraries -i harfbuzz -v ${VERSION_HARFBUZZ}

make_harfbuzz: fetch_harfbuzz configure_harfbuzz build_harfbuzz version_harfbuzz
