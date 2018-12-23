#!/bin/bash

cd x264

NDK=/Users/gongwen/FFmpeg/android-ndk-r14b
SYSROOT=$NDK/platforms/android-21/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64

CPU="armv7-a"
PREFIX=../lib_ext/$CPU/x264

ADDI_CFLAGS=""
ADDI_LDFLAGS=""


function build_x264
{
./configure \
    --prefix=$PREFIX \
    --disable-asm \
    --disable-cli \
    --enable-static \
    --enable-pic \
    --enable-strip \
    --host=arm-linux-androideabi \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $ADDI_CFLAGS $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make -j4
make install
}


build_x264