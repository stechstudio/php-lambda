SHELL := /bin/bash
.DEFAULT_GOAL := make_xslt
url_xslt = http://xmlsoft.org/sources/libxslt-${VERSION_XLST}.tar.gz
build_dir_xslt = ${DEPS}/xslt

fetch_xslt:
	mkdir -p ${build_dir_xslt}
	${CURL} -Ls ${url_xslt} | tar $(shell ${TARGS} ${url_xslt}) ${build_dir_xslt} --strip-components=1

configure_xslt:
	cd ${build_dir_xslt} && \
	${build_dir_xslt}/configure \
        --prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --disable-static 

build_xslt:
	cd ${build_dir_xslt} && \
	$(MAKE) install-strip

version_xslt:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg xslt ${VERSION_XLST} '.libraries += {xslt: $$xslt}' > ${VERSIONS_FILE}

make_xslt: fetch_xslt configure_xslt build_xslt version_xslt
