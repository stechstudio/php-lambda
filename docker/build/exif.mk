.DEFAULT_GOAL := make_exif
url_exif = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/libexif/libexif/${VERSION_EXIF}/libexif-${VERSION_EXIF}.tar.bz2
build_dir_exif = ${DEPS}/exif

fetch_exif:
	mkdir -p ${build_dir_exif}
	curl -Ls ${url_exif} | tar xjC ${build_dir_exif} --strip-components=1

configure_exif:
	cd ${build_dir_exif} && \
	${build_dir_exif}/configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking

build_exif:
	cd ${build_dir_exif} && \
	/usr/bin/make install

make_exif: fetch_exif configure_exif build_exif
