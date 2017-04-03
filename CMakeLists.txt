cmake_minimum_required(VERSION 3.5)

set (EXEC_NAME ${CMAKE_PROJECT_NAME})

find_package (PkgConfig)
pkg_check_modules (DEPS REQUIRED gthread-2.0 gtk+-3.0>=3.10 libsoup-2.4 json-glib-1.0)

add_definitions (${DEPS_CFLAGS})
link_directories (${DEPS_LIBRARY_DIRS})

find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.26" MINIMUM)

include (ValaPrecompile)

add_subdirectory (src)
