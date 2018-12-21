.DEFAULT_GOAL := make_ffi
url_ffi = ftp://sourceware.org/pub/libffi/libffi-${VERSION_FFI}.tar.gz
build_dir_ffi = ${DEPS}/ffi

fetch_ffi:
	mkdir -p ${build_dir_ffi}
	curl -Ls ${url_ffi} | tar xzC ${build_dir_ffi} --strip-components=1

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
	/usr/bin/make install-strip

make_ffi: fetch_ffi configure_ffi build_ffi
