#!/bin/bash

mkdir -vp ${PREFIX}/bin

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
