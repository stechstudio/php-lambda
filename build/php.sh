#!/bin/sh
set -e

# Working directories
DEPS=/deps
TARGET=/target

#Clean up any old stuff
sudo rm -rf ${DEPS}
sudo rm -rf ${TARGET}

# Rebuild our directories
mkdir -p ${DEPS}
mkdir -p ${TARGET}

# Common build paths and flags
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${TARGET}/lib/pkgconfig"
export PATH="${PATH}:${TARGET}/bin"
export CPPFLAGS="-I${TARGET}/include"
export LDFLAGS="-L${TARGET}/lib"
export CFLAGS="${FLAGS}"
export CXXFLAGS="${FLAGS}"

VERSION_CURL=7.54.0
TAG_CURL=
DIR_CURL=${DEPS}/curl

DIR_PHP=${DEPS}/php

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
--disable-cgi \
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
--enable-shared \
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

# Create JSON file of version numbers
cd ${TARGET}
echo "{\n\
  \"curl\": \"${VERSION_CURL}\",\n\
  \"php\": \"${VERSION_PHP}\",\n\
}" >lib/versions.json
tar czf /packaging/php-${VERSION_PHP}-lambda.tar.gz include lib bin
advdef --recompress --shrink-insane /packaging/php-${VERSION_PHP}-lambda.tar.gz
