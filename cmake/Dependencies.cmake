# ──────────────────────────────────────────────────────────
# Dependencies.cmake
# Manage third-party dependencies here.
# ──────────────────────────────────────────────────────────

include(FetchContent)

# ── Google Test ──────────────────────────────────────────
# Auto-downloaded when BUILD_TESTS=ON. No manual install needed.
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG        v1.15.2
)
FetchContent_MakeAvailable(googletest)

# ── Example: add more dependencies here ──────────────────
# FetchContent_Declare(
#   fmt
#   GIT_REPOSITORY https://github.com/fmtlib/fmt.git
#   GIT_TAG        10.1.0
# )
# FetchContent_MakeAvailable(fmt)
