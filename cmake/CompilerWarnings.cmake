# ──────────────────────────────────────────────────────────
# CompilerWarnings.cmake
# Usage: apply_compiler_warnings(my_target)
# ──────────────────────────────────────────────────────────

function(apply_compiler_warnings target)
  if(MSVC)
    # MSVC: /W4 = high warning level, /permissive- = standards conformance
    target_compile_options(${target} PRIVATE
      /W4
      /permissive-
      /w14242  # 'identifier': conversion from 'type1' to 'type2', possible loss of data
      /w14263  # 'function': member function does not override any base class virtual member function
      /w14265  # 'class': class has virtual functions, but destructor is not virtual
      /w14287  # 'operator': unsigned/negative constant mismatch
      /w14296  # 'operator': expression is always 'boolean_value'
      /w14545  # expression before comma evaluates to a function which is missing an argument list
      /w14546  # function call before comma missing argument list
      /w14547  # 'operator': operator before comma has no effect; expected operator with side-effect
      /w14549  # 'operator': operator before comma has no effect; did you intend 'operator'?
      /w14555  # expression has no effect; expected expression with side-effect
    )
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    # GCC/Clang: enable most warnings, treat as errors
    target_compile_options(${target} PRIVATE
      -Wall
      -Wextra
      -Wpedantic
      -Werror
      -Wconversion
      -Wsign-conversion
      -Wshadow
      -Wnon-virtual-dtor
      -Wold-style-cast
      -Wcast-align
      -Wunused
      -Woverloaded-virtual
      -Wnull-dereference
      -Wduplicated-cond
      -Wduplicated-branches
      -Wlogical-op
      -Wuseless-cast
      -Wdouble-promotion
      -Wformat=2
    )
  endif()
endfunction()
