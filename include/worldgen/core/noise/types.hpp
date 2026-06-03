#pragma once

#include <cstdint>

namespace worldgen::noise {

// The return type of every raw noise evaluation
// `value` noise output in [-1, 1]
// `derivatives` analytical gradient ∂n/∂x, ∂n/∂y, ∂n/∂z
struct NoiseResult3D {
    float value;
    float dx, dy, dz;
};

// A point in the unit sphere expressed in two ways
// - as spherical coordinates with angles
// - as 3D cartesian coordinates point ready to feed into the noise function
struct SpherePoint {
    float phi;     // longitude  [-π,  π]
    float theta;   // colatitude  [0,  π]
    float x, y, z; // derived cartesian coordinates, pre-computed
};

// Configuration for one FBM stack.
struct FBMConfig {
    uint8_t  octaves       = 6;
    float    frequency     = 1.0f;  // base frequency
    float    lacunarity    = 2.0f;  // freq multiplier per octave
    float    gain          = 0.5f;  // amplitude multiplier per octave
    float    warp_strength = 1.0f;  // how strong derivatives warp each other (0 = Plain FBM)
    uint64_t seed          = 0;
};

// Output of a complete FBM evaluation, including the final accumulated derivative
// (useful for normal-map generation and slope-based biome logic).
struct FBMResult {
    float value;      // final height [-1, 1] (approx)
    float dx, dy, dz; // accumulated analytical gradient
};

}
