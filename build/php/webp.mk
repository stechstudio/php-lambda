SHELL := /bin/bash
.DEFAULT_GOAL := make_webp
url_webp = http://downloads.webmproject.org/releases/webp/libwebp-${VERSION_WEBP}.tar.gz
build_dir_webp = ${DEPS}/webp

fetch_webp:
	mkdir -p ${build_dir_webp}
	${CURL} -Ls ${url_webp} | tar $(shell ${TARGS} ${url_webp}) ${build_dir_webp} --strip-components=1

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
	$(MAKE) install-strip

version_webp:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg webp ${VERSION_WEBP} '.libraries += {webp: $$webp}' > ${VERSIONS_FILE}

make_webp: fetch_webp configure_webp build_webp version_webp
