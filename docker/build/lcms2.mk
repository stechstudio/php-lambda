.DEFAULT_GOAL := make_lcms2
url_lcms2 = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/lcms/lcms/${VERSION_LCMS2}/lcms2-${VERSION_LCMS2}.tar.gz
build_dir_lcms2 = ${DEPS}/lcms2
ifeq ($(suffix $(url_lcms2)), .gz)
	lcms2_args=xzC
else
	ifeq ($(suffix $(url_lcms2)), tgz)
		lcms2_args=xzC
	else
		ifeq ($(suffix $(url_lcms2)), bz2)
			lcms2_args=xjC
		else
			lcms2_args=xJC
		endif
	endif
endif

fetch_lcms2:
	mkdir -p ${build_dir_lcms2}
	curl -Ls ${url_lcms2} | tar $(lcms2_args) ${build_dir_lcms2} --strip-components=1

configure_lcms2:
	cd ${build_dir_lcms2} && \
	${build_dir_lcms2}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking

build_lcms2:
	cd ${build_dir_lcms2} && \
	/usr/bin/make install-strip

make_lcms2: fetch_lcms2 configure_lcms2 build_lcms2
