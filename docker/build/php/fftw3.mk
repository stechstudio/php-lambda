SHELL := /bin/bash
.DEFAULT_GOAL := make_fftw3
url_fftw3 = http://www.fftw.org/fftw-${VERSION_FFTW3}.tar.gz
build_dir_fftw3 = ${DEPS}/fftw3

fetch_fftw3:
	mkdir -p ${build_dir_fftw3}
	${CURL} -Ls ${url_fftw3} | tar $(shell ${TARGS} ${url_fftw3}) ${build_dir_fftw3} --strip-components=1

configure_fftw3:
	cd ${build_dir_fftw3} && \
	${build_dir_fftw3}/configure  \
	--prefix=${TARGET} \
	--enable-threads \
	--enable-shared

build_fftw3:
	cd ${build_dir_fftw3} && \
	$(MAKE) install

version_fftw3:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg fftw3 ${VERSION_FFTW3} '.libraries += {fftw3: $$fftw3}' > ${VERSIONS_FILE}

make_fftw3: fetch_fftw3 configure_fftw3 build_fftw3 version_fftw3
