SHELL := /bin/bash
.DEFAULT_GOAL := make_svg

url_svg = https://download.gnome.org/sources/librsvg/${VERSION_SVG_SHORT}/librsvg-${VERSION_SVG}.tar.xz
build_dir_svg = ${DEPS}/svg
ifeq ($(suffix $(url_svg)), .gz)
	svg_args=xzC
else
	ifeq ($(suffix $(url_svg)), tgz)
		svg_args=xzC
	else
		ifeq ($(suffix $(url_svg)), bz2)
			svg_args=xjC
		else
			svg_args=xJC
		endif
	endif
endif

fetch_svg:
	mkdir -p ${build_dir_svg}
	${CURL} -Ls ${url_svg} | tar $(shell ${TARGS} ${svg_args}) ${build_dir_svg} --strip-components=1

configure_svg:
	cd ${build_dir_svg} && \
	${build_dir_svg}/configure \
        --prefix=${TARGET} \
		--datarootdir=${TARGET}/data \
		--disable-maintainer-mode \
		--disable-nls \
        --enable-shared \
        --enable-static=no \
        --disable-dependency-tracking \
        --disable-introspection \
        --disable-tools \
        --disable-pixbuf-loader \
		--without-cairo-gobject \
		--without-gdk-pixbuf-2.0 \
		--without-pangocairo \
		--without-pangoft2 \

build_svg:
	cd ${build_dir_svg} && \
	$(MAKE) install-strip

version_svg:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg svg ${VERSION_SVG} '.libraries += {svg: $$svg}' > ${VERSIONS_FILE}

make_svg: fetch_svg configure_svg build_svg version_svg
