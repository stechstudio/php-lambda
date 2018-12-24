SHELL := /bin/bash
.DEFAULT_GOAL := make_nasm
url_nasm = http://www.nasm.us/pub/nasm/releasebuilds/${VERSION_NASM}/nasm-${VERSION_NASM}.tar.xz
build_dir_nasm = ${DEPS}/nasm

fetch_nasm:
	mkdir -p ${build_dir_nasm}
	${CURL} -Ls ${url_nasm} | tar $(shell ${TARGS} ${url_nasm}) ${build_dir_nasm} --strip-components=1

configure_nasm:
	cd ${build_dir_nasm} && \
	${build_dir_nasm}/configure \
        --prefix=${TARGET}  \
         --enable-shared \
         --disable-static
		 
build_nasm:
	cd ${build_dir_nasm} && \
	$(MAKE) install

version_nasm:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg nasm ${VERSION_NASM} '.libraries += {nasm: $$$nasm}' > ${VERSIONS_FILE}

make_nasm: fetch_nasm configure_nasm build_nasm version_nasm
