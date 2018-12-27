SHELL := /bin/bash
.DEFAULT_GOAL := make_expat
url_expat = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/expat/expat/${VERSION_EXPAT}/expat-${VERSION_EXPAT}.tar.bz2
build_dir_expat = ${DEPS}/expat

fetch_expat:
	mkdir -p ${build_dir_expat}
	${CURL} -Ls ${url_expat} | tar $(shell ${TARGS} ${url_expat}) ${build_dir_expat} --strip-components=1

configure_expat:
	cd ${build_dir_expat} && \
	${build_dir_expat}/configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static

build_expat:
	cd ${build_dir_expat} && \
	$(MAKE) install

version_expat:
	/usr/local/bin/versions.py add -s libraries -i expat -v ${VERSION_EXPAT}

make_expat: fetch_expat configure_expat build_expat version_expat
