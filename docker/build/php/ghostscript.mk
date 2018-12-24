SHELL := /bin/bash
.DEFAULT_GOAL := make_ghostscript

url_ghostscript = https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${VERSION_GHOSTSCRIPT_NODOT}/ghostscript-${VERSION_GHOSTSCRIPT}.tar.gz
build_dir_ghostscript = ${DEPS}/ghostscript

fetch_ghostscript:
	mkdir -p ${build_dir_ghostscript}
	${CURL} -Ls ${url_ghostscript} | tar $(shell ${TARGS} ${url_ghostscript}) ${build_dir_ghostscript} --strip-components=1

configure_ghostscript:
	cd ${build_dir_ghostscript} && \
	rm -rf freetype lcms2mt jpeg libpng && \
	${build_dir_ghostscript}/configure --prefix=${TARGET} \
            --disable-compile-inits \
            --enable-dynamic        \
            --with-system-libtiff

build_ghostscript:
	mkdir -p ${TARGET}/include/ghostscript
	mkdir -p ${TARGET}/share/ghostscript

	cd ${build_dir_ghostscript} && \
	$(MAKE) install  && \
    install -v -m644 base/*.h ${TARGET}/include/ghostscript
    
    ${CURL} -Ls http://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz | tar xzC ${TARGET}/share/ghostscript
    ${CURL} -Ls http://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz | tar xzC ${TARGET}/share/ghostscript

	cd ${build_dir_ghostscript} && \
    /usr/bin/fc-cache -v ${TARGET}/share/ghostscript/fonts/

version_ghostscript:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg ghostscript ${VERSION_GHOSTSCRIPT} '.libraries += {ghostscript: $$$ghostscript}' > ${VERSIONS_FILE}

make_ghostscript: fetch_ghostscript configure_ghostscript build_ghostscript version_ghostscript
