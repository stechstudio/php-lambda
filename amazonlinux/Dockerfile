FROM stechstudio/aws-lambda-build:1.1.0
LABEL authors="Bubba Hines <bubba@stechstudio.com>"

# Create container suitable for building Lambda binaries

# Install devel where we can
RUN rpm --rebuilddb && yum install -y libxml2-devel libssh2-devel libpng-devel gmp-devel
RUN mkdir /target
RUN mkdir -p /deps

# Compiler settings
ENV \
  PLATFORM="linux-x64" \
  FLAGS="-O3"
