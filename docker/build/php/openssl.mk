SHELL := /bin/bash
.DEFAULT_GOAL := make_openssl
url_openssl := https://github.com/openssl/openssl/archive/OpenSSL_$(subst .,_,${VERSION_OPENSSL}).tar.gz
build_dir_openssl = ${DEPS}/openssl

fetch_openssl:
	
	mkdir -p ${build_dir_openssl}
	/usr/bin/curl -Ls ${url_openssl} | tar $(shell ${TARGS} ${url_openssl}) ${build_dir_openssl} --strip-components=1
	
configure_openssl:
	mkdir -p ${TARGET}/etc/ssl
	cd ${build_dir_openssl} &&		\
	${build_dir_openssl}/config 	\
		--prefix=${TARGET}			\
		--openssldir=${TARGET}/ssl	\
		--release					\
		no-tests					\
		shared						\
		zlib

build_openssl:
	cd ${build_dir_openssl} && \
	$(MAKE) install
	/usr/bin/curl -k -o ${CA_BUNDLE} ${CA_BUNDLE_SOURCE}
	
version_openssl:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg openssl ${VERSION_OPENSSL} '.libraries += {openssl: $$$openssl}' > ${VERSIONS_FILE}

make_openssl: fetch_openssl configure_openssl build_openssl version_openssl
