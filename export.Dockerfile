FROM sts/runtime/php:latest
# Use bash instead of sh because we use bash-specific features below
SHELL ["/bin/bash", "-c"]

# We do not support running pear functions in Lambda
RUN rm -rf ${INSTALL_DIR}/lib/php/PEAR \
    ${INSTALL_DIR}/share/doc \
    ${INSTALL_DIR}/share/man \
    ${INSTALL_DIR}/share/gtk-doc \
    ${INSTALL_DIR}/include \
    ${INSTALL_DIR}/tests \
    ${INSTALL_DIR}/doc \
    ${INSTALL_DIR}/docs \
    ${INSTALL_DIR}/man \
    ${INSTALL_DIR}/www \
    ${INSTALL_DIR}/cfg \
    ${INSTALL_DIR}/libexec \
    ${INSTALL_DIR}/var \
    ${INSTALL_DIR}/data 

WORKDIR /opt
RUN mkdir -p /export \
 && rm -rf /export/* /bootstrap \
 && mkdir -p ${INSTALL_DIR}/etc/php/config.d \
 && echo 'extension=pthreads' > ${INSTALL_DIR}/etc/php/config.d/pthreads.ini 

ENV PHP_ZIP_NAME=/export/php-${VERSION_PHP}

# Create the PHP CLI layer
COPY helpers/bootstrap /opt/bootstrap

RUN set -xe \
 && chmod 755 /opt/bootstrap \
 && zip --quiet --recurse-paths ${PHP_ZIP_NAME}.zip . \
    --exclude "bin/*" \
    --exclude "${INSTALL_DIR/\/opt\/}/bin/*" \
    --exclude "${INSTALL_DIR/\/opt\/}/sbin/*" \
    --exclude "${INSTALL_DIR/\/opt\/}/php/*" \
    --exclude "${INSTALL_DIR/\/opt\/}/etc/php-fpm*" \
    --exclude "${INSTALL_DIR/\/opt\/}/php/pear.conf" \
    --exclude "${INSTALL_DIR/\/opt\/}/lib/cmake*" \
    --exclude "${INSTALL_DIR/\/opt\/}/lib/pkgconfig*" \
    --exclude "${INSTALL_DIR/\/opt\/}/share/aclocal*" \
    --exclude "${INSTALL_DIR/\/opt\/}/share/postgresql*" \
 && zip --update --symlinks ${PHP_ZIP_NAME}.zip "bin/php" \
 && zip --update ${PHP_ZIP_NAME}.zip "${INSTALL_DIR/\/opt\/}/bin/php"

