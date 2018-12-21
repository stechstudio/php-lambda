.DEFAULT_GOAL := make_webp
url_webp = http://downloads.webmproject.org/releases/webp/libwebp-${VERSION_WEBP}.tar.gz
build_dir_webp = ${DEPS}/webp
ifeq ($(suffix $(url_webp)), .gz)
	webp_args=xzC
else
	ifeq ($(suffix $(url_webp)), tgz)
		webp_args=xzC
	else
		ifeq ($(suffix $(url_webp)), bz2)
			webp_args=xjC
		else
			webp_args=xJC
		endif
	endif
endif

fetch_webp:
	mkdir -p ${build_dir_webp}
	curl -Ls ${url_webp} | tar $(webp_args) ${build_dir_webp} --strip-components=1

configure_webp:
	cd ${build_dir_webp} && \
	${build_dir_webp}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-neon \
        --enable-libwebpmux \
        --with-pngincludedir=${TARGET}/include \
        --with-pnglibdir=${TARGET}/lib

build_webp:
	cd ${build_dir_webp} && \
	/usr/bin/make install-strip

make_webp: fetch_webp configure_webp build_webp
