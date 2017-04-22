if(${TARGET_CPU} MATCHES "x86_64")
    set(libgcrypt_symbol_fix "ac_cv_sys_symbol_underscore=no")
endif()

ExternalProject_Add(libgcrypt
    DEPENDS libgpg_error
    URL "ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.7.6.tar.bz2"
    URL_HASH SHA256=626aafee84af9d2ce253d2c143dc1c0902dda045780cc241f39970fc60be05bc
    PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/libgcrypt-1-fixes.patch
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --with-gpg-error-prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        ${libgcrypt_symbol_fix}
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${MINGW_INSTALL_PREFIX}/bin/libgcrypt-config ${CMAKE_INSTALL_PREFIX}/bin/libgcrypt-config
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
