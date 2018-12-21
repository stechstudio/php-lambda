.DEFAULT_GOAL := make_gdkpixbuf
url_gdkpixbuf = https://download.gnome.org/sources/gdk-pixbuf/2.36/gdk-pixbuf-${VERSION_GDKPIXBUF}.tar.xz
build_dir_gdkpixbuf = ${DEPS}/gdkpixbuf
ifeq ($(suffix $(url_gdkpixbuf)), .gz)
	gdkpixbuf_args=xzC
else
	ifeq ($(suffix $(url_gdkpixbuf)), tgz)
		gdkpixbuf_args=xzC
	else
		ifeq ($(suffix $(url_gdkpixbuf)), bz2)
			gdkpixbuf_args=xjC
		else
			gdkpixbuf_args=xJC
		endif
	endif
endif

fetch_gdkpixbuf:
	mkdir -p ${build_dir_gdkpixbuf}
	curl -Ls ${url_gdkpixbuf} | tar $(gdkpixbuf_args) ${build_dir_gdkpixbuf} --strip-components=1

configure_gdkpixbuf:
	cd ${build_dir_gdkpixbuf} && \
	touch gdk-pixbuf/loaders.cache && \
    ${build_dir_gdkpixbuf}/configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-introspection \
        --disable-modules \
        --disable-gio-sniffing \
        --without-libtiff \
        --without-gdiplus \
        --with-included-loaders=png,jpeg

build_gdkpixbuf:
	cd ${build_dir_gdkpixbuf} && \
	/usr/bin/make install-strip

make_gdkpixbuf: fetch_gdkpixbuf configure_gdkpixbuf build_gdkpixbuf
