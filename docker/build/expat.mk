.DEFAULT_GOAL := make_expat
url_expat = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/expat/expat/${VERSION_EXPAT}/expat-${VERSION_EXPAT}.tar.bz2
build_dir_expat = ${DEPS}/expat

fetch_expat:
	mkdir -p ${build_dir_expat}
	curl -Ls ${url_expat} | tar xjC ${build_dir_expat} --strip-components=1

configure_expat:
	cd ${build_dir_expat} && \
	${build_dir_expat}/configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static

build_expat:
	cd ${build_dir_expat} && \
	/usr/bin/make install

make_expat: fetch_expat configure_expat build_expat
