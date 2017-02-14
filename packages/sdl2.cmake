ExternalProject_Add(sdl2
    DEPENDS libiconv
    URL "http://libsdl.org/release/SDL2-2.0.5.tar.gz"
    URL_HASH SHA256=442038cf55965969f2ff06d976031813de643af9c9edc9e331bd761c242e8785
    PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/sdl2-0001-remove-conflicting-xinput-structs.patch
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --enable-threads
        --enable-directx
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
