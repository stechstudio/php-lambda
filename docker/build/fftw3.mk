.DEFAULT_GOAL := make_fftw3
url_fftw3 = http://www.fftw.org/fftw-${VERSION_FFTW3}.tar.gz
build_dir_fftw3 = ${DEPS}/fftw3

fetch_fftw3:
	mkdir -p ${build_dir_fftw3}
	curl -Ls ${url_fftw3} | tar xzC ${build_dir_fftw3} --strip-components=1

configure_fftw3:
	cd ${build_dir_fftw3} && \
	${build_dir_fftw3}/configure  \
        --prefix=${TARGET} \
        --enable-threads \
        --enable-shared

build_fftw3:
	cd ${build_dir_fftw3} && \
	/usr/bin/make install

make_fftw3: fetch_fftw3 configure_fftw3 build_fftw3
