SHELL := /bin/bash
.DEFAULT_GOAL := make_php

url_php = https://github.com/php/php-src/archive/php-${VERSION_PHP}.tar.gz
build_dir_php = ${DEPS}/php

fetch_php:
	mkdir -p ${build_dir_php}
	${CURL} -Ls ${url_php} | tar $(shell ${TARGS} ${url_php}) ${build_dir_php} --strip-components=1

configure_php:
	LD_LIBRARY_PATH= yum install -y gmp-devel readline-devel
	cd ${build_dir_php} && \
	${build_dir_php}/buildconf --force && \
	CPPFLAGS="-I${TARGET}/include -I/usr/include" ${build_dir_php}/configure \
        --prefix=${TARGET} \
        --with-libdir=lib64 \
        --exec-prefix=${TARGET} \
        --enable-option-checking=fatal \
        --with-config-file-path=${TARGET}/etc/php \
        --with-config-file-scan-dir=${TARGET}/modules \
        --disable-fpm \
        --enable-cgi \
        --enable-cli \
        --disable-phpdbg \
        --disable-phpdbg-webhelper \
        --enable-bcmath \
        --enable-calendar \
        --enable-ctype \
        --enable-dom \
        --enable-exif \
        --enable-fileinfo \
        --enable-filter \
        --enable-ftp \
        --enable-gd-jis-conv \
        --enable-hash \
        --enable-json \
        --enable-libxml \
        --enable-mbstring \
        --enable-opcache \
        --enable-opcache-file \
        --enable-pcntl \
        --enable-pdo \
        --enable-phar \
        --enable-session \
        --enable-shared=yes \
        --enable-simplexml \
        --enable-soap \
        --enable-static=no \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-tokenizer \
        --enable-xml \
        --enable-xmlwriter \
        --with-curl \
        --with-gd \
        --with-gmp \
        --with-iconv \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-openssl=${TARGET} \
        --with-openssl-dir=${TARGET}  \
        --with-libxml-dir=${TARGET}  \
        --with-webp-dir=${TARGET}  \
        --with-png-dir=${TARGET}  \
        --with-jpeg-dir=${TARGET} \
        --with-zlib-dir=${TARGET} \
        --enable-zip \
        --with-zlib=${TARGET} \
        --with-readline \
        --without-pear

build_php:
	cd ${build_dir_php} && \
	$(MAKE) && \
	$(MAKE) install && \
	mkdir -p ${TARGET}/etc/php  && \
    cp php.ini-production ${TARGET}/etc/php/php.ini

version_php:
	cat ${VERSIONS_FILE} | ${JQ} --unbuffered --arg php ${VERSION_PHP} '.libraries += {php: $$php}' > ${VERSIONS_FILE}

make_php: fetch_php configure_php build_php version_php
