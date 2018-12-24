SHELL := /bin/bash
.DEFAULT_GOAL := make_gsf
url_gsf = https://download.gnome.org/sources/libgsf/1.14/libgsf-${VERSION_GSF}.tar.xz
build_dir_gsf = ${DEPS}/gsf

fetch_gsf:
	mkdir -p ${build_dir_gsf}
	${CURL} -Ls ${url_gsf} | tar $(shell ${TARGS} ${url_gsf}) ${build_dir_gsf} --strip-components=1

configure_gsf:
	cd ${build_dir_gsf} && \
	${build_dir_gsf}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking

build_gsf:
	cd ${build_dir_gsf} && \
	$(MAKE) install-strip

version_gsf:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg gsf ${VERSION_GSF} '.libraries += {gsf: $$$gsf}' > ${VERSIONS_FILE}

make_gsf: fetch_gsf configure_gsf build_gsf version_gsf
