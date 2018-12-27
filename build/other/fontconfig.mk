SHELL := /bin/bash
.DEFAULT_GOAL := make_fontconfig
url_fontconfig = https://www.freedesktop.org/software/fontconfig/release/fontconfig-${VERSION_FONTCONFIG}.tar.bz2
build_dir_fontconfig = ${DEPS}/fontconfig

fetch_fontconfig:
	mkdir -p ${build_dir_fontconfig}
	${CURL} -Ls ${url_fontconfig} | tar $(shell ${TARGS} ${url_fontconfig}) ${build_dir_fontconfig} --strip-components=1

configure_fontconfig:
	cd ${build_dir_fontconfig} && \
	rm -f src/fcobjshash.h && \
	${build_dir_fontconfig}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
		--disable-docs   \
        --disable-dependency-tracking \
        --with-expat-includes=${TARGET}/include \
        --with-expat-lib=${TARGET}/lib \
        --sysconfdir=${TARGET}/etc

build_fontconfig:
	cd ${build_dir_fontconfig} && \
	$(MAKE) install-strip

version_fontconfig:
	/usr/local/bin/versions.py add -s libraries -i fontconfig -v ${VERSION_FONTCONFIG}

make_fontconfig: fetch_fontconfig configure_fontconfig build_fontconfig version_fontconfig
