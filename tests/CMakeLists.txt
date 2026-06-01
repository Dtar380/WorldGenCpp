# ── Tests ─────────────────────────────────────────────────
# Automatically discovers and builds all .cpp files in tests/.
# Google Test is only required when test files exist.

file(GLOB_RECURSE TEST_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

if(TEST_SOURCES)
  add_executable(worldgen_tests ${TEST_SOURCES})
  target_link_libraries(worldgen_tests PRIVATE worldgen GTest::gtest GTest::gtest_main)
  target_compile_features(worldgen_tests PRIVATE cxx_std_20)

  add_test(NAME worldgen_tests COMMAND worldgen_tests)
  message(STATUS "Tests: enabled (${TEST_SOURCES} files found)")
else()
  message(STATUS "Tests: no test files found (drop .cpp files into tests/ to enable)")
endif()
