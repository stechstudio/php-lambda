FROM amazonlinux:2017.03 as builder
LABEL authors="Bubba Hines <bubba@stechstudio.com>"

# Working Directory
WORKDIR /root

# Lambda is based on 2017.03. Lock YUM to that release version.
RUN sed -i 's/releasever=latest/releaserver=2017.03/' /etc/yum.conf

RUN yum makecache fast
RUN yum groupinstall -y "Development Tools"  --setopt=group_package_types=mandatory,default
RUN yum install -y gtk-doc
RUN yum install -y texlive
RUN yum install -y gmp-devel
RUN yum install -y libssh2-devel
RUN yum install -y libmount-devel
RUN yum clean all


# The environment variables set using ENV will persist when a container is run
# from the resulting image. You can view the values using docker inspect, and
# change them using docker run --env <key>=<value>.
ENV FLAGS="-O3"
ENV DEPS="/deps"
ENV TARGET="/layer"
ENV BUILD_LOGS="/building/logs"

# Common build paths and flags
ENV PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${TARGET}/lib/pkgconfig"
ENV PKG_CONFIG=/usr/bin/pkg-config

ENV PATH="${TARGET}/bin:${PATH}"

ENV CPPFLAGS="-I${TARGET}/include"
ENV LDFLAGS="-L${TARGET}/lib"

ENV CFLAGS="${FLAGS}"
ENV CXXFLAGS="${FLAGS}"
ENV LD_LIBRARY_PATH=${TARGET}/lib
ENV JSON_VERSIONS="name: version"

CMD mkdir -p ${DEPS}
CMD mkdir -p ${TARGET}
CMD mkdir -p ${BUILD_LOGS}


