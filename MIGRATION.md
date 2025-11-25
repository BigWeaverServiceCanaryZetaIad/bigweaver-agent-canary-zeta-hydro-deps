# Migration Guide: Timely and Differential-Dataflow Benchmarks

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## What Was Moved

### Benchmark Files

The following benchmark files that depend on Timely Dataflow and Differential Dataflow were moved:

- `arithmetic.rs` - Arithmetic operations pipeline comparison
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity transformation benchmark
- `join.rs` - Join operations benchmark
- `reachability.rs` - Graph reachability benchmark
- `upcase.rs` - String uppercasing benchmark

### Supporting Files

The following supporting files were also moved:

- `build.rs` - Build script for generating benchmark code
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark
- `words_alpha.txt` - Word list for text processing benchmarks
- `.gitignore` - Git ignore rules for generated files

## Rationale

The benchmarks were moved to achieve:

1. **Clean Dependency Management**: Remove timely and differential-dataflow dependencies from the main repository
2. **Modular Architecture**: Separate performance comparison code from core functionality
3. **Build Optimization**: Reduce build times for the main repository by isolating heavy dependencies
4. **Clear Separation of Concerns**: Keep core Hydro development separate from comparative benchmarking

## Repository Structure

### bigweaver-agent-canary-zeta-hydro-deps

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── rust-toolchain.toml     # Rust toolchain specification
├── rustfmt.toml           # Code formatting rules
├── clippy.toml            # Linting rules
├── README.md              # Repository documentation
├── MIGRATION.md           # This file
└── benches/               # Benchmark crate
    ├── Cargo.toml         # Benchmark dependencies
    ├── build.rs           # Build script
    ├── README.md          # Benchmark documentation
    └── benches/           # Benchmark source files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── *.txt          # Test data files
        └── .gitignore
```

## Dependencies Added

The following dependencies are now managed in this repository:

### Core Dependencies

- **timely-master** (v0.13.0-dev.1): Timely dataflow library
- **differential-dataflow-master** (v0.13.0-dev.1): Differential dataflow library

### Supporting Dependencies

- **criterion** (v0.5.0): Benchmarking framework with async_tokio and html_reports features
- **futures** (v0.3): Asynchronous programming primitives
- **rand** (v0.8.0): Random number generation
- **rand_distr** (v0.4.3): Random number distributions
- **tokio** (v1.29.0): Async runtime with rt-multi-thread feature

### External References

These are referenced from the main hydro repository:
- **dfir_rs**: Hydro's dataflow implementation (via git)
- **sinktools**: Utility library (via git)

## Running Benchmarks

### From the New Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

### CI/CD Integration

Update your CI/CD pipelines to:

1. Clone both repositories if benchmark comparisons are needed
2. Run benchmarks from `bigweaver-agent-canary-zeta-hydro-deps`
3. Compare results with core Hydro benchmarks from the main repository

Example:
```bash
# Run Hydro-only benchmarks in main repo
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# Run comparison benchmarks with timely/differential
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

## What Remains in the Main Repository

The main `bigweaver-agent-canary-hydro-zeta` repository still contains:

- Benchmarks that only use Hydro/dfir_rs without external dataflow dependencies
- Examples: `micro_ops.rs`, `symmetric_hash_join.rs`, `words_diamond.rs`, `futures.rs`
- Core functionality and libraries
- Main documentation and examples

## Breaking Changes

### For Developers

If you were running all benchmarks together:

**Before:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

**After:**
```bash
# Run Hydro-only benchmarks
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# Run timely/differential comparison benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### For CI/CD

Update your benchmark scripts to:
1. Check out both repositories
2. Run benchmarks from both locations
3. Aggregate results as needed

## Benefits of the Migration

1. **Faster Build Times**: Main repository builds faster without timely/differential dependencies
2. **Cleaner Dependencies**: Core Hydro development doesn't require external dataflow libraries
3. **Better Organization**: Clear separation between internal and comparative benchmarks
4. **Easier Maintenance**: Changes to timely/differential benchmarks don't affect main repository
5. **Flexible Versioning**: Can update external dependencies independently

## Verification

To verify the migration was successful:

1. **Check that benchmarks compile:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build --release
   ```

2. **Run benchmarks:**
   ```bash
   cargo bench -p benches
   ```

3. **Verify results match previous runs** (compare with historical benchmark data)

## Questions and Support

For questions about:
- **Benchmark results**: Compare with historical data from the main repository
- **Missing benchmarks**: Check if they remain in the main repository (Hydro-only benchmarks)
- **Dependency issues**: Ensure you have access to the main Hydro repository for dfir_rs and sinktools

## Timeline

- **Migration Date**: [Current Date]
- **Affected Benchmarks**: 8 files moved
- **Dependencies Added**: timely-master, differential-dataflow-master
- **Breaking Changes**: Repository location change for these benchmarks

## Related Documentation

- [README.md](README.md) - Main repository documentation
- [benches/README.md](benches/README.md) - Benchmark-specific documentation
- Main Hydro Repository: `bigweaver-agent-canary-hydro-zeta`
