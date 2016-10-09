ExternalProject_Add(opus
    DEPENDS gcc
    URL "http://downloads.xiph.org/releases/opus/opus-1.1.3.tar.gz"
    URL_HASH SHA256=58b6fe802e7e30182e95d0cde890c0ace40b6f125cffc50635f0ad2eef69b633
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
