SHELL := /bin/bash
.DEFAULT_GOAL := make_freetype
url_freetype = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/freetype/freetype2/${VERSION_FREETYPE}/freetype-${VERSION_FREETYPE}.tar.gz
build_dir_freetype = ${DEPS}/freetype

fetch_freetype:
	mkdir -p ${build_dir_freetype}
	${CURL} -Ls ${url_freetype} | tar $(shell ${TARGS} ${url_freetype}) ${build_dir_freetype} --strip-components=1

configure_freetype:
	cd ${build_dir_freetype} && \
	${build_dir_freetype}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static

build_freetype:
	cd ${build_dir_freetype} && \
	$(MAKE) install

version_freetype:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg freetype ${VERSION_FREETYPE} '.libraries += {freetype: $$freetype}' > ${VERSIONS_FILE}

make_freetype: fetch_freetype configure_freetype build_freetype version_freetype
