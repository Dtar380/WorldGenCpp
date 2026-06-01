cmake_minimum_required(VERSION 3.16)
project(worldgen
  VERSION 0.1.0
  DESCRIPTION "World generation library"
  LANGUAGES CXX
)

# ── C++ Standard ──────────────────────────────────────────
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ── Options ──────────────────────────────────────────────
option(BUILD_CLI   "Build CLI tool"   OFF)
option(BUILD_TESTS "Build tests"       OFF)

# ── CMake modules ─────────────────────────────────────────
include(cmake/CompilerWarnings.cmake)
include(cmake/Dependencies.cmake)

# ── The library ───────────────────────────────────────────
add_subdirectory(src)

# ── CLI application (enable with -DBUILD_CLI=ON) ──────────
if(BUILD_CLI)
    add_subdirectory(app)
endif()

# ── Tests (enable with -DBUILD_TESTS=ON) ─────────────────
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
