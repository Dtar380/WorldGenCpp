# ── CLI application ──────────────────────────────────────
# Create the CLI executable when main.cpp exists.

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")
  add_executable(worldgen_cli main.cpp)
  target_link_libraries(worldgen_cli PRIVATE worldgen)
  target_compile_features(worldgen_cli PRIVATE cxx_std_20)
  message(STATUS "CLI: enabled")
else()
  message(STATUS "CLI: no main.cpp found (drop one into app/ to enable)")
endif()
