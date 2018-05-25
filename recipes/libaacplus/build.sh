#!/bin/bash

mkdir -vp "${PREFIX}"/bin

CFLAGS="-march=native -mtune=native"

export CFLAGS
export CXXFLAGS="${CFLAGS}"

chmod +x configure
./configure \
--enable-pic \
--enable-shared \
--enable-static \
--prefix=${PREFIX}

make -j${CPU_COUNT}
make install -j${CPU_COUNT}


wget http://tipok.org.ua/downloads/media/aacplus/libaacplus/libaacplus-2.0.2.tar.gz && \
tar -xzf libaacplus-2.0.2.tar.gz && \
cd libaacplus-2.0.2 && \
PATH="$HOME/bin:$PATH" ./autogen.sh --enable-static --prefix="$HOME/ffmpeg_build" && \
make -j4 && \
make install