SHELL := /bin/bash
.DEFAULT_GOAL := make_zlib
url_zlib = http://zlib.net/zlib-${VERSION_ZLIB}.tar.xz
build_dir_zlib = ${DEPS}/zlib

fetch_zlib:
	mkdir -p ${build_dir_zlib}
	# Use the old system curl until we have built our own
	/usr/bin/curl -Ls ${url_zlib} | tar $(shell ${TARGS} ${url_zlib}) ${build_dir_zlib} --strip-components=1

configure_zlib:
	cd ${build_dir_zlib} && \
	${build_dir_zlib}/configure --prefix=${TARGET} --uname=linux

build_zlib:
	cd ${build_dir_zlib} && \
	$(MAKE) install && \
	/bin/rm ${TARGET}/lib/libz.a

version_zlib:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg zlib ${VERSION_ZLIB} '.libraries += {zlib: $$zlib}' > ${VERSIONS_FILE}

make_zlib: fetch_zlib configure_zlib build_zlib version_zlib
