SHELL := /bin/bash
.DEFAULT_GOAL := make_poppler

url_poppler = https://poppler.freedesktop.org/poppler-${VERSION_POPPLER}.tar.xz
build_dir_poppler = ${DEPS}/poppler

fetch_poppler:
	mkdir -p ${build_dir_poppler}
	${CURL} -Ls ${url_poppler} | tar $(shell ${TARGS} ${url_poppler}) ${build_dir_poppler} --strip-components=1

configure_poppler:
	mkdir -p ${build_dir_poppler}/build
	cd ${build_dir_poppler}/build && \
	$(CMAKE) -DCMAKE_BUILD_TYPE=Release   \
       -DCMAKE_INSTALL_PREFIX=${TARGET}  \
       -DENABLE_XPDF_HEADERS=ON   \
	   -DENABLE_LIBOPENJPEG=openjpeg2 \
	   -DBUILD_CPP_TESTS:BOOL=OFF \
	   -DBUILD_GTK_TESTS:BOOL=OFF \
	   -DBUILD_QT5_TESTS:BOOL=OFF \
	   ..

build_poppler:
	cd ${build_dir_poppler}/build && \
	$(MAKE) && \
	$(MAKE) install

version_poppler:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg poppler ${VERSION_POPPLER} '.libraries += {poppler: $$poppler}' > ${VERSIONS_FILE}

make_poppler: fetch_poppler configure_poppler build_poppler version_poppler
