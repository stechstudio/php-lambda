#!/bin/sh
set -e

# Working directories
DEPS=/deps
TARGET=/target

#Clean up any old stuff
sudo rm -rf ${DEPS}/*
sudo rm -rf ${TARGET}/*

# Common build paths and flags
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${TARGET}/lib/pkgconfig"
export PATH="${PATH}:${TARGET}/bin"
export CPPFLAGS="-I${TARGET}/include"
export LDFLAGS="-L${TARGET}/lib"
export CFLAGS="${FLAGS}"
export CXXFLAGS="${FLAGS}"

VERSION_CURL=7.54.0
DIR_CURL=${DEPS}/curl

DIR_PHP=${DEPS}/php

VERSION_IMAGICK=3.4.3
DIR_IMAGICK=${DEPS}/imagick


echo "BUILDING CURL"
mkdir -p ${DIR_CURL}
curl -Ls https://github.com/curl/curl/releases/download/curl-${VERSION_CURL//./_}/curl-${VERSION_CURL}.tar.gz | tar xzC ${DIR_CURL} --strip-components=1
cd ${DIR_CURL}
./configure --prefix=${TARGET} --enable-shared --disable-static --disable-dependency-tracking
make
make install


echo "BUILDING PHP"
# Build PHP
mkdir -p ${DIR_PHP}
curl -Ls https://github.com/php/php-src/archive/php-${VERSION_PHP}.tar.gz | tar xzC ${DIR_PHP} --strip-components=1
cd ${DIR_PHP}
./buildconf --force
./configure \
--disable-dependency-trackin \
--disable-opcache \
--disable-static \
--enable-bcmath \
--enable-calendar \
--enable-ctype \
--enable-exif \
--enable-ftp \
--enable-gd-jis-conv \
--enable-gd-native-ttf \
--enable-json \
--enable-mbstring \
--enable-pcntl \
--enable-pdo \
--enable-shared=yes \
--enable-static=no \
--enable-sysvmsg \
--enable-sysvsem \
--enable-sysvshm \
--enable-zip \
--prefix=${TARGET} \
--with-config-file-path=${TARGET}/usr/etc \
--with-curl=${TARGET} \
--with-gd \
--with-gmp \
--with-iconv \
--with-mysqli=mysqlnd \
--with-openssl \
--with-pdo-mysql=mysqlnd \
--with-zlib \
--without-pear
make
make install
cp php.ini-production ${TARGET}/lib/php.ini


echo "BUILDING IMAGICK PHP Extension"
mkdir -p ${DIR_IMAGICK}
curl -Ls https://github.com/mkoppanen/imagick/archive/${VERSION_IMAGICK}.tar.gz| tar xzC ${DIR_IMAGICK} --strip-components=1
cd ${DIR_IMAGICK}
${TARGET}/bin/phpize
./configure --with-php-config=/target/bin/php-config
make
make install
mkdir -p ${TARGET}/modules
cp ${DIR_IMAGICK}/rpm/imagick.ini ${TARGET}/modules/imagick.ini


# Create JSON file of version numbers
cd ${TARGET}
echo "{ \"curl\": \"${VERSION_CURL}\", \"php\": \"${VERSION_PHP}\", \"imagick_module\": \"${VERSION_IMAGICK}\" }" > lib/versions.json
tar czf /packaging/php-${VERSION_PHP}-lambda.tar.gz include lib bin modules
advdef --recompress --shrink-insane /packaging/php-${VERSION_PHP}-lambda.tar.gz

