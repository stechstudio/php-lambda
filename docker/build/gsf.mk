.DEFAULT_GOAL := make_gsf
url_gsf = https://download.gnome.org/sources/libgsf/1.14/libgsf-${VERSION_GSF}.tar.xz
build_dir_gsf = ${DEPS}/gsf
ifeq ($(suffix $(url_gsf)), .gz)
	gsf_args=xzC
else
	ifeq ($(suffix $(url_gsf)), tgz)
		gsf_args=xzC
	else
		ifeq ($(suffix $(url_gsf)), bz2)
			gsf_args=xjC
		else
			gsf_args=xJC
		endif
	endif
endif

fetch_gsf:
	mkdir -p ${build_dir_gsf}
	curl -Ls ${url_gsf} | tar $(gsf_args) ${build_dir_gsf} --strip-components=1

configure_gsf:
	cd ${build_dir_gsf} && \
	${build_dir_gsf}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking

build_gsf:
	cd ${build_dir_gsf} && \
	/usr/bin/make install-strip

make_gsf: fetch_gsf configure_gsf build_gsf
