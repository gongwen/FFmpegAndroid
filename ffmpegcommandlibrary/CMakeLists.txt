# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

set(LIB_SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/main/jniLibs/${ANDROID_ABI})
include_directories(${CMAKE_SOURCE_DIR}/ffmpeg)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.
add_library( # Sets the name of the library.
        ffmpeg

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        ${CMAKE_SOURCE_DIR}/src/main/cpp/cmdutils.c
        ${CMAKE_SOURCE_DIR}/src/main/cpp/ffmpeg.c
        ${CMAKE_SOURCE_DIR}/src/main/cpp/ffmpeg_filter.c
        ${CMAKE_SOURCE_DIR}/src/main/cpp/ffmpeg_opt.c
        ${CMAKE_SOURCE_DIR}/src/main/cpp/native_lib.c)

add_library(libavcodec
        SHARED
        IMPORTED)

set_target_properties(libavcodec
        PROPERTIES IMPORTED_LOCATION
        ${LIB_SOURCE_DIR}/libavcodec.so)

add_library(libavdevice
        SHARED
        IMPORTED)
set_target_properties(libavdevice
        PROPERTIES IMPORTED_LOCATION
        ${LIB_SOURCE_DIR}/libavdevice.so)

add_library(libavfilter
        SHARED
        IMPORTED)
set_target_properties(libavfilter
        PROPERTIES IMPORTED_LOCATION
        ${LIB_SOURCE_DIR}/libavfilter.so)

add_library(libavformat
        SHARED
        IMPORTED)
set_target_properties(libavformat
        PROPERTIES IMPORTED_LOCATION
        ${LIB_SOURCE_DIR}/libavformat.so)

add_library(libavutil
        SHARED
        IMPORTED)
set_target_properties(libavutil
        PROPERTIES IMPORTED_LOCATION
        ${LIB_SOURCE_DIR}/libavutil.so)

add_library(libswresample
        SHARED
        IMPORTED)
set_target_properties(libswresample
        PROPERTIES IMPORTED_LOCATION
        ${LIB_SOURCE_DIR}/libswresample.so)

add_library(libswscale
        SHARED
        IMPORTED)
set_target_properties(libswscale
        PROPERTIES IMPORTED_LOCATION
        ${LIB_SOURCE_DIR}/libswscale.so)


# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

target_link_libraries( # Specifies the target library.
        ffmpeg
        libavcodec
        libavdevice
        libavfilter
        libavformat
        libavutil
        libswresample
        libswscale
        )