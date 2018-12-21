.DEFAULT_GOAL := make_jpeg-turbo
url_jpeg-turbo = http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-${VERSION_JPGTURBO}.tar.gz 
build_dir_jpeg-turbo = ${DEPS}/jpeg-turbo
ifeq ($(suffix $(url_jpeg-turbo)), .gz)
	jpeg-turbo_args=xzC
else
	ifeq ($(suffix $(url_jpeg-turbo)), tgz)
		jpeg-turbo_args=xzC
	else
		ifeq ($(suffix $(url_jpeg-turbo)), bz2)
			jpeg-turbo_args=xjC
		else
			jpeg-turbo_args=xJC
		endif
	endif
endif

fetch_jpeg-turbo:
	mkdir -p ${build_dir_jpeg-turbo}
	curl -Ls ${url_jpeg-turbo} | tar $(jpeg-turbo_args) ${build_dir_jpeg-turbo} --strip-components=1

configure_jpeg-turbo:
	cd ${build_dir_jpeg-turbo} && \
	${build_dir_jpeg-turbo}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-jpeg8 \
        --without-simd \
        --without-turbojpeg

build_jpeg-turbo:
	cd ${build_dir_jpeg-turbo} && \
	/usr/bin/make install-strip

make_jpeg-turbo: fetch_jpeg-turbo configure_jpeg-turbo build_jpeg-turbo
