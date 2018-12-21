.DEFAULT_GOAL := make_glib
url_glib = https://download.gnome.org/sources/glib/2.52/glib-${VERSION_GLIB}.tar.xz
build_dir_glib = ${DEPS}/glib
ifeq ($(suffix $(url_glib)), .gz)
	glib_args=xzC
else
	ifeq ($(suffix $(url_glib)), tgz)
		glib_args=xzC
	else
		ifeq ($(suffix $(url_glib)), bz2)
			glib_args=xjC
		else
			glib_args=xJC
		endif
	endif
endif

fetch_glib:
	mkdir -p ${build_dir_glib}
	curl -Ls ${url_glib} | tar $(glib_args) ${build_dir_glib} --strip-components=1

configure_glib:
	cd ${build_dir_glib} && \
	${build_dir_glib}/configure \
        --cache-file=glib.cache  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-pcre=system

build_glib:
	cd ${build_dir_glib} && \
	/usr/bin/make install-strip

make_glib: fetch_glib configure_glib build_glib
