.DEFAULT_GOAL := make_zlib
url_zlib = http://zlib.net/zlib-${VERSION_ZLIB}.tar.xz
build_dir_zlib = ${DEPS}/zlib
ifeq ($(suffix $(url_zlib)), .gz)
	zlib_args=xzC
else
	ifeq ($(suffix $(url_zlib)), tgz)
		zlib_args=xzC
	else
		ifeq ($(suffix $(url_zlib)), bz2)
			zlib_args=xjC
		else
			zlib_args=xJC
		endif
	endif
endif

fetch_zlib:
	mkdir -p ${build_dir_zlib}
	curl -Ls ${url_zlib} | tar $(zlib_args) ${build_dir_zlib} --strip-components=1

configure_zlib:
	cd ${build_dir_zlib} && \
	${build_dir_zlib}/configure --prefix=${TARGET} --uname=linux

build_zlib:
	cd ${build_dir_zlib} && \
	/usr/bin/make install && \
	/bin/rm ${TARGET}/lib/libz.a

make_zlib: fetch_zlib configure_zlib build_zlib