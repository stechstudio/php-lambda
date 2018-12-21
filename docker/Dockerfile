FROM amazonlinux:2017.03 as builder
LABEL authors="Bubba Hines <bubba@stechstudio.com>"

# Working Directory
WORKDIR /root

# Lambda is based on 2017.03. Lock YUM to that release version.
RUN sed -i 's/releasever=latest/releaserver=2017.03/' /etc/yum.conf

RUN yum makecache fast
RUN yum groupinstall -y "Development Tools"  --setopt=group_package_types=mandatory,default
RUN yum install -y gperf
RUN yum install -y gtk-doc
RUN yum install -y texlive
RUN yum install -y gmp-devel
RUN yum install -y libssh2-devel
RUN yum install -y libmount-devel
RUN yum install -y python27-devel
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

# Least out-of-sync Sourceforge mirror
ENV SOURCEFORGE_MIRROR=netix

# https://github.com/madler/zlib/releases
# http://www.linuxfromscratch.org/lfs/view/development/chapter06/zlib.html
# Dependencies:
#   - None
ENV VERSION_ZLIB=1.2.11
COPY build/zlib.mk ${DEPS}/zlib.mk
RUN /usr/bin/make -f ${DEPS}/zlib.mk


# http://www.linuxfromscratch.org/blfs/view/svn/general/pcre.html
# Dependencies:
#   - None
# Depended on by:
#   - php
ENV VERSION_PCRE=8.40
COPY build/pcre.mk ${DEPS}/pcre.mk
RUN /usr/bin/make -f ${DEPS}/pcre.mk

# https://github.com/libffi/libffi/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/libffi.html
# Dependencies:
#   - None
# Depended on by:
#   - GLib
ENV VERSION_FFI=3.2.1
COPY build/ffi.mk ${DEPS}/ffi.mk
RUN /usr/bin/make -f ${DEPS}/ffi.mk

# https://libpng.sourceforge.io/
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
ENV VERSION_PNG16=1.6.36
COPY build/png16.mk ${DEPS}/png16.mk
RUN /usr/bin/make -f ${DEPS}/png16.mk

# http://www.linuxfromscratch.org/blfs/view/svn/general/nasm.html
# Dependencies:
#   - None
# Depended on by:
#   - libjpeg-turbo
ENV VERSION_NASM=2.13.01
COPY build/nasm.mk ${DEPS}/nasm.mk
RUN /usr/bin/make -f ${DEPS}/nasm.mk

# https://sourceforge.net/projects/libexif/files/libexif/
# http://www.linuxfromscratch.org/blfs/view/svn/general/libexif.html
# Dependencies:
#   - None
# Depended on by:
#   - php
ENV VERSION_EXIF=0.6.21
COPY build/exif.mk ${DEPS}/exif.mk
RUN /usr/bin/make -f ${DEPS}/exif.mk

# https://github.com/GStreamer/orc/releases
# https://gstreamer.freedesktop.org/projects/orc.html
# Dependencies:
#   - None
# Depended on by:
ENV VERSION_ORC=0.4.26
COPY build/orc.mk ${DEPS}/orc.mk
RUN /usr/bin/make -f ${DEPS}/orc.mk

# http://www.linuxfromscratch.org/blfs/view/svn/general/icu.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
ENV VERSION_ICU=63.1
ENV VERSION_ICU_UNDERSCORE=63_1
COPY build/icu.mk ${DEPS}/icu.mk
RUN /usr/bin/make -f ${DEPS}/icu.mk

# https://sourceforge.net/projects/giflib/files/?source=navbar
# http://www.linuxfromscratch.org/blfs/view/8.0/general/giflib.html
# Dependencies:
#   - None
# Depended on by:
#   - libwebp
ENV VERSION_GIF=5.1.4
COPY build/gif.mk ${DEPS}/gif.mk
RUN /usr/bin/make -f ${DEPS}/gif.mk

# https://sourceforge.net/projects/expat/files/expat/
# http://www.linuxfromscratch.org/blfs/view/7.5/general/expat.html
# Dependencies:
#   - None
# Depended on by:
ENV VERSION_EXPAT=2.2.1
COPY build/expat.mk ${DEPS}/expat.mk
RUN /usr/bin/make -f ${DEPS}/expat.mk

# http://www.linuxfromscratch.org/blfs/view/8.0/postlfs/openssl.html
# Dependencies:
#   - None
# Depended on by:
#   - curl
#   - php
ENV VERSION_OPENSSL=1.0.2k
COPY build/openssl.mk ${DEPS}/openssl.mk
RUN /usr/bin/make -f ${DEPS}/openssl.mk

