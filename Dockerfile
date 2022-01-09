FROM debian:11-slim

RUN apt-get update && apt-get install --no-install-recommends -y \
    avr-libc \
    avrdude \
    binutils-arm-none-eabi \
    binutils-avr \
    binutils-riscv64-unknown-elf \
    build-essential \
    ca-certificates \
    clang-format-11 \
    dfu-programmer \
    dfu-util \
    dos2unix \
    ca-certificates \
    gcc \
    gcc-avr \
    gcc-arm-none-eabi \
    gcc-riscv64-unknown-elf \
    git \
    libnewlib-arm-none-eabi \
    picolibc-riscv64-unknown-elf \
    python3 \
    python3-pip \
    software-properties-common \
    tar \
    teensy-loader-cli \
    unzip \
    tar \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# upgrade gcc-arm-none-eabi from the default to 10.2 (2020-q4-major) due to ARM runtime issues
RUN /bin/bash -c "set -o pipefail && \
    wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 -O - | tar xj --strip-components=1 -C / && \
    rm -rf /arm-none-eabi/share/ /share/"
    
RUN pip3 install --upgrade pip setuptools

# Install python packages
RUN python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m pip install nose2 qmk

# Set the default location for qmk_firmware
ENV QMK_HOME /qmk_firmware
