FROM sts/lambda/php:latest

RUN mkdir -p /opt/bref/etc/php/config.d

# https://github.com/krakjoe/apcu/releases
ENV VERSION_APCU="5.1.16"
COPY ./apcu.mk ${DEPS}/apcu.mk
RUN /usr/bin/make -f ${DEPS}/apcu.mk
RUN echo "extension = apcu.so" | tee -a /opt/bref/etc/php/config.d/apcu.ini


# https://github.com/igbinary/igbinary/releases
ENV VERSION_IGBINARY="2.0.8"
COPY ./igbinary.mk ${DEPS}/igbinary.mk
RUN /usr/bin/make -f ${DEPS}/igbinary.mk
RUN echo -e "extension = igbinary.so\nigbinary.compact_strings=On" | tee -a /opt/bref/etc/php/config.d/igbinary.ini

# https://github.com/ImageMagick/ImageMagick
# Required to build the imagick extension
ENV VERSION_IMAGEMAGICK="7.0.8-20"
COPY ./imagemagick.mk ${DEPS}/imagemagick.mk
RUN /usr/bin/make -f ${DEPS}/imagemagick.mk

# https://github.com/mkoppanen/imagick
ENV VERSION_IMAGICK="3.4.3"
COPY ./imagick.mk ${DEPS}/imagick.mk
RUN /usr/bin/make -f ${DEPS}/imagick.mk 
RUN echo "extension = imagick.so" | tee -a /opt/bref/etc/php/config.d/imagick.ini

# https://libmemcached.org/libMemcached.html
# Required to build the phpmemcached extension
ENV VERSION_MEMCACHED="1.0.18"
COPY ./memcached.mk ${DEPS}/memcached.mk
RUN /usr/bin/make -f ${DEPS}/memcached.mk

# https:
ENV VERSION_PHP_MEMCACED="3.1.3"
COPY ./php-memcached.mk ${DEPS}/php-memcached.mk
RUN /usr/bin/make -f ${DEPS}/php-memcached.mk 
RUN echo "extension = memcached.so" | tee -a /opt/bref/etc/php/config.d/php-memcached.ini