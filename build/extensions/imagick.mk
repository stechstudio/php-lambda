SHELL := /bin/bash
.DEFAULT_GOAL := make_imagick

url_imagick = https://github.com/mkoppanen/imagick/archive/${VERSION_IMAGICK}.tar.gz
build_dir_imagick = ${DEPS}/imagick
ifeq ($(suffix $(url_imagick)), .gz)
	imagick_args=xzC
else
	ifeq ($(suffix $(url_imagick)), tgz)
		imagick_args=xzC
	else
		ifeq ($(suffix $(url_imagick)), bz2)
			imagick_args=xjC
		else
			imagick_args=xJC
		endif
	endif
endif

fetch_imagick:
	mkdir -p ${build_dir_imagick}
	curl -Ls ${url_imagick} | tar $(imagick_args) ${build_dir_imagick} --strip-components=1

configure_imagick:
	cd ${build_dir_imagick} && \
	${TARGET}/bin/phpize && \
    ./configure \
        --with-php-config=${TARGET}/bin/php-config  \
         --with-libdir=${TARGET}/lib \
         --with-imagick=${TARGET}

build_imagick:
	cd ${build_dir_imagick} && \
	/usr/bin/make install

version_imagick:
	/usr/local/bin/versions.py add -s libraries -i imagick -v ${VERSION_IMAGICK}

make_imagick: fetch_imagick configure_imagick build_imagick version_imagick
