vala_precompile (

  VALA_C ${EXEC_NAME}
    Core/Definition.vala
    Core/PearsonApiClient.vala

    Views/View.vala
    Views/WordListView.vala
    Views/SearchView.vala
    Views/RecentView.vala
    Views/BookmarkView.vala

    Widgets/WordListRow.vala

    Application.vala
    MainWindow.vala

    ${CMAKE_CURRENT_BINARY_DIR}/config.vala

  PACKAGES
    gee-0.8
    gtk+-3.0>=3.12
    gio-2.0
    granite
    libsoup-2.4
    json-glib-1.0

  OPTIONS
    --thread
    --target-glib=2.32
)

add_executable (${EXEC_NAME} ${VALA_C})
target_link_libraries (${EXEC_NAME} ${DEPS_LIBRARIES})
