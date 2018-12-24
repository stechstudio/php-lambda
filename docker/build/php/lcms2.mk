SHELL := /bin/bash
.DEFAULT_GOAL := make_lcms2
url_lcms2 = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/lcms/lcms/${VERSION_LCMS2}/lcms2-${VERSION_LCMS2}.tar.gz
build_dir_lcms2 = ${DEPS}/lcms2

fetch_lcms2:
	mkdir -p ${build_dir_lcms2}
	${CURL} -Ls ${url_lcms2} | tar $(shell ${TARGS} ${url_lcms2}) ${build_dir_lcms2} --strip-components=1

configure_lcms2:
	cd ${build_dir_lcms2} && \
	${build_dir_lcms2}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking

build_lcms2:
	cd ${build_dir_lcms2} && \
	$(MAKE) install-strip

version_lcms2:
	cat ${VERSIONS_FILE} | jq --arg lcms2 ${VERSION_LCMS2} '.libraries += {lcms2: $$$lcms2}' > ${VERSIONS_FILE}

make_lcms2: fetch_lcms2 configure_lcms2 build_lcms2 version_lcms2
