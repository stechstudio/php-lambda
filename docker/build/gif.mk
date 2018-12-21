.DEFAULT_GOAL := make_gif
url_gif = http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/giflib/giflib-${VERSION_GIF}.tar.gz
build_dir_gif = ${DEPS}/gif

fetch_gif:
	mkdir -p ${build_dir_gif}
	curl -Ls ${url_gif} | tar xzC ${build_dir_gif} --strip-components=1

configure_gif:
	cd ${build_dir_gif} && \
	${build_dir_gif}/configure --prefix=${TARGET} \
    --enable-shared \
    --disable-static \
    --disable-dependency-tracking

build_gif:
	cd ${build_dir_gif} && \
	/usr/bin/make install-strip

make_gif: fetch_gif configure_gif build_gif
