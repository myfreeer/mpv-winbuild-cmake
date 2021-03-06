#!/bin/bash
# Automatically build mpv for 32-bit and 64-bit version

mkdir -p ./build32
cd ./build32
cmake -DTARGET_ARCH=i686-w64-mingw32 -G Ninja ..
ninja mpv
cd ..

if [ -d ./build32/mpv-i686* ] ; then
    echo "Successfully compiled 32-bit. Continue"
else
    echo "Failed compiled 32-bit. Stop"
    exit
fi

mkdir -p ./build64
cd ./build64
cmake -DTARGET_ARCH=x86_64-w64-mingw32 -G Ninja ..
ninja mpv
cd ..