COPY build/Makefile ${DEPS}/Makefile
COPY build/*.mk		${DEPS}/
WORKDIR ${DEPS}

FROM builder as zlib

# https://www.cairographics.org/releases/
ENV VERSION_CAIRO=1.14.10

# https://github.com/GNOME/libcroco/releases
ENV VERSION_CROCO=0.6.12

# https://github.com/curl/curl/releases
ENV VERSION_CURL=7.54.1

# https://sourceforge.net/projects/libexif/files/libexif/
ENV VERSION_EXIF=0.6.21

# https://sourceforge.net/projects/expat/files/expat/
ENV VERSION_EXPAT=2.2.1

# https://github.com/libffi/libffi/releases
ENV VERSION_FFI=3.2.1

# http://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
ENV VERSION_FFTW3=3.3.6-pl2

# https://www.freedesktop.org/wiki/Software/fontconfig/
ENV VERSION_FONTCONFIG=2.12.1

# https://sourceforge.net/projects/freetype/files/freetype2/
ENV VERSION_FREETYPE=2.8

# https://github.com/GNOME/gdk-pixbuf/releases
ENV VERSION_GDKPIXBUF=2.36.6

# https://sourceforge.net/projects/giflib/files/?source=navbar
ENV VERSION_GIF=5.1.4

# https://github.com/GNOME/glib/releases
ENV VERSION_GLIB=2.52.0

# http://www.linuxfromscratch.org/blfs/view/cvs/pst/gs.html
ENV VERSION_GHOSTSCRIPT=9.21

# https://github.com/GNOME/libgsf/releases
ENV VERSION_GSF=1.14.41

# https://github.com/behdad/harfbuzz/releases
ENV VERSION_HARFBUZZ=1.4.5

# http://www.linuxfromscratch.org/blfs/view/svn/general/icu.html
ENV VERSION_ICU=59.1

# http://www.linuxfromscratch.org/blfs/view/cvs/general/imagemagick.html
ENV VERSION_IMAGEMAGICK=7.0.4-8

# https://github.com/mkoppanen/imagick/releases
ENV VERSION_IMAGICK=3.4.3

# https://github.com/libjpeg-turbo/libjpeg-turbo/releases
ENV VERSION_JPGTURBO=1.5.1

# https://github.com/mm2/Little-CMS/releases
ENV VERSION_LCMS2=2.8

# https://github.com/tbeu/matio/releases
ENV VERSION_MATIO=1.5.10

# http://www.linuxfromscratch.org/blfs/view/svn/general/nasm.html
ENV VERSION_NASM=2.13.01

# https://github.com/uclouvain/openjpeg/releases
ENV VERSION_OPENJPEG=2.1.2

# http://www.linuxfromscratch.org/blfs/view/8.0/postlfs/openssl.html
ENV VERSION_OPENSSL=1.0.2k

# https://github.com/GStreamer/orc/releases
ENV VERSION_ORC=0.4.26

# https://github.com/GNOME/pango/releases
ENV VERSION_PANGO=1.40.6

# http://www.linuxfromscratch.org/blfs/view/svn/general/pcre.html
ENV VERSION_PCRE=8.40

# https://github.com/jcupitt/php-vips-ext/releases
ENV VERSION_PHPVIPS=1.0.7

# https://www.cairographics.org/releases/
ENV VERSION_PIXMAN=0.34.0

# https://libpng.sourceforge.io/
ENV VERSION_PNG16=1.6.30

# https://poppler.freedesktop.org/
ENV VERSION_POPPLER=0.56.0

# https://github.com/GNOME/librsvg/releases
ENV VERSION_SVG=2.40.17

# http://www.linuxfromscratch.org/blfs/view/cvs/general/swig.html
ENV VERSION_SWIG=3.0.12

# https://github.com/vadz/libtiff/releases
ENV VERSION_TIFF=4.0.8

# https://github.com/jcupitt/php-vips-ext
ENV VERSION_EXT_VIPS_PHP=1.0.7

# https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html
ENV VERSION_WEBP=0.6.0

# https://github.com/GNOME/libxslt/releases
ENV VERSION_XLST=1.1.29

# https://github.com/GNOME/libxml2/releases
ENV VERSION_XML2=2.9.4

# https://github.com/madler/zlib/releases
# http://www.linuxfromscratch.org/lfs/view/development/chapter06/zlib.html
# Dependencies:
#   - None
ENV VERSION_ZLIB=1.2.11

# Least out-of-sync Sourceforge mirror
ENV SOURCEFORGE_MIRROR=netix

RUN /usr/bin/make


# http://www.linuxfromscratch.org/blfs/view/svn/general/pcre.html
# Dependencies:
#   - None
# Depended on by:
#   - php
#build pcre

# http://www.linuxfromscratch.org/blfs/view/svn/general/libffi.html
# Dependencies:
#   - None
# Depended on by:
#   - GLib
#build ffi

# http://www.linuxfromscratch.org/blfs/view/svn/general/libpng.html
# Dependencies:
#   - None
# Depended on by:
#   - gdk-pixbuf
#   - pixman
#   - cairo
#   - openjpeg
#   - poppler
#   - php
#   - ghostscript
#build png16

# http://www.linuxfromscratch.org/blfs/view/svn/general/nasm.html
# Dependencies:
#   - None
# Depended on by:
#   - libjpeg-turbo
#build nasm

# http://www.linuxfromscratch.org/blfs/view/svn/general/libexif.html
# Dependencies:
#   - None
# Depended on by:
#   - php
#build exif

# https://gstreamer.freedesktop.org/projects/orc.html
# Dependencies:
#   - None
# Depended on by:
#build orc

# http://www.linuxfromscratch.org/blfs/view/svn/general/icu.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
#build icu

# http://www.linuxfromscratch.org/blfs/view/8.0/general/giflib.html
# Dependencies:
#   - None
# Depended on by:
#   - libwebp
#build gif

# http://www.linuxfromscratch.org/blfs/view/7.5/general/expat.html
# Dependencies:
#   - None
# Depended on by:
#build expat

# http://www.linuxfromscratch.org/blfs/view/svn/general/librsvg.html
# Dependencies:
#   - None
# Depended on by:
#   - curl
#   - php
#build openssl

# http://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
# Dependencies:
#   - None
# Depended on by:
#   - vips
#build fftw3

################################################################################
#
# These have dependencies trees to satisfy
#
################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/general/libxml2.html
# Dependencies:
#   - zlib
#   - icu
# Depended on by:
#   - libxslt
#   - libgsf
#   - fontconfig
#   - croco
#   - php
#build xml2

# http://www.linuxfromscratch.org/blfs/view/cvs/general/swig.html
# Dependencies:
#   - pcre
# Depended on by:
#   - vips
#build swig

# http://www.linuxfromscratch.org/blfs/view/svn/general/pixman.html
# Dependencies:
#   - LibPNG
# Depended on by:
#   - Cairo
#build pixman

# http://www.linuxfromscratch.org/blfs/view/svn/general/libjpeg.html
# Dependencies:
#   - nasm
# Depended on by:
#   - gdk-pixbuf
#   - lcms2
#   - poppler
#   - php
#   - ghostscript
#build jpeg-turbo

# http://www.linuxfromscratch.org/blfs/view/cvs/general/libtiff.html
# Dependencies:
#   - libjpeg-turbo
# Depended on by:
#   - lcms2
#   - openjpeg
#   - poppler
#   - php
#   - ghostscript
#build tiff

# http://www.linuxfromscratch.org/blfs/view/cvs/general/libxslt.html
# Dependencies:
#   - libxml2
# Depended on by:
#   - php
#build xlst

# http://www.linuxfromscratch.org/blfs/view/cvs/general/glib2.html
# Dependencies:
#   - libffi
#   - Python
# Depended on by:
#   - libgsf
#   - gdk-pixbuf
#   - HarfBuzz
#   - Cairo
#   - croco
#build glib

# http://www.linuxfromscratch.org/blfs/view/svn/x/gdk-pixbuf.html
# Dependencies:
#   - GLib
#   - libjpeg-turbo
#   - libpng
# Depended on by:
#   - libsrvg
#build gdkpixbuf

# http://www.linuxfromscratch.org/blfs/view/svn/general/libgsf.html
# Dependencies:
#   - GLib
#   - libxml2
#   - gdk-pixbuf
# Depended on by:
#build gsf

# http://www.linuxfromscratch.org/blfs/view/cvs/general/lcms2.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
# Depended on by:
#   - openjpeg
#   - poppler
#   - ghostscript
#build lcms2

# http://www.linuxfromscratch.org/blfs/view/8.0/general/libwebp.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
#   - libpng
#   - giflib
# Depended on by:
#build webp

################################################################################
#
#   HarfBuzz wants freetype before it is installed, and freetype wants harfbuz
#   after it is installed. So we do this.
#
################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/general/freetype2.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
#build freetype

# http://www.linuxfromscratch.org/blfs/view/svn/general/fontconfig.html
# Dependencies:
#   - Freetype
#   - libxml
# Depended on by:
#   - harfbuzz
#   - Cairo
#build fontconfig

# http://www.linuxfromscratch.org/blfs/view/8.0/x/cairo.html
# Dependencies:
#   - libpng
#   - pixman
#   - fontconfig
#   - glib
# Depended on by:
#   - harfbuzz
#   - pango
#   - poppler
#   - ghostscript
#build cairo

# http://www.linuxfromscratch.org/blfs/view/svn/general/harfbuzz.html
# Dependencies:
#   - Freetype
# Depended on by:
#   - Freetype
#build harfbuzz

# http://www.linuxfromscratch.org/blfs/view/svn/general/freetype2.html
# Dependencies:
#   - HarfBuzz
# Depended on by:
#   - fontconfig
#   - php
#   - ghostscript
#rm -rf ${DEPS}/freetype
#build freetype

# http://www.linuxfromscratch.org/blfs/view/svn/general/fontconfig.html
# Dependencies:
#   - Freetype
#   - libxml
# Depended on by:
#   - pango
#   - poppler
#   - ghostscript
#rm -rf ${DEPS}/fontconfig
#build fontconfig

################################################################################
#
#   Stupid freetype harfbuzz
#
################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/x/pango.html
# Dependencies:
#   - FontConfig
#   - Cairo
# Depended on by:
#   - libsrvg
#build pango

# http://www.linuxfromscratch.org/blfs/view/svn/general/libcroco.html
# Dependencies:
#   - GLib
#   - libxml
# Depended on by:
#   - libsrvg
#build croco

# http://www.linuxfromscratch.org/blfs/view/svn/general/librsvg.html
# Dependencies:
#   - gdk-pixbuf
#   - croco
#   - pango
# Depended on by:
#build svg

# http://www.linuxfromscratch.org/blfs/view/8.0/basicnet/curl.html
# Dependencies:
#   - OpenSSL
# Depended on by:
#   - poppler
#   - php
#build curl

# http://www.linuxfromscratch.org/blfs/view/svn/general/openjpeg.html
# Dependencies:
#   - LCMS
#   - libpng
#   - libtiff
# Depended on by:
#   - poppler
#build openjpeg

# http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# Dependencies:
#   - fontconfig
#   - Cairo
#   - libjpeg
#   - libpng
#   - openjpeg
# Depended on by:
#   - vips
#build poppler

# http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# Dependencies:
#   - freetype
#   - libjpeg
#   - libpng
#   - libtiff
#   - lcms2
#   - cairo
#   - fontconfig
# Depended on by:
#   -
#build ghostscript

# http://www.linuxfromscratch.org/blfs/view/cvs/general/imagemagick.html
# Dependencies:
#   - curl
#   - fttw3
#   - lcms2
#   - libexif
#   - libjpeg-turbo
#   - libpng
#   - librsvg
#   - libtiff
#   - libwebp
#   - openjpeg
#   - pango
#   - ghostscript
# Depended on by:
#   - vips
#build imagemagick


# https://github.com/jcupitt/libvips
# Dependencies:
#   - libjpeg
#   - libexif
#   - giflib
#   - librsvg
#   - libpoppler
#   - libgsf-1
#   - libtiff
#   - fftw3
#   - lcms2
#   - libpng
#   - ImageMagick
#   - pango
#   - orc
#   - libwebp
#   - swig
# Depended on by:
#   - phpvips
#build vips

# http://www.linuxfromscratch.org/blfs/view/svn/general/php.html
# Dependencies:
#   - libxml2
#   - libxslt
#   - pcre
#   - freetype
#   - libexif
#   - libjpeg-turbo
#   - libpng
#   - libtiff
#   - curl
#   - openssl
# Depended on by:
#   - phpvips
#build php

# https://github.com/jcupitt/php-vips-ext
# Dependencies:
#   - vips
#   - php
# Depended on by:
#   - none
#build phpvips

# Remove the old C++ bindings
#cd ${TARGET}/include
#rm -rf vips/vipsc++.h vips/vipscpp.h
#cd ${TARGET}/lib
#rm -rf .libs *.la libvipsCC*

# Create JSON file of version numbers
#toJson

# Create .tar.gz
#packageVips
