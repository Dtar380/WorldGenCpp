#pragma once

#ifdef _WIN32
  #ifdef WORLDGEN_BUILD
    #define WORLDGEN_EXPORT __declspec(dllexport)
  #else
    #define WORLDGEN_EXPORT __declspec(dllimport)
  #endif
#else
  #define WORLDGEN_EXPORT
#endif
