.DEFAULT_GOAL := make_openssl
url_openssl = https://openssl.org/source/openssl-${VERSION_OPENSSL}.tar.gz
build_dir_openssl = ${DEPS}/openssl

fetch_openssl:
	mkdir -p ${build_dir_openssl}
	curl -Ls ${url_openssl} | tar xzC ${build_dir_openssl} --strip-components=1

configure_openssl:
	cd ${build_dir_openssl} && \
	${build_dir_openssl}/config  \
        --prefix=${TARGET}  \
         --openssldir=${TARGET}/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

build_openssl:
	cd ${build_dir_openssl} && \
	/usr/bin/make install && \
	curl -o ${TARGET}/etc/ssl/certdata.txt https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt

make_openssl: fetch_openssl configure_openssl build_openssl
