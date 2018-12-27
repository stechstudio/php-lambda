FROM sts/lambda/php:latest

# # https://github.com/unicode-org/icu/releases
# # Needs:
# #   - None
# # Needed by:
# #   - PCRE
# #   - HarfBuzz
# ENV VERSION_ICU="63.1"
# COPY ./icu.mk ${DEPS}/icu.mk
# RUN /usr/bin/make -f ${DEPS}/icu.mk

# # https://www.pcre.org/
# # Needs:
# #   - zlib
# #   - ICU
# # Needed by:
# #   - glib
# #   - php
# ENV VERSION_PCRE="8.42"
# COPY ./pcre.mk ${DEPS}/pcre.mk
# RUN /usr/bin/make -f ${DEPS}/pcre.mk

# # https://github.com/libffi/libffi/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/general/libffi.html
# # Needs:
# #   - None
# # Needed by:
# #   - GLib
# ENV VERSION_FFI="3.2.1"
# COPY ./ffi.mk ${DEPS}/ffi.mk
# RUN /usr/bin/make -f ${DEPS}/ffi.mk



# # https://sourceforge.net/projects/libexif/files/libexif/
# # http://www.linuxfromscratch.org/blfs/view/svn/general/libexif.html
# # Needs:
# #   - None
# # Needed by:
# #   - php
# ENV VERSION_EXIF="0.6.21"
# COPY ./exif.mk ${DEPS}/exif.mk
# RUN /usr/bin/make -f ${DEPS}/exif.mk

# # https://github.com/GStreamer/orc/releases
# # https://gstreamer.freedesktop.org/projects/orc.html
# # Needs:
# #   - None
# # Needed by:
# ENV VERSION_ORC="0.4.28"
# COPY ./orc.mk ${DEPS}/orc.mk
# RUN /usr/bin/make -f ${DEPS}/orc.mk


# # https://sourceforge.net/projects/giflib/files/?source=navbar
# # http://www.linuxfromscratch.org/blfs/view/8.0/general/giflib.html
# # Needs:
# #   - None
# # Needed by:
# #   - libwebp
# ENV VERSION_GIF="5.1.4"
# COPY ./gif.mk ${DEPS}/gif.mk
# RUN /usr/bin/make -f ${DEPS}/gif.mk

# # https://sourceforge.net/projects/expat/files/expat/
# # http://www.linuxfromscratch.org/blfs/view/7.5/general/expat.html
# # Needs:
# #   - None
# # Needed by:
# ENV VERSION_EXPAT="2.2.6"
# COPY ./expat.mk ${DEPS}/expat.mk
# RUN /usr/bin/make -f ${DEPS}/expat.mk

# # http://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
# # Needs:
# #   - None
# # Needed by:
# #   - vips
# ENV VERSION_FFTW3="3.3.8"
# COPY ./fftw3.mk ${DEPS}/fftw3.mk
# RUN /usr/bin/make -f ${DEPS}/fftw3.mk

# ################################################################################
# #
# # These have dependencies trees to satisfy
# #
# ################################################################################



# # https://sourceforge.net/projects/swig/files/swig/
# # http://www.linuxfromscratch.org/blfs/view/cvs/general/swig.html
# # Needs:
# #   - pcre
# # Needed by:
# #   - vips
# ENV VERSION_SWIG="3.0.12"
# COPY ./swig.mk ${DEPS}/swig.mk
# RUN /usr/bin/make -f ${DEPS}/swig.mk

# # https://www.cairographics.org/releases/
# # http://www.linuxfromscratch.org/blfs/view/svn/general/pixman.html
# # Needs:
# #   - LibPNG
# # Needed by:
# #   - Cairo
# ENV VERSION_PIXMAN="0.36.0"
# COPY ./pixman.mk ${DEPS}/pixman.mk
# RUN /usr/bin/make -f ${DEPS}/pixman.mk

# # https://github.com/vadz/libtiff/releases
# # http://www.linuxfromscratch.org/blfs/view/cvs/general/libtiff.html
# # Needs:
# #   - libjpeg-turbo
# # Needed by:
# #   - lcms2
# #   - openjpeg
# #   - poppler
# #   - php
# #   - ghostscript
# ENV VERSION_TIFF="4.0.9"
# COPY ./tiff.mk ${DEPS}/tiff.mk
# RUN /usr/bin/make -f ${DEPS}/tiff.mk

