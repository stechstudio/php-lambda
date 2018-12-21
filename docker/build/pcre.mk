.DEFAULT_GOAL := make_pcre
url_pcre = ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${VERSION_PCRE}.tar.bz2
build_dir_pcre = ${DEPS}/pcre

fetch_pcre:
	mkdir -p ${build_dir_pcre}
	curl -Ls ${url_pcre} | tar xjC ${build_dir_pcre} --strip-components=1

configure_pcre:
	cd ${build_dir_pcre} && \
	${build_dir_pcre}/configure \
        --prefix=${TARGET} \
        --docdir=${TARGET}/share/doc/pcre-8.40 \
        --enable-unicode-properties       \
        --enable-pcre16                   \
        --enable-pcre32                   \
        --enable-pcregrep-libz            \
        --disable-static

build_pcre:
	cd ${build_dir_pcre} && \
	/usr/bin/make install 

make_pcre: fetch_pcre configure_pcre build_pcre
