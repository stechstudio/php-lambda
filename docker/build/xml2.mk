.DEFAULT_GOAL := make_xml2
url_xml2 = http://xmlsoft.org/sources/libxml2-${VERSION_XML2}.tar.gz
build_dir_xml2 = ${DEPS}/xml2
ifeq ($(suffix $(url_xml2)), .gz)
	xml2_args=xzC
else
	ifeq ($(suffix $(url_xml2)), tgz)
		xml2_args=xzC
	else
		ifeq ($(suffix $(url_xml2)), bz2)
			xml2_args=xjC
		else
			xml2_args=xJC
		endif
	endif
endif

fetch_xml2:
	mkdir -p ${build_dir_xml2}
	curl -Ls ${url_xml2} | tar $(xml2_args) ${build_dir_xml2} --strip-components=1

configure_xml2:
	cd ${build_dir_xml2} && \
	${build_dir_xml2}/configure \
        --prefix=${TARGET} \
        --exec-prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --enable-shared \
        --disable-static \
        --with-html \
        --with-history \
        --enable-ipv6=no \
        --with-icu \
        --with-zlib=${TARGET}

build_xml2:
	cd ${build_dir_xml2} && \
	/usr/bin/make install && \
	cp xml2-config ${TARGET}/bin/xml2-config
	
make_xml2: fetch_xml2 configure_xml2 build_xml2
