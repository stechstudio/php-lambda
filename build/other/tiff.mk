SHELL := /bin/bash
.DEFAULT_GOAL := make_tiff
url_tiff = http://download.osgeo.org/libtiff/tiff-${VERSION_TIFF}.tar.gz
build_dir_tiff = ${DEPS}/tiff

fetch_tiff:
	mkdir -p ${build_dir_tiff}
	${CURL} -Ls ${url_tiff} | tar $(shell ${TARGS} ${url_tiff}) ${build_dir_tiff} --strip-components=1

configure_tiff:
	cd ${build_dir_tiff} && \
	${build_dir_tiff}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-sysroot=${TARGET}  \
        --disable-mdi \
        --disable-pixarlog \
        --disable-cxx

build_tiff:
	cd ${build_dir_tiff} && \
	$(MAKE) install-strip

version_tiff:
	/usr/local/bin/versions.py add -s libraries -i tiff -v ${VERSION_TIFF}

make_tiff: fetch_tiff configure_tiff build_tiff version_tiff
