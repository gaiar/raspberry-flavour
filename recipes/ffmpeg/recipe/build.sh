#!/bin/bash

# unset the SUBDIR variable since it changes the behavior of make here
unset SUBDIR

./configure \
        --prefix="${PREFIX}" \
        --disable-doc \
        --enable-shared \
        --enable-static \
        --extra-cflags="-march=native -mtune=native" \
        --extra-cxxflags="-march=native -mtune=native" \
        --extra-libs="-lpthread -lm -lz" \
        --enable-nonfree \
        --enable-gpl \
        --enable-libass \
        --enable-libfdk-aac \
        --enable-libfreetype \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
        --enable-libx265 \
        --enable-mmal \
        --enable-omx-rpi \
        --enable-omx \
        --enable-libxcb \
        --enable-zlib \
        --enable-pic \
        --enable-pthreads \
        --enable-version3 \
        --enable-hardcoded-tables \
        --enable-avresample \
        --enable-gnutls

make -j${CPU_COUNT}
make install -j${CPU_COUNT}
