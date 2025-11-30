# Benchmark Migration Summary

## Overview

Benchmarks that depend on `timely` and `differential-dataflow` packages have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to this separate `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

**Date**: November 30, 2025

## Rationale

The migration was performed to:

1. **Reduce Dependency Bloat**: Remove timely and differential-dataflow dependencies from the main repository to speed up compilation
2. **Improve Build Times**: Developers working on the main codebase don't need to build these extra dependencies
3. **Maintain Performance Comparisons**: Keep the ability to run comparative benchmarks between Hydro and timely/differential implementations
4. **Clean Architecture**: Separate test/benchmark code from production code
5. **Easier Maintenance**: Benchmark infrastructure can be updated independently of the core codebase

## What Was Moved

### Benchmarks Directory (`benches/`)

The entire `benches/` directory containing:

**Benchmark Files:**
- `arithmetic.rs` - Basic arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern performance benchmark
- `fan_out.rs` - Fan-out pattern performance benchmark
- `fork_join.rs` - Fork-join pattern performance benchmark
- `futures.rs` - Async futures-based operations benchmark
- `identity.rs` - Identity transformation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase transformation benchmark
- `words_diamond.rs` - Diamond-shaped dataflow pattern benchmark

**Data Files:**
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachability results
- `words_alpha.txt` - English word list for string processing benchmarks

**Configuration Files:**
- `Cargo.toml` - Benchmark package configuration
- `README.md` - Benchmark documentation
- `build.rs` - Build script for generating test code
- `.gitignore` - Git ignore rules

## Dependencies Added

The following dependencies are now in this repository's `benches/Cargo.toml`:

- `timely` (timely-master 0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1) - Differential dataflow framework
- `criterion` (0.5.0) - Benchmarking framework
- `dfir_rs` (git dependency) - Hydro's dataflow intermediate representation
- `sinktools` (git dependency) - Utility tools
- Supporting libraries: `futures`, `nameof`, `rand`, `rand_distr`, `seq-macro`, `static_assertions`, `tokio`

## Dependencies Removed from Main Repository

The main `bigweaver-agent-canary-hydro-zeta` repository no longer includes:

- `timely-master` (0.13.0-dev.1)
- `differential-dataflow-master` (0.13.0-dev.1)
- Transitive dependencies from timely/differential-dataflow
- The `benches` workspace member

## Changes to Main Repository

In `bigweaver-agent-canary-hydro-zeta`:

1. **Cargo.toml**: Removed `benches` from workspace members
2. **Cargo.lock**: Cleaned up timely and differential-dataflow entries
3. **README.md**: Updated to reference this repository for benchmarks

## Repository Structure

### This Repository (bigweaver-agent-canary-zeta-hydro-deps)

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                 # Workspace configuration
├── README.md                  # Repository documentation
├── MIGRATION_SUMMARY.md       # This file
└── benches/                   # Benchmark package
    ├── Cargo.toml            # Benchmark dependencies and configuration
    ├── README.md             # Benchmark usage instructions
    ├── build.rs              # Build script for code generation
    └── benches/              # Benchmark implementations
        ├── .gitignore
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_alpha.txt
        └── words_diamond.rs
```

## Running Benchmarks

### From This Repository

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

The benchmarks will automatically fetch necessary dependencies from the main Hydro repository via git.

## Performance Comparison Workflow

The benchmarks maintain the ability to compare performance between:

1. **Hydro implementations** - Using dfir_rs and Hydro abstractions
2. **Timely implementations** - Direct timely dataflow usage
3. **Differential implementations** - Differential dataflow usage

This allows validation that Hydro's abstractions don't introduce significant performance overhead.

## Integration with CI/CD

To integrate these benchmarks into CI/CD:

1. Add this repository as a separate job in CI pipelines
2. Run benchmarks on performance-critical changes
3. Compare results against baseline measurements
4. Optional: Only run benchmarks when explicitly triggered to save CI time

## Benefits of Separation

### For Main Repository Developers

- **Faster builds**: No need to compile timely/differential-dataflow
- **Smaller dependency tree**: Fewer transitive dependencies
- **Cleaner workspace**: Focus on core functionality
- **Reduced Cargo.lock churn**: Fewer dependency updates

### For Performance Engineers

- **Dedicated environment**: Benchmark-specific configuration
- **Independent updates**: Update timely/differential versions without affecting main repo
- **Easier experimentation**: Try different benchmark configurations
- **Clear ownership**: Separate repository for performance testing infrastructure

## Maintenance Notes

### Updating Benchmarks

When updating benchmarks:
1. Make changes in this repository
2. Ensure git dependencies point to correct branch/tag in main repository
3. Update documentation if benchmark behavior changes

### Syncing with Main Repository

The benchmarks depend on:
- `dfir_rs` from the main repository
- `sinktools` from the main repository

These are fetched via git during build. To use a specific version:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "specific-commit-hash", features = [ "debugging" ] }
```

### Updating Timely/Differential Versions

To update timely or differential-dataflow versions:
1. Update version in `benches/Cargo.toml`
2. Run `cargo update` to update Cargo.lock
3. Test all benchmarks to ensure compatibility
4. Document any API changes needed

## Related Documentation

- Main repository: [bigweaver-agent-canary-hydro-zeta README](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Benchmark guide: `benches/README.md` in this repository
- Hydro documentation: Available in the main repository's docs

## Questions or Issues

For questions about:
- **Benchmark results**: Open issue in this repository
- **Benchmark implementation**: Open issue in this repository
- **Core Hydro functionality**: Open issue in the main repository
- **Integration**: Discuss in the main repository

## Version History

- **v1.0** (2025-11-30): Initial migration from main repository
  - Moved all timely/differential benchmarks
  - Configured git dependencies for dfir_rs and sinktools
  - Created comprehensive documentation