# http://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
# Dependencies:
#   - None
# Depended on by:
#   - vips
ENV VERSION_FFTW3=3.3.6-pl2
COPY build/fftw3.mk ${DEPS}/fftw3.mk
RUN /usr/bin/make -f ${DEPS}/fftw3.mk

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
# https://github.com/GNOME/libxml2/releases
ENV VERSION_XML2=2.9.4
COPY build/xml2.mk ${DEPS}/xml2.mk
RUN /usr/bin/make -f ${DEPS}/xml2.mk

# http://www.linuxfromscratch.org/blfs/view/cvs/general/swig.html
# Dependencies:
#   - pcre
# Depended on by:
#   - vips
ENV VERSION_SWIG=3.0.12
COPY build/swig.mk ${DEPS}/swig.mk
RUN /usr/bin/make -f ${DEPS}/swig.mk

# https://www.cairographics.org/releases/
# http://www.linuxfromscratch.org/blfs/view/svn/general/pixman.html
# Dependencies:
#   - LibPNG
# Depended on by:
#   - Cairo
ENV VERSION_PIXMAN=0.34.0
COPY build/pixman.mk ${DEPS}/pixman.mk
RUN /usr/bin/make -f ${DEPS}/pixman.mk

# https://github.com/libjpeg-turbo/libjpeg-turbo/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/libjpeg.html
# Dependencies:
#   - nasm
# Depended on by:
#   - gdk-pixbuf
#   - lcms2
#   - poppler
#   - php
#   - ghostscript
ENV VERSION_JPGTURBO=1.5.1
COPY build/jpeg-turbo.mk ${DEPS}/jpeg-turbo.mk
RUN /usr/bin/make -f ${DEPS}/jpeg-turbo.mk

# https://github.com/vadz/libtiff/releases
# http://www.linuxfromscratch.org/blfs/view/cvs/general/libtiff.html
# Dependencies:
#   - libjpeg-turbo
# Depended on by:
#   - lcms2
#   - openjpeg
#   - poppler
#   - php
#   - ghostscript
ENV VERSION_TIFF=4.0.9
COPY build/tiff.mk ${DEPS}/tiff.mk
RUN /usr/bin/make -f ${DEPS}/tiff.mk

# https://github.com/GNOME/libxslt/releases
# http://www.linuxfromscratch.org/blfs/view/cvs/general/libxslt.html
# Dependencies:
#   - libxml2
# Depended on by:
#   - php
ENV VERSION_XLST=1.1.29
COPY build/xlst.mk ${DEPS}/xlst.mk
RUN /usr/bin/make -f ${DEPS}/xlst.mk

# https://github.com/GNOME/glib/releases
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
ENV VERSION_GLIB=2.52.0
COPY build/glib.mk ${DEPS}/glib.mk
RUN /usr/bin/make -f ${DEPS}/glib.mk

# https://github.com/GNOME/gdk-pixbuf/releases
# http://www.linuxfromscratch.org/blfs/view/svn/x/gdk-pixbuf.html
# Dependencies:
#   - GLib
#   - libjpeg-turbo
#   - libpng
# Depended on by:
#   - libsrvg
ENV VERSION_GDKPIXBUF=2.36.6
COPY build/gdkpixbuf.mk ${DEPS}/gdkpixbuf.mk
RUN /usr/bin/make -f ${DEPS}/gdkpixbuf.mk

# https://github.com/GNOME/libgsf/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/libgsf.html
# Dependencies:
#   - GLib
#   - libxml2
#   - gdk-pixbuf
# Depended on by:
ENV VERSION_GSF=1.14.41
COPY build/gsf.mk ${DEPS}/gsf.mk
RUN /usr/bin/make -f ${DEPS}/gsf.mk

# https://github.com/mm2/Little-CMS/releases
# http://www.linuxfromscratch.org/blfs/view/cvs/general/lcms2.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
# Depended on by:
#   - openjpeg
#   - poppler
#   - ghostscript
ENV VERSION_LCMS2=2.8
COPY build/lcms2.mk ${DEPS}/lcms2.mk
RUN /usr/bin/make -f ${DEPS}/lcms2.mk

# https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html
# http://www.linuxfromscratch.org/blfs/view/8.0/general/libwebp.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
#   - libpng
#   - giflib
# Depended on by:
ENV VERSION_WEBP=0.6.0
COPY build/webp.mk ${DEPS}/webp.mk
RUN /usr/bin/make -f ${DEPS}/webp.mk

################################################################################
#
#   HarfBuzz wants freetype before it is installed, and freetype wants harfbuz
#   after it is installed. So we do this.
#
################################################################################

