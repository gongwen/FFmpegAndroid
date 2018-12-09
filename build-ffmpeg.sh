#!/bin/sh

#以下编译环境测试通过
#Mac-->10.14.1
#FFmpeg-->master(4.1)
#Ndk-->r14b
# 参考自：使用Android Studio开发FFmpeg的正确姿势-https://www.jianshu.com/p/0a7f3175c1b9
# https://github.com/FFmpeg/FFmpeg/blob/master/configure
cd ffmpeg

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
--target-os=android \
--arch=${ARCH} \
--cpu=${CPU} \
--sysroot=$SYSROOT \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--extra-cflags="-march=$CPU -mfpu=neon -mfloat-abi=softfp -mvectorize-with-neon-quad" \
--extra-ldflags="-Wl,--fix-cortex-a8" \
--extra-ldexeflags=-pie \
--enable-cross-compile \
--enable-gpl \
--enable-nonfree \
--disable-doc \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-network \
--disable-symver \
--disable-asm \
--disable-programs \
--disable-static \
--enable-shared \
--enable-small \
--enable-protocols \
--enable-avdevice \
--enable-encoders \
--enable-decoders \
--enable-avfilter \

$ADDITIONAL_CONFIGURE_FLAG


make clean
make -j8
make install
}

build_one