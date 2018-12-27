SHELL := /bin/bash
.DEFAULT_GOAL := make_vips

url_vips = https://github.com/libvips/libvips/releases/download/v${VERSION_VIPS}/vips-${VERSION_VIPS}.tar.gz
build_dir_vips = ${DEPS}/vips

fetch_vips:
	mkdir -p ${build_dir_vips}
	${CURL} -Ls ${url_vips} | tar $(shell ${TARGS} ${url_vips}) ${build_dir_vips} --strip-components=1

configure_vips:
	cd ${build_dir_vips} && \
	${build_dir_vips}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-debug \
        --disable-introspection \
        --with-zlib-includes=${TARGET}/include \
        --with-zlib-libraries=${TARGET}/lib \
        --with-jpeg-includes=${TARGET}/include \
        --with-jpeg-libraries=${TARGET}/lib \
        --with-png-includes=${TARGET}/include \
        --with-png-libraries=${TARGET}/lib \
        --with-giflib-includes=${TARGET}/include \
        --with-giflib-libraries=${TARGET}/lib \
        --with-tiff-includes=${TARGET}/include \
        --with-tiff-libraries=${TARGET}/lib \
        --with-libwebp-includes=${TARGET}/include \
        --with-libwebp-libraries=${TARGET}/lib

build_vips:
	cd ${build_dir_vips} && \
	$(MAKE) install-strip

version_vips:
	/usr/local/bin/versions.py add -s libraries -i vips -v ${VERSION_VIPS}

make_vips: fetch_vips configure_vips build_vips version_vips
