url_zlib = http://zlib.net/zlib-${VERSION_ZLIB}.tar.xz
build_dir_zlib = ${DEPS}/zlib

fetch_zlib:
	mkdir -p ${build_dir_zlib}
	curl -Ls ${url_zlib} | tar xJC ${build_dir_zlib} --strip-components=1

configure_zlib:
	cd ${build_dir_zlib} && \
	${build_dir_zlib}/configure --prefix=${TARGET} --uname=linux

build_zlib:
	cd ${build_dir_zlib} && \
	/usr/bin/make install && \
	/bin/rm ${TARGET}/lib/libz.a

make_zlib: fetch_zlib configure_zlib build_zlib
