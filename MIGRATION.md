# Benchmark Migration Guide

## Overview

This document describes the migration of all benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated benchmarks repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

December 19, 2024

## Objective

To separate benchmark code from the main Hydro repository, enabling:
1. Independent benchmark development and maintenance
2. Reduced dependencies in the main repository
3. Dedicated space for performance comparison implementations
4. Flexibility to add timely/differential-dataflow comparison benchmarks

## Migrated Benchmarks

All benchmarks from the main repository have been moved to this repository:

### Benchmark Files
- `micro_ops.rs` - Micro-operations benchmark testing basic dataflow operations
- `symmetric_hash_join.rs` - Symmetric hash join implementation benchmark
- `words_diamond.rs` - Word processing using diamond pattern dataflow
- `futures.rs` - Asynchronous futures-based operations benchmark

### Data Files
- `words_alpha.txt` - English word list for word processing benchmarks (3.7MB)

### Configuration Files
- `Cargo.toml` - Benchmark package configuration
- `README.md` - Benchmark usage documentation
- `.gitignore` - Git ignore patterns for benchmark artifacts

## Changes to Main Repository

The following changes were made to `bigweaver-agent-canary-hydro-zeta`:

1. **Removed Directory**: Entire `benches/` directory removed
2. **Updated Documentation**: 
   - `README.md` updated to reference this repository for benchmarks
   - `BENCHMARK_MIGRATION.md` updated to reflect the complete migration
3. **Dependencies**: Already had no timely/differential-dataflow dependencies

## Dependencies

### Current Dependencies (Migrated from Main Repo)
- `criterion` - Benchmarking framework
- `dfir_rs` - Hydro's DFIR implementation (path dependency)
- `sinktools` - Utility tools (path dependency)
- `futures` - Async futures support
- `rand`, `rand_distr` - Random data generation
- `tokio` - Async runtime
- Supporting crates: `nameof`, `seq-macro`, `static_assertions`

### Path Dependencies Note
The benchmarks reference local path dependencies:
- `dfir_rs` at `../dfir_rs`
- `sinktools` at `../sinktools`

These dependencies need to be:
- Available in a parent workspace, OR
- Paths adjusted in `Cargo.toml` to point to the correct locations, OR
- Replaced with crate registry versions if available

### Future Dependencies (Planned)
For performance comparison implementations:
- `timely` - Timely dataflow system
- `differential-dataflow` - Differential dataflow system

## Running Benchmarks

### Prerequisites
Ensure path dependencies are available:
```bash
# Option 1: Set up workspace with dfir_rs and sinktools in parent directory
# Option 2: Adjust paths in benches/Cargo.toml
# Option 3: Clone dependencies to appropriate locations
```

### Running All Benchmarks
```bash
cd benches
cargo bench
```

### Running Specific Benchmarks
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

## Performance Comparison Workflow

### Current State
All benchmarks use Hydro-native DFIR implementations.

### Future Enhancements
This repository can be extended to include:
1. Timely/differential-dataflow implementations of the same benchmarks
2. Side-by-side performance comparisons
3. Historical performance tracking
4. Cross-implementation validation

## Benefits of Migration

1. **Cleaner Main Repository**: Main Hydro repo focuses on core implementation
2. **Reduced Build Times**: Main repo doesn't need to build benchmarks by default
3. **Flexible Benchmarking**: This repo can include any dependencies needed for comparisons
4. **Independent Versioning**: Benchmarks can evolve independently
5. **Dedicated Testing Space**: Room for extensive performance testing without cluttering main repo

## Repository Links

- **Main Repository**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- **Benchmarks Repository (this repo)**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps

## Verification

To verify the migration was successful:

1. Main repository should build without benchmark code:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   # No benches directory should exist
   ls benches  # Should fail
   ```

2. Benchmark repository should have all benchmark files:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   ls benches/  # Should show all .rs files and data files
   ```

3. Dependencies are clean:
   ```bash
   # Main repo should have no timely/differential dependencies
   # Deps repo has all necessary dependencies for benchmarks
   ```

## Notes

- The migration preserves all benchmark functionality
- Historical benchmark results from the main repo can be compared with results from this repo
- Path dependencies need attention during setup
- This repository is the new home for all Hydro performance benchmarks
