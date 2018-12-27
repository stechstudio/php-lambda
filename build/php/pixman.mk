SHELL := /bin/bash
.DEFAULT_GOAL := make_pixman
url_pixman = http://cairographics.org/releases/pixman-${VERSION_PIXMAN}.tar.gz
build_dir_pixman = ${DEPS}/pixman

fetch_pixman:
	mkdir -p ${build_dir_pixman}
	${CURL} -Ls ${url_pixman} | tar $(shell ${TARGS} ${url_pixman}) ${build_dir_pixman} --strip-components=1

configure_pixman:
	cd ${build_dir_pixman} && \
	${build_dir_pixman}/configure  \
        --prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-arm-iwmmxt

build_pixman:
	cd ${build_dir_pixman} && \
	$(MAKE) install-strip

version_pixman:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg pixman ${VERSION_PIXMAN} '.libraries += {pixman: $$pixman}' > ${VERSIONS_FILE}

make_pixman: fetch_pixman configure_pixman build_pixman version_pixman
