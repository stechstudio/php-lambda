SHELL := /bin/bash
.DEFAULT_GOAL := make_croco

url_croco = https://download.gnome.org/sources/libcroco/0.6/libcroco-${VERSION_CROCO}.tar.xz
build_dir_croco = ${DEPS}/croco

fetch_croco:
	mkdir -p ${build_dir_croco}
	${CURL} -Ls ${url_croco} | tar $(shell ${TARGS} ${url_croco}) ${build_dir_croco} --strip-components=1

configure_croco:
	cd ${build_dir_croco} && \
	${build_dir_croco}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking

build_croco:
	cd ${build_dir_croco} && \
	$(MAKE) install-strip

version_croco:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg croco ${VERSION_CROCO} '.libraries += {croco: $$$croco}' > ${VERSIONS_FILE}

make_croco: fetch_croco configure_croco build_croco version_croco
