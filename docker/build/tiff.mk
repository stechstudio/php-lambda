.DEFAULT_GOAL := make_tiff
url_tiff = http://download.osgeo.org/libtiff/tiff-${VERSION_TIFF}.tar.gz
build_dir_tiff = ${DEPS}/tiff

ifeq ($(suffix $(url_tiff)), .gz)
	tiff_args=xzC
else
	ifeq ($(suffix $(url_tiff)), tgz)
		tiff_args=xzC
	else
		ifeq ($(suffix $(url_tiff)), bz2)
			tiff_args=xjC
		else
			tiff_args=xJC
		endif
	endif
endif

fetch_tiff:
	mkdir -p ${build_dir_tiff}
	curl -Ls ${url_tiff} | tar $(tiff_args) ${build_dir_tiff} --strip-components=1

configure_tiff:
	cd ${build_dir_tiff} && ${build_dir_tiff}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-sysroot=${TARGET}  \
        --disable-mdi \
        --disable-pixarlog \
        --disable-cxx

build_tiff:
	cd ${build_dir_tiff} && \
	/usr/bin/make install-strip

make_tiff: fetch_tiff configure_tiff build_tiff