# https://sourceforge.net/projects/freetype/files/freetype2/
# http://www.linuxfromscratch.org/blfs/view/svn/general/freetype2.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
ENV VERSION_FREETYPE=2.9.1
COPY build/freetype.mk ${DEPS}/freetype.mk
RUN /usr/bin/make -f ${DEPS}/freetype.mk

# https://www.freedesktop.org/wiki/Software/fontconfig/
# http://www.linuxfromscratch.org/blfs/view/svn/general/fontconfig.html
# Dependencies:
#   - Freetype
#   - libxml
# Depended on by:
#   - harfbuzz
#   - Cairo
ENV VERSION_FONTCONFIG=2.13.1
COPY build/fontconfig.mk ${DEPS}/fontconfig.mk
RUN /usr/bin/make -f ${DEPS}/fontconfig.mk

# https://www.cairographics.org/releases/
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
ENV VERSION_CAIRO=1.14.10
COPY build/cairo.mk ${DEPS}/cairo.mk
RUN /usr/bin/make -f ${DEPS}/cairo.mk

# https://github.com/behdad/harfbuzz/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/harfbuzz.html
# Dependencies:
#   - Freetype
# Depended on by:
#   - Freetype
ENV VERSION_HARFBUZZ=2.2.0
COPY build/harfbuzz.mk ${DEPS}/harfbuzz.mk
RUN /usr/bin/make -f ${DEPS}/harfbuzz.mk

# Because, craziness
RUN  rm -rf ${DEPS}/freetype
COPY build/freetype.mk ${DEPS}/freetype.mk
RUN /usr/bin/make -f ${DEPS}/freetype.mk

# Because, craziness
RUN rm -rf ${DEPS}/fontconfig
COPY build/fontconfig.mk ${DEPS}/fontconfig.mk
RUN /usr/bin/make -f ${DEPS}/fontconfig.mk

################################################################################
#
#   Stupid freetype harfbuzz
#
################################################################################

# https://github.com/GNOME/pango/releases
# http://www.linuxfromscratch.org/blfs/view/svn/x/pango.html
# Dependencies:
#   - FontConfig
#   - Cairo
# Depended on by:
#   - libsrvg
ENV VERSION_PANGO=1.40.6

# https://github.com/GNOME/libcroco/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/libcroco.html
# Dependencies:
#   - GLib
#   - libxml
# Depended on by:
#   - libsrvg
ENV VERSION_CROCO=0.6.12

# https://github.com/GNOME/librsvg/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/librsvg.html
# Dependencies:
#   - gdk-pixbuf
#   - croco
#   - pango
# Depended on by:
ENV VERSION_SVG=2.40.17

# http://www.linuxfromscratch.org/blfs/view/8.0/basicnet/curl.html
# Dependencies:
#   - OpenSSL
# Depended on by:
#   - poppler
#   - php
# https://github.com/curl/curl/releases
ENV VERSION_CURL=7.54.1

# https://github.com/uclouvain/openjpeg/releases
# http://www.linuxfromscratch.org/blfs/view/svn/general/openjpeg.html
# Dependencies:
#   - LCMS
#   - libpng
#   - libtiff
# Depended on by:
#   - poppler
ENV VERSION_OPENJPEG=2.1.2

# https://poppler.freedesktop.org/
# http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# Dependencies:
#   - fontconfig
#   - Cairo
#   - libjpeg
#   - libpng
#   - openjpeg
# Depended on by:
#   - vips
ENV VERSION_POPPLER=0.56.0

# http://www.linuxfromscratch.org/blfs/view/cvs/pst/gs.html
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
# 
ENV VERSION_GHOSTSCRIPT=9.21

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
ENV VERSION_IMAGEMAGICK=7.0.4-8


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
ENV VERSION_VIPS=8.5.6

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
ENV VERSION_PHP=7.1.6 

# https://github.com/jcupitt/php-vips-ext/releases
# https://github.com/jcupitt/php-vips-ext
# Dependencies:
#   - vips
#   - php
# Depended on by:
#   - none
ENV VERSION_PHPVIPS=1.0.7

# Remove the old C++ bindings
#cd ${TARGET}/include
#rm -rf vips/vipsc++.h vips/vipscpp.h
#cd ${TARGET}/lib
#rm -rf .libs *.la libvipsCC*

# Create JSON file of version numbers
#toJson

# Create .tar.gz
#packageVips


# https://github.com/mkoppanen/imagick/releases
ENV VERSION_IMAGICK=3.4.3

# https://github.com/tbeu/matio/releases
ENV VERSION_MATIO=1.5.10