# # https://github.com/GNOME/libxslt/releases
# # http://www.linuxfromscratch.org/blfs/view/cvs/general/libxslt.html
# # Needs:
# #   - libxml2
# # Needed by:
# #   - php
# ENV VERSION_XLST="1.1.32"
# COPY ./xlst.mk ${DEPS}/xlst.mk
# RUN /usr/bin/make -f ${DEPS}/xlst.mk

# # https://github.com/GNOME/glib/releases
# # http://www.linuxfromscratch.org/blfs/view/cvs/general/glib2.html
# # Needs:
# #   - libffi
# #   - Python
# # Needed by:
# #   - libgsf
# #   - gdk-pixbuf
# #   - HarfBuzz
# #   - Cairo
# #   - croco
# ENV VERSION_GLIB="2.58.2"
# COPY ./glib.mk ${DEPS}/glib.mk
# RUN /usr/bin/make -f ${DEPS}/glib.mk

# # https://github.com/GNOME/gdk-pixbuf/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/x/gdk-pixbuf.html
# # Needs:
# #   - GLib
# #   - libjpeg-turbo
# #   - libpng
# # Needed by:
# #   - libsrvg
# ENV VERSION_GDKPIXBUF="2.38.0"
# COPY ./gdkpixbuf.mk ${DEPS}/gdkpixbuf.mk
# RUN /usr/bin/make -f ${DEPS}/gdkpixbuf.mk

# # https://github.com/GNOME/libgsf/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/general/libgsf.html
# # Needs:
# #   - GLib
# #   - libxml2
# #   - gdk-pixbuf
# # Needed by:
# ENV VERSION_GSF="1.14.45"
# COPY ./gsf.mk ${DEPS}/gsf.mk
# RUN /usr/bin/make -f ${DEPS}/gsf.mk

# # https://github.com/mm2/Little-CMS/releases
# # http://www.linuxfromscratch.org/blfs/view/cvs/general/lcms2.html
# # Needs:
# #   - libjpeg-turbo
# #   - libtiff
# # Needed by:
# #   - openjpeg
# #   - poppler
# #   - ghostscript
# ENV VERSION_LCMS2="2.9"
# COPY ./lcms2.mk ${DEPS}/lcms2.mk
# RUN /usr/bin/make -f ${DEPS}/lcms2.mk

# ################################################################################
# #
# #   HarfBuzz wants freetype before it is installed, and freetype wants harfbuz
# #   after it is installed. So we do this.
# #
# ################################################################################

# # https://sourceforge.net/projects/freetype/files/freetype2/
# # http://www.linuxfromscratch.org/blfs/view/svn/general/freetype2.html
# # Needs:
# #   - None
# # Needed by:
# #   - HarfBuzz
# ENV VERSION_FREETYPE="2.9.1"
# COPY ./freetype.mk ${DEPS}/freetype.mk
# RUN /usr/bin/make -f ${DEPS}/freetype.mk

# # https://www.freedesktop.org/wiki/Software/fontconfig/
# # http://www.linuxfromscratch.org/blfs/view/svn/general/fontconfig.html
# # Needs:
# #   - Freetype
# #   - libxml
# # Needed by:
# #   - harfbuzz
# #   - Cairo
# ENV VERSION_FONTCONFIG="2.13.1"
# COPY ./fontconfig.mk ${DEPS}/fontconfig.mk
# RUN /usr/bin/make -f ${DEPS}/fontconfig.mk

# # https://www.cairographics.org/releases/
# # http://www.linuxfromscratch.org/blfs/view/8.0/x/cairo.html
# # Needs:
# #   - libpng
# #   - pixman
# #   - fontconfig
# #   - glib
# # Needed by:
# #   - harfbuzz
# #   - pango
# #   - poppler
# #   - ghostscript
# ENV VERSION_CAIRO="1.16.0"
# COPY ./cairo.mk ${DEPS}/cairo.mk
# RUN /usr/bin/make -f ${DEPS}/cairo.mk


# # https://github.com/behdad/harfbuzz/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/general/harfbuzz.html
# # Needs:
# #   - Freetype
# # Needed by:
# #   - Freetype
# ENV VERSION_HARFBUZZ="2.3.0"
# COPY ./harfbuzz.mk ${DEPS}/harfbuzz.mk
# RUN /usr/bin/make -f ${DEPS}/harfbuzz.mk

# # Because, craziness
# RUN  rm -rf ${DEPS}/freetype
# RUN /usr/bin/make -f ${DEPS}/freetype.mk
# RUN rm -rf ${DEPS}/fontconfig
# RUN /usr/bin/make -f ${DEPS}/fontconfig.mk

