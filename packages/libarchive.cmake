ExternalProject_Add(libarchive
    DEPENDS
        bzip2
        expat
        lzo
        xz
        zlib
    URL "http://www.libarchive.org/downloads/libarchive-3.2.2.tar.gz"
    URL_HASH SHA256=691c194ee132d1f0f7a42541f091db811bc2e56f7107e9121be2bc8c04f1060f
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --disable-bsdtar
        --disable-bsdcat
        --disable-bsdcpio
        --without-xml2
        --without-nettle
        --without-openssl
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
