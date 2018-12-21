.DEFAULT_GOAL := make_swig
url_swig = http://downloads.sourceforge.net/swig/swig-${VERSION_SWIG}.tar.gz
build_dir_swig = ${DEPS}/swig
ifeq ($(suffix $(url_swig)), .gz)
	swig_args=xzC
else
	ifeq ($(suffix $(url_swig)), tgz)
		swig_args=xzC
	else
		ifeq ($(suffix $(url_swig)), bz2)
			swig_args=xjC
		else
			swig_args=xJC
		endif
	endif
endif

fetch_swig:
	mkdir -p ${build_dir_swig}
	curl -Ls ${url_swig} | tar $(swig_args) ${build_dir_swig} --strip-components=1

configure_swig:
	cd ${build_dir_swig} && \
	${build_dir_swig}/configure \
        --prefix=${TARGET} \
        --with-pcre-prefix=${TARGET} \
        --without-alllang   \
        --with-python=/usr/bin/python \
        --without-maximum-compile-warnings

build_swig:
	cd ${build_dir_swig} && \
	/usr/bin/make && \
	/usr/bin/make install

make_swig: fetch_swig configure_swig build_swig
