#!/usr/bin/env bash

export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./make -j$(nproc)

cd userland && \
mkdir build && \
cd build && \
export CFLAGS="-march=native -mtune=native " && \
export CXXFLAGS="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" \
-DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build"\
-DENABLE_SHARED=off \
.. && \
PATH="$HOME/bin:$PATH" make -j$(nproc) && \
make install



export CFLAGS="-march=native -mtune=native -I${HOME}/ffmpeg_build/include -L${HOME}/ffmpeg_build/lib" && \
export CXXFLAGS="-march=native -mtune=native -I${HOME}/ffmpeg_build/include -L${HOME}/ffmpeg_build/lib" &&\
export PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" && make -j$(nproc)