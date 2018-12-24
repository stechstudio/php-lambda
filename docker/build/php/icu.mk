SHELL := /bin/bash
.DEFAULT_GOAL := make_icu
url_icu = http://download.icu-project.org/files/icu4c/${VERSION_ICU}/icu4c-${VERSION_ICU//./_}-src.tgz
build_dir_icu = ${DEPS}/icu

fetch_icu:
	mkdir -p ${build_dir_icu}
	${CURL} -Ls ${url_icu} | tar $(shell ${TARGS} ${url_icu}) ${build_dir_icu} --strip-components=1

configure_icu:
	cd ${build_dir_icu}/source && \
	${build_dir_icu}/source/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --with-library-bits=64 \
        --with-data-packaging=library \
        --enable-tests=no \
        --enable-samples=no \
        --disable-static

build_icu:
	cd ${build_dir_icu}/source && \
	$(MAKE) install

version_icu:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg icu ${VERSION_ICU} '.libraries += {icu: $$icu}' > ${VERSIONS_FILE}

make_icu: fetch_icu configure_icu build_icu version_icu
