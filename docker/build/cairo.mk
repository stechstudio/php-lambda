.DEFAULT_GOAL := make_cairo
url_cairo = http://cairographics.org/releases/cairo-${VERSION_CAIRO}.tar.xz
build_dir_cairo = ${DEPS}/cairo
ifeq ($(suffix $(url_cairo)), .gz)
	cairo_args=xzC
else
	ifeq ($(suffix $(url_cairo)), tgz)
		cairo_args=xzC
	else
		ifeq ($(suffix $(url_cairo)), bz2)
			cairo_args=xjC
		else
			cairo_args=xJC
		endif
	endif
endif

fetch_cairo:
	mkdir -p ${build_dir_cairo}
	curl -Ls ${url_cairo} | tar $(cairo_args) ${build_dir_cairo} --strip-components=1

configure_cairo:
	cd ${build_dir_cairo} && \
	${build_dir_cairo}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-xlib \
        --disable-xcb \
        --disable-quartz \
        --disable-win32 \
        --disable-egl \
        --disable-glx \
        --disable-wgl \
        --disable-script \
        --disable-ps \
        --disable-gobject \
        --disable-trace \
        --disable-interpreter

build_cairo:
	cd ${build_dir_cairo} && \
	/usr/bin/make install-strip

make_cairo: fetch_cairo configure_cairo build_cairo
