SHELL := /bin/bash
.DEFAULT_GOAL := make_glib
url_glib = https://github.com/GNOME/glib/archive/${VERSION_GLIB}.tar.gz
build_dir_glib = ${DEPS}/glib

fetch_glib:
	mkdir -p ${build_dir_glib}
	${CURL} -Ls ${url_glib} | tar $(shell ${TARGS} ${url_glib}) ${build_dir_glib} --strip-components=1

configure_glib:
	LD_LIBRARY_PATH= yum install -y libmount-devel
	cd ${build_dir_glib} && \
	${build_dir_glib}/autogen.sh --prefix=${TARGET} --with-pcre=internal --enable-shared --disable-static --disable-dependency-tracking --cache-file=glib.cache

build_glib:
	cd ${build_dir_glib} && \
	$(MAKE) install-strip

version_glib:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg glib ${VERSION_GLIB} '.libraries += {glib: $$glib}' > ${VERSIONS_FILE}

make_glib: fetch_glib configure_glib build_glib version_glib
