vala_precompile (

  VALA_C ${EXEC_NAME}
    gtk-dictionary.vala
    dictionary-api.vala

  PACKAGES
    gtk+-3.0>=3.12
    libsoup-2.4
    json-glib-1.0

  OPTIONS
    --thread
    --target-glib=2.32
)

add_executable (${EXEC_NAME} ${VALA_C})
target_link_libraries (${EXEC_NAME} ${DEPS_LIBRARIES})
