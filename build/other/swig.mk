SHELL := /bin/bash
.DEFAULT_GOAL := make_swig
url_swig = http://downloads.sourceforge.net/swig/swig-${VERSION_SWIG}.tar.gz
build_dir_swig = ${DEPS}/swig

fetch_swig:
	mkdir -p ${build_dir_swig}
	${CURL} -Ls ${url_swig} | tar $(shell ${TARGS} ${url_swig}) ${build_dir_swig} --strip-components=1

configure_swig:
	cd ${build_dir_swig} && \
	${build_dir_swig}/configure \
        --prefix=${TARGET} \
        --with-pcre-prefix=${TARGET} \
        --without-alllang   \
        --with-python=/usr/bin/python \
        --without-maximum-compile-warnings

build_swig:
	cd ${build_dir_swig} && \
	$(MAKE) && \
	$(MAKE) install

version_swig:
	/usr/local/bin/versions.py add -s libraries -i swig -v ${VERSION_SWIG}

make_swig: fetch_swig configure_swig build_swig version_swig
