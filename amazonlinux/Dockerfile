FROM stechstudio/aws-lambda-build:1.1.1
LABEL authors="Bubba Hines <bubba@stechstudio.com>"

# Create container suitable for building Lambda binaries

# Install devel where we can
RUN mkdir -p /deps
RUN mkdir -p /target
RUN mkdir -p /target/modules

# Compiler settings
ENV \
  PLATFORM="linux-x64" \
  FLAGS="-O3"
