#!/bin/sh

#以下编译环境测试通过
#Mac-->10.14.1
#FFmpeg-->4.1
#Ndk-->r14b

#cd ffmpeg

NDK=/Users/gongwen/FFmpeg/android-ndk-r14b
export PATH=$PATH:$NDK
SYSROOT=$NDK/platforms/android-21/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
export RANLIB=$TOOLCHAIN/bin/arm-linux-androideabi-ranlib
# 参考：https://juejin.im/post/5b1f655b5188257d3a69782d
# --enable-gpl \
# --enable-libx264 \
# --disable-encoders \
# --enable-encoder=mpeg4 \
# --enable-encoder=aac \
# --enable-encoder=libx264 \
# --disable-decoders \
# --enable-decoder=mpeg4 \
# --enable-decoder=aac \
# --enable-decoder=libx264 \
# --enable-parser=h264,aac \
# --enable-bsf=h264_mp4toannexb \
# --enable-bsf=aac_adtstoasc \

ARCH="arm"
CPU="armv7-a"
PREFIX=../android_lib/$CPU

function build_one
{
./configure \
--prefix=$PREFIX \
--enable-encoders \
--enable-decoders \
--enable-avdevice \
--enable-avfilter \
--enable-shared \
--disable-static \
--enable-small \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-doc \
--disable-symver \
--disable-asm \
--disable-programs \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--target-os=android \
--arch=${ARCH} \
--cpu=${CPU} \
--enable-cross-compile \
--sysroot=$SYSROOT \
--extra-cflags="-march=$CPU -mfpu=neon -mfloat-abi=softfp -mvectorize-with-neon-quad" \
--extra-ldflags="-Wl,--fix-cortex-a8" \
--extra-ldexeflags=-pie \

make clean
make -j8
make install
}

build_one