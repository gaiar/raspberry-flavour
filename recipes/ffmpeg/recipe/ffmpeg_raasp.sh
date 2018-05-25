#!/bin/bash
mkdir -p ~/ffmpeg_sources ~/bin

cd ~/ffmpeg_sources && \
wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.bz2 && \
tar xjvf nasm-2.13.03.tar.bz2 && \
cd nasm-2.13.03 && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
./autogen.sh && \
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" && \
make -j$(nproc) && \
make install

cd ~/ffmpeg_sources && \
wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
tar xzvf yasm-1.3.0.tar.gz && \
cd yasm-1.3.0 && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" && \
make -j$(nproc) && \
make install

cd ~/ffmpeg_sources && \
git -C x264 pull 2> /dev/null || git clone --depth 1 https://git.videolan.org/git/x264 && \
cd x264 && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
--prefix="$HOME/ffmpeg_build" \
--extra-cflags="-march=native -mtune=native" \
--bindir="$HOME/bin" \
--enable-static \
--enable-pic && \
PATH="$HOME/bin:$PATH" make -j$(nproc) && \
make install


sudo apt-get install mercurial && \
cd ~/ffmpeg_sources && \
if cd x265 2> /dev/null; then hg pull && hg update; else hg clone https://bitbucket.org/multicoreware/x265; fi && \
cd build/arm-linux && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" \
-DENABLE_LIBNUMA=OFF \
-DENABLE_PIC=ON \
-DHIGH_BIT_DEPTH=ON \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" \
../../source && \
PATH="$HOME/bin:$PATH" ccmake ../../source && \
make install

cd ~/ffmpeg_sources && \
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git && \
cd libvpx && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" ./configure \
--prefix="$HOME/ffmpeg_build" \
--disable-examples \
--disable-unit-tests \
--enable-vp9-highbitdepth \
--as=yasm && \
PATH="$HOME/bin:$PATH" make -j$(nproc) && \
make install

cd ~/ffmpeg_sources && \
git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac && \
cd fdk-aac && \
autoreconf -fiv && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
./configure --prefix="$HOME/ffmpeg_build" --disable-shared && \
make -j$(nproc) && \
make install

cd ~/ffmpeg_sources && \
wget -O lame-3.100.tar.gz https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz && \
tar xzvf lame-3.100.tar.gz && \
cd lame-3.100 && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" ./configure \
--prefix="$HOME/ffmpeg_build" \
--bindir="$HOME/bin" \
--disable-shared \
--enable-nasm && \
PATH="$HOME/bin:$PATH" make -j$(nproc) && \
make install

cd ~/ffmpeg_sources && \
git -C opus pull 2> /dev/null || git clone --depth 1 https://github.com/xiph/opus.git && \
cd opus && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
./autogen.sh && \
./configure --prefix="$HOME/ffmpeg_build" --disable-shared && \
make -j$(nproc) && \
make install


cd ~/ffmpeg_sources && \
git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom && \
mkdir -p aom_build && \
cd aom_build && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" \
-DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build"\
-DENABLE_SHARED=off \
-DAOM_TARGET_CPU=armv7 \
-DENABLE_NASM=on ../aom && \
PATH="$HOME/bin:$PATH" make -j$(nproc) && \
make install


sudo apt-get install libomxil-bellagio-dev libx265-dev -y && \
cd ~/ffmpeg_sources && \
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
--prefix="$HOME/ffmpeg_build" \
--pkg-config-flags="--static" \
--extra-cflags="-I$HOME/ffmpeg_build/include" \
--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
--extra-libs="-lpthread -lm" \
--bindir="$HOME/bin" \
--enable-gpl \
--enable-nonfree \
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
--enable-static \
--enable-hardcoded-tables \
--extra-cflags="-march=native -mtune=native" && \
PATH="$HOME/bin:$PATH" make -j$(nproc) && \
make install && \
hash -r
