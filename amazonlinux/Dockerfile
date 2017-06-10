FROM stechstudio/aws-lambda-build:develop
LABEL authors="Bubba Hines <bubba@stechstudio.com>"

# Create container suitable for building Lambda binaries

# Just install devel where we can
RUN rpm --rebuilddb && yum install -y libxml2-devel libssh2-devel libpng-devel gmp-devel

# Compiler settings
ENV \
  PLATFORM="linux-x64" \
  FLAGS="-O3"
