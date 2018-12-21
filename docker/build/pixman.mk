.DEFAULT_GOAL := make_pixman
url_pixman = http://cairographics.org/releases/pixman-${VERSION_PIXMAN}.tar.gz
build_dir_pixman = ${DEPS}/pixman
ifeq ($(suffix $(url_pixman)), .gz)
	pixman_args=xzC
else
	ifeq ($(suffix $(url_pixman)), tgz)
		pixman_args=xzC
	else
		ifeq ($(suffix $(url_pixman)), bz2)
			pixman_args=xjC
		else
			pixman_args=xJC
		endif
	endif
endif

fetch_pixman:
	mkdir -p ${build_dir_pixman}
	curl -Ls ${url_pixman} | tar $(pixman_args) ${build_dir_pixman} --strip-components=1

configure_pixman:
	cd ${build_dir_pixman} && \
	${build_dir_pixman}/configure  \
        --prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-arm-iwmmxt

build_pixman:
	cd ${build_dir_pixman} && \
	/usr/bin/make install-strip

make_pixman: fetch_pixman configure_pixman build_pixman
