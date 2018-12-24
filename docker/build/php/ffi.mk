SHELL := /bin/bash
.DEFAULT_GOAL := make_ffi
url_ffi = ftp://sourceware.org/pub/libffi/libffi-${VERSION_FFI}.tar.gz
build_dir_ffi = ${DEPS}/ffi

fetch_ffi:
	mkdir -p ${build_dir_ffi}
	${CURL} -Ls ${url_ffi} | tar $(shell ${TARGS} ${url_ffi}) ${build_dir_ffi} --strip-components=1

configure_ffi:
	cd ${build_dir_ffi} && \
	${build_dir_ffi}/configure \
        --host=${CHOST} \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-builddir

build_ffi:
	cd ${build_dir_ffi} && \
	$(MAKE) install-strip

version_ffi:
	cat ${VERSIONS_FILE} | ${JQ} --arg ffi ${VERSION_FFI} '.libraries += {ffi: $$$ffi}' > ${VERSIONS_FILE}

make_ffi: fetch_ffi configure_ffi build_ffi version_ffi
