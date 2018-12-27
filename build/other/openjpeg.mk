SHELL := /bin/bash
.DEFAULT_GOAL := make_openjpeg

url_openjpeg =  https://github.com/uclouvain/openjpeg/archive/v${VERSION_OPENJPEG}.tar.gz
build_dir_openjpeg = ${DEPS}/openjpeg

fetch_openjpeg:
	mkdir -p ${build_dir_openjpeg}/build
	${CURL} -Ls ${url_openjpeg} | tar $(shell ${TARGS} ${url_openjpeg}) ${build_dir_openjpeg} --strip-components=1

configure_openjpeg:
	cd ${build_dir_openjpeg}/build && \
	$(CMAKE) .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${TARGET} \
        -DBUILD_SHARED_LIBS:bool=on

build_openjpeg:
	cd ${build_dir_openjpeg}/build && \
	$(MAKE) install

version_openjpeg:
	/usr/local/bin/versions.py add -s libraries -i openjpeg -v ${VERSION_OPENJPEG}

make_openjpeg: fetch_openjpeg configure_openjpeg build_openjpeg version_openjpeg
