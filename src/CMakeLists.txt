# ── Collect sources ───────────────────────────────────────
file(GLOB_RECURSE PRIVATE_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
list(LENGTH PRIVATE_SOURCES NUM_SOURCES)

# ── Include directories (shared between both branches) ───
set(WORLDGEN_INCLUDE_DIRS
  $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

# ── The library target ────────────────────────────────────
if(NUM_SOURCES EQUAL 0)
  # No .cpp files yet — create an interface (header-only) target
  # so CMake doesn't error. Switch to a real library once you
  # add source files to src/.
  add_library(worldgen INTERFACE)
  target_include_directories(worldgen INTERFACE ${WORLDGEN_INCLUDE_DIRS})
  target_compile_definitions(worldgen INTERFACE WORLDGEN_BUILD)
else()
  add_library(worldgen ${PRIVATE_SOURCES})

  target_include_directories(worldgen
    PUBLIC  ${WORLDGEN_INCLUDE_DIRS}
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
  )

  target_compile_definitions(worldgen
    PUBLIC $<BUILD_INTERFACE:WORLDGEN_BUILD>
  )

  # ── Dependencies (uncomment when needed) ────────────────
  # target_link_libraries(worldgen
  #   PUBLIC  fmt::fmt
  #   PRIVATE zlib::zlib
  # )

  # ── Compiler warnings ───────────────────────────────────
  apply_compiler_warnings(worldgen)
endif()

# ── Install: public headers (always, even in header-only mode) ─
include(GNUInstallDirs)

install(
  TARGETS worldgen
  EXPORT  worldgenTargets
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
  DIRECTORY ${CMAKE_SOURCE_DIR}/include/worldgen
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# ── Install: binary (only if there's actual compiled code) ─
if(NUM_SOURCES GREATER 0)
  install(
    TARGETS worldgen
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
endif()

# ── CMake package (for find_package support) ──────────────
install(
  EXPORT worldgenTargets
  FILE   worldgenTargets.cmake
  NAMESPACE worldgen::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/worldgen
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
  ${CMAKE_SOURCE_DIR}/cmake/worldgenConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/worldgenConfig.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/worldgen
)

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/worldgenConfigVersion.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/worldgenConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/worldgenConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/worldgen
)
