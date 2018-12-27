SHELL := /bin/bash
.DEFAULT_GOAL := make_cairo
url_cairo = http://cairographics.org/releases/cairo-${VERSION_CAIRO}.tar.xz
build_dir_cairo = ${DEPS}/cairo

fetch_cairo:
	mkdir -p ${build_dir_cairo}
	${CURL} -Ls ${url_cairo} | tar $(shell ${TARGS} ${url_cairo}) ${build_dir_cairo} --strip-components=1

configure_cairo:
	cd ${build_dir_cairo} && \
	${build_dir_cairo}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-xlib \
        --disable-xcb \
        --disable-quartz \
        --disable-win32 \
        --disable-egl \
        --disable-glx \
        --disable-wgl \
        --disable-script \
        --disable-ps \
        --disable-gobject \
        --disable-trace \
        --disable-interpreter

build_cairo:
	cd ${build_dir_cairo} && \
	$(MAKE) install-strip

version_cairo:
	/usr/local/bin/versions.py add -s libraries -i cairo -v ${VERSION_CAIRO}

make_cairo: fetch_cairo configure_cairo build_cairo version_cairo
