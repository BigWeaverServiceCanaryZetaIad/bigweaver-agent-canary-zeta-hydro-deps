# Benchmarks Migration Guide

## Overview

The Timely and Differential Dataflow benchmarks have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The benchmarks were moved to:

1. **Reduce Dependency Bloat**: The `timely` and `differential-dataflow` dependencies are only needed for performance comparisons, not for core Hydro functionality
2. **Improve Build Times**: Users of the main framework no longer need to compile these heavyweight dependencies
3. **Cleaner Separation**: Performance comparison code is separated from core implementation
4. **Maintain Performance Testing**: All benchmark functionality remains available, just in a dedicated location

## What Was Moved

All files from the `benches/` directory in the main repository have been moved here, including:

### Benchmark Files
- `arithmetic.rs` - Arithmetic operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Future-based async operation benchmarks
- `identity.rs` - Identity/pass-through benchmarks
- `join.rs` - Stream join benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String transformation benchmarks
- `words_diamond.rs` - Diamond pattern benchmarks

### Supporting Files
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark
- `words_alpha.txt` - Word list for string benchmarks
- `.gitignore` - Git ignore patterns
- `build.rs` - Build script for generating code
- `Cargo.toml` - Package configuration with timely/differential dependencies
- `README.md` - Documentation for the benchmarks

## What Was Removed from Main Repository

From the main `bigweaver-agent-canary-hydro-zeta` repository, the following were removed:

1. The entire `benches/` directory and all its contents
2. The "benches" member from the workspace `Cargo.toml`
3. Timely and Differential Dataflow dependencies from `Cargo.lock`

## Running Benchmarks (New Location)

To run the benchmarks, clone this repository and use cargo bench:

```bash
# Clone the deps repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability

# Run with specific features
cargo bench --bench arithmetic -- --verbose
```

## Dependencies

The benchmarks now reference `dfir_rs` and `sinktools` from the main repository via git dependencies:

```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

This ensures the benchmarks always test against the latest version of Hydro/DFIR from the main repository.

## Performance Comparison Capability

All performance comparison capabilities have been preserved in the new location:

- ✅ All original benchmark code is intact
- ✅ Both Hydro/DFIR and Timely/Differential implementations are included
- ✅ Criterion benchmarking framework provides detailed performance reports
- ✅ Historical performance tracking remains possible
- ✅ HTML reports are generated for visualization (when enabled)

## For Contributors

### Working on Core Hydro/DFIR
If you're working on the main Hydro framework, you no longer need to worry about the benchmark dependencies. The main repository is now lighter and faster to build.

### Working on Benchmarks
If you're adding new benchmarks or improving existing ones:

1. Clone this repository
2. Make your changes in the `benches/` directory
3. Test with `cargo bench`
4. Submit a PR to this repository

### Adding New Benchmarks
To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Implement comparisons for Hydro/DFIR, Timely, and/or Differential as appropriate
4. Update `benches/README.md` to document the new benchmark

## Migration Date

These benchmarks were migrated on December 10, 2025, from the main repository to improve repository organization and reduce dependency footprint.

## Questions or Issues

If you have questions about the benchmarks or encounter issues:
- Check the [benches/README.md](benches/README.md) for usage information
- Review benchmark code for implementation details
- Consult the main [Hydro documentation](https://hydro.run/docs) for framework information