# ################################################################################
# #
# #   Stupid freetype harfbuzz
# #
# ################################################################################

# # https://github.com/GNOME/pango/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/x/pango.html
# # Needs:
# #   - FontConfig
# #   - Cairo
# # Needed by:
# #   - libsrvg
# ENV VERSION_PANGO="1.43.0"
# ENV VERSION_PANGO_SHORT="1.43"
# COPY ./pango.mk ${DEPS}/pango.mk
# RUN /usr/bin/make -f ${DEPS}/pango.mk

# # https://github.com/GNOME/libcroco/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/general/libcroco.html
# # Needs:
# #   - GLib
# #   - libxml
# # Needed by:
# #   - libsrvg
# ENV VERSION_CROCO="0.6.12"
# COPY ./croco.mk ${DEPS}/croco.mk
# RUN /usr/bin/make -f ${DEPS}/croco.mk

# # https://github.com/GNOME/librsvg/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/general/librsvg.html
# # Needs:
# #   - gdk-pixbuf
# #   - croco
# #   - pango
# # Needed by:
# # ENV VERSION_SVG=2.45.1
# # ENV VERSION_SVG_SHORT=2.45
# # COPY ./svg.mk ${DEPS}/svg.mk
# # RUN /usr/bin/make -f ${DEPS}/svg.mk
# # RUN echo $(cat ${VERSIONS_FILE} | jq --arg svg ${VERSION_SVG} '.libraries += {svg: $svg}') > ${VERSIONS_FILE}

# # https://github.com/uclouvain/openjpeg/releases
# # http://www.linuxfromscratch.org/blfs/view/svn/general/openjpeg.html
# # Needs:
# #   - LCMS
# #   - libpng
# #   - libtiff
# # Needed by:
# #   - poppler
# ENV VERSION_OPENJPEG="2.3.0"
# COPY ./openjpeg.mk ${DEPS}/openjpeg.mk
# RUN /usr/bin/make -f ${DEPS}/openjpeg.mk

# # https://poppler.freedesktop.org/
# # http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# # Needs:
# #   - fontconfig
# #   - Cairo
# #   - libjpeg
# #   - libpng
# #   - openjpeg
# # Needed by:
# #   - vips
# ENV VERSION_POPPLER="0.62.0"
# COPY ./poppler.mk ${DEPS}/poppler.mk
# RUN /usr/bin/make -f ${DEPS}/poppler.mk

# # https://github.com/ArtifexSoftware/ghostpdl-downloads/releases
# # http://www.linuxfromscratch.org/blfs/view/cvs/pst/gs.html
# # Needs:
# #   - freetype
# #   - libjpeg
# #   - libpng
# #   - libtiff
# #   - lcms2
# #   - cairo
# #   - fontconfig
# # Needed by:
# # 
# ENV VERSION_GHOSTSCRIPT="9.26"
# ENV VERSION_GHOSTSCRIPT_NODOT="926"
# COPY ./ghostscript.mk  ${DEPS}/ghostscript.mk 
# RUN /usr/bin/make -f ${DEPS}/ghostscript.mk 

# # https://www.imagemagick.org/download/releases/
# # http://www.linuxfromscratch.org/blfs/view/cvs/general/imagemagick.html
# # Needs:
# #   - curl
# #   - fttw3
# #   - lcms2
# #   - libexif
# #   - libjpeg-turbo
# #   - libpng
# #   - librsvg
# #   - libtiff
# #   - libwebp
# #   - openjpeg
# #   - pango
# #   - ghostscript
# # Needed by:
# #   - vips
# ENV VERSION_IMAGEMAGICK="7.0.8-19"
# COPY ./imagemagick.mk ${DEPS}/imagemagick.mk
# RUN /usr/bin/make -f ${DEPS}/imagemagick.mk

# # https://github.com/jcupitt/libvips
# # Needs:
# #   - libjpeg
# #   - libexif
# #   - giflib
# #   - librsvg
# #   - libpoppler
# #   - libgsf-1
# #   - libtiff
# #   - fftw3
# #   - lcms2
# #   - libpng
# #   - ImageMagick
# #   - pango
# #   - orc
# #   - libwebp
# #   - swig
# # Needed by:
# #   - phpvips
# #build vips
# ENV VERSION_VIPS="8.7.0"
# COPY ./vips.mk ${DEPS}/vips.mk
# RUN /usr/bin/make -f ${DEPS}/vips.mk