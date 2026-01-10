# Benchmark Migration History

This document tracks the migration of benchmarks from the main Hydro repository to this dependencies repository.

## Background

The timely and differential-dataflow benchmarks were originally located in the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository under the `benches/` directory. These benchmarks compared Hydro/DFIR performance against timely and differential-dataflow implementations.

## Why Migrate?

The main repository no longer needs timely and differential-dataflow as dependencies. Benefits of the migration include:

1. **Reduced dependency bloat**: The main repository's Cargo.lock and build times are lighter without timely/differential-dataflow
2. **Cleaner separation of concerns**: Core Hydro functionality is separate from performance comparison tools
3. **Maintained performance tracking**: The ability to run performance comparisons is retained
4. **Independent versioning**: Benchmark dependencies can be updated without affecting the main repository

## What Was Moved

From the main repository's `benches/` directory:

### Files Moved:
- `benches/Cargo.toml` - Benchmark package configuration with timely/differential-dataflow dependencies
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script for generating benchmark code
- `benches/benches/*.rs` - All benchmark implementations:
  - `arithmetic.rs` - Arithmetic operation benchmarks
  - `fan_in.rs` - Fan-in pattern benchmarks
  - `fan_out.rs` - Fan-out pattern benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `futures.rs` - Async futures benchmarks
  - `identity.rs` - Identity/pass-through benchmarks
  - `join.rs` - Join operation benchmarks
  - `micro_ops.rs` - Micro-operation benchmarks
  - `reachability.rs` - Graph reachability benchmarks
  - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
  - `upcase.rs` - String transformation benchmarks
  - `words_diamond.rs` - Word processing diamond pattern benchmarks
- `benches/benches/*.txt` - Benchmark data files:
  - `words_alpha.txt` - English word list for word-based benchmarks
  - `reachability_edges.txt` - Graph edges for reachability benchmarks
  - `reachability_reachable.txt` - Expected reachability results
- `benches/benches/.gitignore` - Git ignore rules for generated benchmark files

### Dependencies Moved:
The following dependencies are now only in this repository:
- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)

### Cargo.toml Changes:
The benchmark Cargo.toml was updated to reference the main repository's crates as git dependencies:
- `dfir_rs` - Changed from `path = "../dfir_rs"` to git dependency
- `sinktools` - Changed from `path = "../sinktools"` to git dependency

## Integration Points

The benchmarks continue to work with the main repository through:

1. **Git Dependencies**: `dfir_rs` and `sinktools` are referenced as git dependencies pointing to the main repository
2. **Feature Compatibility**: The benchmarks maintain the same feature flags and API usage
3. **Build Process**: The build.rs script generates code compatible with the main repository's API

## Running Comparisons

After the migration, performance comparisons between Hydro and timely/differential-dataflow can still be run:

```bash
# Clone this repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Migration Date

This migration was completed on December 9, 2024.

## References

- Main Repository: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- This Repository: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
