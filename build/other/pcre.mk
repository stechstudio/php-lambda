SHELL := /bin/bash
.DEFAULT_GOAL := make_pcre
url_pcre = ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${VERSION_PCRE}.tar.bz2
build_dir_pcre = ${DEPS}/pcre

fetch_pcre:
	mkdir -p ${build_dir_pcre}
	${CURL} -Ls ${url_pcre} | tar $(shell ${TARGS} ${url_pcre}) ${build_dir_pcre} --strip-components=1

configure_pcre:
	cd ${build_dir_pcre} && \
	${build_dir_pcre}/configure \
        --prefix=${TARGET} \
        --docdir=${TARGET}/share/doc/pcre \
		--enable-utf  \
        --enable-unicode-properties       \
        --enable-pcre16                   \
        --enable-pcre32                   \
        --enable-pcregrep-libz            

build_pcre:
	cd ${build_dir_pcre} && \
	$(MAKE) install 

version_pcre:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg pcre ${VERSION_PCRE} '.libraries += {pcre: $$pcre}' > ${VERSIONS_FILE}

make_pcre: fetch_pcre configure_pcre build_pcre version_pcre
