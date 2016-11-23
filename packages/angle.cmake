ExternalProject_Add(angle
    DEPENDS gcc
    GIT_REPOSITORY https://chromium.googlesource.com/angle/angle
    UPDATE_COMMAND ""
    PATCH_COMMAND ${EXEC} git am ${CMAKE_CURRENT_SOURCE_DIR}/angle-*.patch
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E remove_directory <SOURCE_DIR>/generated
        COMMAND gyp -Duse_ozone=0 -DOS=win -Dangle_gl_library_type=static_library
        -Dangle_use_commit_id=1 --depth . -I gyp/common.gypi src/angle.gyp --no-parallel
        --format=make --generator-output=generated
    BUILD_COMMAND ${MAKE} -C <SOURCE_DIR>/generated commit_id
        COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/generated/out/Debug/obj/gen/angle/id/commit.h <SOURCE_DIR>/src/id/commit.h
        COMMAND ${MAKE} -C <SOURCE_DIR>/generated
        CXX=${TARGET_ARCH}-g++
        AR=${TARGET_ARCH}-ar
        RANLIB=${TARGET_ARCH}-ranlib
        BUILDTYPE=Release
        COMMAND ${EXEC} <SOURCE_DIR>/move-libs.sh ${TARGET_ARCH}
    INSTALL_COMMAND ${MAKE}
        PREFIX=${MINGW_INSTALL_PREFIX}
        install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(angle)
