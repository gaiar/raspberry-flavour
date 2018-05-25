#!/bin/bash

mkdir -vp ${PREFIX}/bin

CFLAGS="-march=native -mtune=native"

export CFLAGS
export CXXFLAGS="${CFLAGS}"

chmod +x configure
./configure --prefix=${PREFIX} --bindir="${PREFIX}/bin" --disable-shared --enable-nasm && \
make -j${CPU_COUNT}
make install -j${CPU_COUNT}