cmake_minimum_required(VERSION 3.5)

set (PKGDATADIR "${DATADIR}/${CMAKE_PROJECT_NAME}")
set (GETTEXT_PACKAGE ${CMAKE_PROJECT_NAME})
set (EXEC_NAME ${CMAKE_PROJECT_NAME})
set (APP_NAME "Dictionary")
set (RELEASE_NAME "Know your words")
#set (DESKTOP_ICON "system-software-install")
set (VERSION "0.0.1")
set (VERSION_INFO "Nightly")

configure_file (${CMAKE_SOURCE_DIR}/config.vala.cmake ${CMAKE_BINARY_DIR}/src/config.vala)

find_package (PkgConfig)
pkg_check_modules (DEPS REQUIRED gio-2.0 gthread-2.0 gee-0.8 gtk+-3.0>=3.10 granite libsoup-2.4 json-glib-1.0)

add_definitions (${DEPS_CFLAGS})
link_directories (${DEPS_LIBRARY_DIRS})

find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.26" MINIMUM)

include (ValaPrecompile)

add_subdirectory (src)
