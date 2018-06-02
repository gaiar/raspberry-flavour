#!/bin/bash

CFLAGS="-march=native -mtune=native"

export CFLAGS
export CXXFLAGS="${CFLAGS}"

chmod +x configure
./configure --prefix=${PREFIX}

make -j${CPU_COUNT}
make check -j${CPU_COUNT}
make install -j${CPU_COUNT}