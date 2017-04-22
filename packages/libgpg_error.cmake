ExternalProject_Add(libgpg_error
    DEPENDS gcc
    URL "ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.27.tar.bz2"
    URL_HASH SHA256=4f93aac6fecb7da2b92871bb9ee33032be6a87b174f54abf8ddf0911a22d29d2
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --disable-nls
        --disable-languages
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${MINGW_INSTALL_PREFIX}/bin/gpg-error-config ${CMAKE_INSTALL_PREFIX}/bin/gpg-error-config
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
