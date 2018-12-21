.DEFAULT_GOAL := make_harfbuzz
url_harfbuzz = https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${VERSION_HARFBUZZ}.tar.bz2
build_dir_harfbuzz = ${DEPS}/harfbuzz
ifeq ($(suffix $(url_harfbuzz)), .gz)
	harfbuzz_args=xzC
else
	ifeq ($(suffix $(url_harfbuzz)), .tgz)
		harfbuzz_args=xzC
	else
		ifeq ($(suffix $(url_harfbuzz)), .bz2)
			harfbuzz_args=xjC
		else
			harfbuzz_args=xJC
		endif
	endif
endif

fetch_harfbuzz:
	mkdir -p ${build_dir_harfbuzz}
	curl -Ls ${url_harfbuzz} | tar $(harfbuzz_args) ${build_dir_harfbuzz} --strip-components=1

configure_harfbuzz:
	cd ${build_dir_harfbuzz} && \
	${build_dir_harfbuzz}/configure \
    --prefix=${TARGET} \
    --enable-shared \
    --disable-static \
    --disable-dependency-tracking

build_harfbuzz:
	cd ${build_dir_harfbuzz} && \
	/usr/bin/make install-strip

make_harfbuzz: fetch_harfbuzz configure_harfbuzz build_harfbuzz
