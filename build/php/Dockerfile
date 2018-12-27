FROM sts/lambda/compiler:latest

COPY helpers/versions.py /usr/local/bin/versions.py
RUN /usr/local/bin/versions.py init
 
# We are going to want these include files later.
RUN LD_LIBRARY_PATH= yum install -y gmp-devel readline-devel

# https://github.com/madler/zlib/releases
# Needed for:
#   - openssl
#   - curl
#   - pcre
ENV VERSION_ZLIB="1.2.11"
COPY ./zlib.mk ${DEPS}/zlib.mk
RUN /usr/bin/make -f ${DEPS}/zlib.mk

# https://github.com/openssl/openssl/releases
# Needs:
#   - zlib
# Needed by:
#   - curl
#   - php
ENV VERSION_OPENSSL="1.1.1a"
ENV CA_BUNDLE_SOURCE="https://curl.haxx.se/ca/cacert.pem"
ENV CA_BUNDLE="${TARGET}/etc/ssl/cacert.pem"
COPY ./openssl.mk  ${DEPS}/openssl.mk 
RUN /usr/bin/make -f ${DEPS}/openssl.mk 

# https://github.com/libssh2/libssh2/releases
# Needs:
#   - None
# Needed by:
#   - curl
ENV VERSION_LIBSSH2="1.8.0"
COPY ./libssh2.mk ${DEPS}/libssh2.mk
RUN /usr/bin/make -f ${DEPS}/libssh2.mk

# https://github.com/curl/curl/releases
# Needs:
#   - OpenSSL
#   - zlib
#   - libssh2
# Needed by:
#   - poppler
#   - php
ENV VERSION_CURL="7.63.0"
COPY ./curl.mk ${DEPS}/curl.mk
RUN /usr/bin/make -f ${DEPS}/curl.mk

# https://github.com/nih-at/libzip
# Needs:
#   - None
# Needed by:
#   - php
ENV VERSION_LIBZIP=1.5.1
ENV VERSION_LIBZIP_DASHES=1-5-1
COPY ./libzip.mk ${DEPS}/libzip.mk
RUN /usr/bin/make -f ${DEPS}/libzip.mk

# http://www.linuxfromscratch.org/blfs/view/svn/general/nasm.html
# Needs:
#   - None
# Needed by:
#   - libjpeg-turbo
ENV VERSION_NASM="2.14"
COPY ./nasm.mk ${DEPS}/nasm.mk
RUN /usr/bin/make -f ${DEPS}/nasm.mk

# https://github.com/GNOME/libxml2/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/libxml2.html
# Needs:
#   - zlib
# Needed by:
#   - php
ENV VERSION_XML2="2.9.8"
COPY ./xml2.mk ${DEPS}/xml2.mk
RUN /usr/bin/make -f ${DEPS}/xml2.mk

# https://github.com/libjpeg-turbo/libjpeg-turbo/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/libjpeg.html
# Needs:
#   - nasm
# Needed by:
#   - webp
ENV VERSION_JPGTURBO="2.0.1"
COPY ./jpeg-turbo.mk ${DEPS}/jpeg-turbo.mk
RUN /usr/bin/make -f ${DEPS}/jpeg-turbo.mk

# https://libpng.sourceforge.io/
# http://www.linuxfromscratch.org/blfs/view/svn/general/libpng.html
# Needs:
#   - None
# Needed by:
#   - php
#   - webp
ENV VERSION_PNG16="1.6.36"
COPY ./png16.mk  ${DEPS}/png16.mk 
RUN /usr/bin/make -f ${DEPS}/png16.mk 

# https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html
# http://www.linuxfromscratch.org/blfs/view/8.0/general/libwebp.html
# Needs:
#   - libjpeg-turbo
#   - png16
# Needed by:
#   - php
ENV VERSION_WEBP="1.0.1"
COPY ./webp.mk ${DEPS}/webp.mk
RUN /usr/bin/make -f ${DEPS}/webp.mk

# 
# https://github.com/postgres/postgres/releases
# Needs:
#   - 
# Needed by:
#   - php
ENV VERSION_POSTGRES="9.6.11"
COPY ./postgres.mk ${DEPS}/postgres.mk
RUN /usr/bin/make -f ${DEPS}/postgres.mk


# https://github.com/php/php-src/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/php.html
# Needs:
#   - libxml2
#   - libxslt
#   - pcre
#   - freetype
#   - libjpeg-turbo
#   - libpng
#   - libtiff
#   - curl
#   - openssl
# Needed by:
#   - phpvips
#build php
ENV VERSION_PHP="7.3.0"
COPY ./php.mk ${DEPS}/php.mk
RUN /usr/bin/make -f ${DEPS}/php.mk 

# https://github.com/jcupitt/php-vips-ext/releases
# https://github.com/jcupitt/php-vips-ext
# Needs:
#   - vips
#   - php
# Needed by:
#   - none
# ENV VERSION_PHPVIPS="1.0.8"
# COPY ./extensions/phpvips.mk ${DEPS}/phpvips.mk
# RUN /usr/bin/make -f ${DEPS}/phpvips.mk

FROM sts/lambda/compiler:latest
WORKDIR ${TARGET}
COPY --from=0 /versions.json /versions.json
COPY --from=0 ${TARGET} ${TARGET}
COPY helpers/versions.py /usr/local/bin/versions.py