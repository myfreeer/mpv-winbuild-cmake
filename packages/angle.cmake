ExternalProject_Add(angle
    DEPENDS gcc
    GIT_REPOSITORY https://chromium.googlesource.com/angle/angle
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/include/EGL ${MINGW_INSTALL_PREFIX}/include/EGL
        COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/include/KHR ${MINGW_INSTALL_PREFIX}/include/KHR
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(angle)
