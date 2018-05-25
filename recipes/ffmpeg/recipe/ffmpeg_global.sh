#!/bin/bash
mkdir -p ~/ffmpeg_sources ~/bin

cd ~/ffmpeg_sources && \
wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.bz2 && \
tar xjvf nasm-2.13.03.tar.bz2 && \
cd nasm-2.13.03 && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
./autogen.sh && \
auto-apt run ./configure && \
make -j$(nproc) && \
sudo checkinstall --default



cd ~/ffmpeg_sources && \
wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
tar xzvf yasm-1.3.0.tar.gz && \
cd yasm-1.3.0 && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
auto-apt run ./configure && \
make -j$(nproc) && \
sudo checkinstall --default

cd ~/ffmpeg_sources && \
git -C x264 pull 2> /dev/null || git clone --depth 1 https://git.videolan.org/git/x264 && \
cd x264 && \
git fetch --all --tags --prune && \
VERSION=$(git describe --abbrev=0 --tags `git rev-list --tags --skip=0 --max-count=1`) && \
echo checking out ${VERSION} && \
git checkout ${VERSION} && \
auto-apt run ./configure \
--extra-cflags="-march=native -mtune=native" \
--enable-static \
--enable-pic && \
make -j$(nproc) && \
sudo checkinstall --default --pkgversion="$VERSION"


cd ~/ffmpeg_sources && \
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git && \
cd libvpx && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
git fetch --all --tags --prune && \
VERSION=$(git describe --abbrev=0 --tags `git rev-list --tags --skip=0 --max-count=1`) && \
echo checking out ${VERSION} && \
git checkout ${VERSION} && \
auto-apt run ./configure \
--disable-examples \
--disable-unit-tests \
--enable-vp9-highbitdepth \
--as=yasm && \
make -j$(nproc) && \
sudo checkinstall --default --pkgversion="$VERSION"

cd ~/ffmpeg_sources && \
git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac && \
cd fdk-aac && \
export VERSION=$(git rev-parse --short HEAD) && \
autoreconf -fiv && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
auto-apt run ./configure --disable-shared && \
make -j$(nproc) && \
sudo checkinstall --default --pkgversion="$VERSION"

cd ~/ffmpeg_sources && \
wget -O lame-3.100.tar.gz https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz && \
tar xzvf lame-3.100.tar.gz && \
cd lame-3.100 && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
auto-apt run ./configure \
--disable-shared \
--enable-nasm && \
make -j$(nproc) && \
sudo checkinstall --default


cd ~/ffmpeg_sources && \
git -C opus pull 2> /dev/null || git clone --depth 1 https://github.com/xiph/opus.git && \
cd opus && \
export VERSION=$(git rev-parse --short HEAD) && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
./autogen.sh && \
auto-apt run ./configure --disable-shared && \
make -j$(nproc) && \
sudo checkinstall --default --pkgversion="$VERSION"


sudo apt-get install libomxil-bellagio-dev libx265-dev -y && \
cd ~/ffmpeg_sources && \
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
export CFLAGS="-march=native -mtune=native" && \
export CXXFLAGS="-march=native -mtune=native" && \
auto-apt run ./configure \
--extra-libs="-lpthread -lm" \
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
make -j$(nproc) && \
sudo checkinstall --default
hash -r


export VERSION=$(git rev-parse --short HEAD)

echo "v1.7.0" | cut -d 'v' -f 2