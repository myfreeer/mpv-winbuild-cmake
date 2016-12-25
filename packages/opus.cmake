ExternalProject_Add(opus
    DEPENDS gcc
    URL "http://downloads.xiph.org/releases/opus/opus-1.2-alpha.tar.gz"
    URL_HASH SHA256=654a9bebb73266271a28edcfff431e4cfd9bfcde71f42849a0cdd73bece803a7
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
