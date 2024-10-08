cmake_minimum_required(VERSION 3.15)

set(PROJECT_NAME "flutter_qjs")
project(${PROJECT_NAME} LANGUAGES CXX)
add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")

set(PLUGIN_NAME "${PROJECT_NAME}_plugin")

add_library(${PLUGIN_NAME} SHARED
  "${PLUGIN_NAME}.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin)

# List of absolute paths to libraries that should be bundled with the plugin
set(flutter_qjs_bundled_libraries
  ""
  PARENT_SCOPE
)

set(BUILD_BUNDLE_DIR "$<TARGET_FILE_DIR:${BINARY_NAME}>")
# Make the "install" step default, as it's required to run.
set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD 1)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${BUILD_BUNDLE_DIR}" CACHE PATH "..." FORCE)
endif()

set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}")
set(QUICKJSC_BRIDGE "libquickjs.dll")
set(QUICKJSC_BRIDGE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/shared/${QUICKJSC_BRIDGE}")
set(EXTRA_PATH "${CMAKE_CURRENT_SOURCE_DIR}/lib/libgcc_s_seh-1.dll" "${CMAKE_CURRENT_SOURCE_DIR}/lib/libstdc++-6.dll")
install(CODE "file(REMOVE_RECURSE \"${INSTALL_BUNDLE_LIB_DIR}/${QUICKJSC_BRIDGE}\")" COMPONENT Runtime)
install(FILES "${QUICKJSC_BRIDGE_PATH}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)
install(FILES "${EXTRA_PATH}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)
