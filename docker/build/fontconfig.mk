.DEFAULT_GOAL := make_fontconfig
url_fontconfig = https://www.freedesktop.org/software/fontconfig/release/fontconfig-${VERSION_FONTCONFIG}.tar.bz2
build_dir_fontconfig = ${DEPS}/fontconfig
ifeq ($(suffix $(url_fontconfig)), .gz)
	fontconfig_args=xzC
else
	ifeq ($(suffix $(url_fontconfig)), tgz)
		fontconfig_args=xzC
	else
		ifeq ($(suffix $(url_fontconfig)), .bz2)
			fontconfig_args=xjC
		else
			fontconfig_args=xJC
		endif
	endif
endif

fetch_fontconfig:
	mkdir -p ${build_dir_fontconfig}
	curl -Ls ${url_fontconfig} | tar $(fontconfig_args) ${build_dir_fontconfig} --strip-components=1

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
	/usr/bin/make install-strip

make_fontconfig: fetch_fontconfig configure_fontconfig build_fontconfig
