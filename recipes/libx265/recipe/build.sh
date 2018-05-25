#!/bin/bash

CFLAGS="-march=native -mtune=native"

export CFLAGS
export CXXFLAGS="${CFLAGS}"

cd build/arm-linux || exit
cmake -G "Unix Makefiles" -DENABLE_LIBNUMA=OFF -DENABLE_PIC=ON -DNATIVE_BUILD=ON -DENABLE_SHARED=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX ../../source
make -j ${CPU_COUNT} 
make install PREFIX=${PREFIX}

