ExternalProject_Add(opus
    DEPENDS gcc
    URL "http://downloads.xiph.org/releases/opus/opus-1.1.2.tar.gz"
    URL_HASH SHA256=0e290078e31211baa7b5886bcc8ab6bc048b9fc83882532da4a1a45e58e907fd
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
