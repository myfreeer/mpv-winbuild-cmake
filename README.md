# CMake-based MinGW-w64 Cross Toolchain

This thing’s primary use is to build Windows binaries of mpv.

Alternatively, you can download the builds from [here](https://sourceforge.net/projects/mpv-player-windows/files/).

## Prerequisites

In addition to CMake, you need the usual development stuff (Git, Subversion,
GCC, Binutils, ragel, headers for GMP, MPFR and MPC).

 -  You should also install Ninja and use CMake’s Ninja build file generator.
    It’s not only much faster than GNU Make, but also far less error-prone,
    which is important for this project because CMake’s ExternalProject module
    tends to generate makefiles which confuse GNU Make’s jobserver thingy.

 -  As a build environment, any modern Linux distribution *should* work,
    however I am only testing this on openSUSE, which (as of November 2014)
    is using a 4.8 series GCC by default. Feel free to contribute fixes for
    other environments.

-   You cannot use this cmake script on **MSYS2** due to various problems.


## Information about packages

- Git
    - ANGLE
    - FFmpeg
    - xz
    - x264
    - uchardet
    - rubberband
    - opus
    - openal-soft
    - mpv
    - luajit
    - libvpx
    - libpng
    - libsoxr
    - libzimg
    - libdvdread
    - libdvdnav
    - libdvdcss
    - libbluray
    - libass
    - lcms2
    - lame
    - harfbuzz
    - game-music-emu
    - freetype2

- Zip
    - expat (2.2.0)
    - bzip (1.0.6)
    - zlib (1.2.8)
    - xvidcore (1.3.4)
    - vorbis (1.3.5)
    - speex (1.2rc2)
    - ogg (1.3.2)
    - lzo (2.09)
    - libmodplug (0.8.8.5)
    - libjpeg (1.5.0)
    - libiconv (1.14)
    - libarchive (3.2.1)
    - gmp (6.1.1)
    - fribidi (0.19.7)
    

### Prerequisites for Manjaro / Arch Linux

These packages need to be installed first before compiling mpv:

    pacman -S git ninja cmake ragel yasm asciidoc enca gperf p7zip gcc-multilib

For building pdf, these packages are needed:

    pacman -S python2-pip python-docutils python2-rst2pdf python2-lxml python2-pillow

### Prerequisites for Ubuntu Linux / WSL(Windows10) -Untested-

    apt-get install git ninja-build cmake g++ yasm automake autoconf libtool gcc-multilib g++-multilib subversion libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev texinfo gperf ragel asciidoc autopoint python-docutils rst2pdf re2c

### Parallel Build

ProcessorCount didn't return correct no of physical core so we set the MAKEJOBS value manually for safety.

By default, this script set up MAKEJOBS value to 2 by default. This follow the rule,
1 core + 1. If your pc has more cores, you can increase the MAKEJOBS value in CMakeLists.
For example, if you have quad core cpu, the MAKEJOBS value should be 5.



### Building Software

To set up the build environment, create a directory to store build files in::

    mkdir build-64
    cd build-64

Once you’ve changed into that directory, run CMake, e.g.

    cmake -DTARGET_ARCH=x86_64-w64-mingw32 -DCMAKE_INSTALL_PREFIX=prefix -G Ninja ..

or for 32bit:

    cmake -DTARGET_ARCH=i686-w64-mingw32 -DCMAKE_INSTALL_PREFIX=prefix -G Ninja ..

First, you need to build toolchain. By default, it will be installed in 'prefix' folder. This take ~20 minutes in my 4-core machine.

    ninja gcc winpthreads

After it done, you're ready to build mpv and all its dependencies:

    ninja mpv

This will take a while (about 10 minutes on my machine).



### Unpackaged Stuff

Using the toolchain to build stuff which doesn’t have a package is usually
very easy. There are two generated files in your build directory to help with
this: “exec” and “toolchain.cmake”.

For most software (i.e. almost everything that uses GNU Autotools), you can
use “exec” with the configure command:

    ~/mingw/build-64/exec ./configure --prefix=~/mingw/prefix-64/mingw --host=x86_64-w64-mingw32

An alternative is to run “source ~/mingw/build-64/exec” to set all the required
environment variables in your current session.

For software that uses CMake, you can use “toolchain.cmake” like this:

    cmake -DCMAKE_TOOLCHAIN_FILE=~/mingw/build-64/toolchain.cmake -DCMAKE_INSTALL_PREFIX=~/mingw/prefix-64/mingw

In general, it is advisable to use static linking when building for Windows.
To do that, use --disable-shared and/or --enable-static with Autotools-based
configure scripts.

CMake doesn’t have a standard way to achieve this, so you’re on your own.

-   It’s usually easy to make CMake projects link statically if they don’t have
    an option for it already. If you need an example, look at the patches for
    ``game-music-emu``.


### Creating Packages

To add a new package, create a new ``.cmake`` file in the ``packages``
directory (just look at how the existing packages work) and add it to the
list in ``packages/CMakeLists.txt`` (they must appear after their
dependencies).

See the CMake documentation on the ExternalProject module for further info.
