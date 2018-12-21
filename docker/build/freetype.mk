.DEFAULT_GOAL := make_freetype
url_freetype = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/freetype/freetype2/${VERSION_FREETYPE}/freetype-${VERSION_FREETYPE}.tar.gz
build_dir_freetype = ${DEPS}/freetype
ifeq ($(suffix $(url_freetype)), .gz)
	freetype_args=xzC
else
	ifeq ($(suffix $(url_freetype)), tgz)
		freetype_args=xzC
	else
		ifeq ($(suffix $(url_freetype)), bz2)
			freetype_args=xjC
		else
			freetype_args=xJC
		endif
	endif
endif

fetch_freetype:
	mkdir -p ${build_dir_freetype}
	curl -Ls ${url_freetype} | tar $(freetype_args) ${build_dir_freetype} --strip-components=1

configure_freetype:
	cd ${build_dir_freetype} && \
	${build_dir_freetype}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static

build_freetype:
	cd ${build_dir_freetype} && \
	/usr/bin/make install

make_freetype: fetch_freetype configure_freetype build_freetype
