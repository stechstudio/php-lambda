.DEFAULT_GOAL := make_xslt
url_xslt = http://xmlsoft.org/sources/libxslt-${VERSION_XLST}.tar.gz
build_dir_xslt = ${DEPS}/xslt
ifeq ($(suffix $(url_xslt)), .gz)
	xslt_args=xzC
else
	ifeq ($(suffix $(url_xslt)), tgz)
		xslt_args=xzC
	else
		ifeq ($(suffix $(url_xslt)), bz2)
			xslt_args=xjC
		else
			xslt_args=xJC
		endif
	endif
endif

fetch_xslt:
	mkdir -p ${build_dir_xslt}
	curl -Ls ${url_xslt} | tar $(xslt_args) ${build_dir_xslt} --strip-components=1

configure_xslt:
	cd ${build_dir_xslt} && \
	${build_dir_xslt}/configure \
        --prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --disable-static 

build_xslt:
	cd ${build_dir_xslt} && \
	/usr/bin/make install-strip

make_xslt: fetch_xslt configure_xslt build_xslt
