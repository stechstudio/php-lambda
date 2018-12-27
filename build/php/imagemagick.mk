SHELL := /bin/bash
.DEFAULT_GOAL := make_imagemagick

url_imagemagick = https://github.com/ImageMagick/ImageMagick/archive/${VERSION_IMAGEMAGICK}.tar.gz
build_dir_imagemagick = ${DEPS}/imagemagick

fetch_imagemagick:
	mkdir -p ${build_dir_imagemagick}
	${CURL} -Ls ${url_imagemagick} | tar $(shell ${TARGS} ${url_imagemagick}) ${build_dir_imagemagick} --strip-components=1

configure_imagemagick:
	cd ${build_dir_imagemagick} && \
	${build_dir_imagemagick}/configure \
        --prefix=${TARGET} \
        --sysconfdir=${TARGET}/etc \
        --enable-hdri     \
        --with-gslib    \
        --with-rsvg     \
        --disable-static

build_imagemagick:
	cd ${build_dir_imagemagick} && \
	$(MAKE) install-strip

version_imagemagick:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg imagemagick ${VERSION_IMAGEMAGICK} '.libraries += {imagemagick: $$imagemagick}' > ${VERSIONS_FILE}

make_imagemagick: fetch_imagemagick configure_imagemagick build_imagemagick version_imagemagick
