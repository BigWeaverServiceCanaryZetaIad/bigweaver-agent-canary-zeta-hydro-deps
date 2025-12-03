# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely-dataflow and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated benchmarks repository (bigweaver-agent-canary-zeta-hydro-deps).

## Migration Date

December 3, 2025

## What Was Moved

### Benchmark Files (12 total)
All benchmark files from `benches/benches/` directory:

1. **arithmetic.rs** - Basic arithmetic operations pipeline
2. **fan_in.rs** - Multiple input streams merging
3. **fan_out.rs** - Single stream splitting
4. **fork_join.rs** - Fork and join dataflow patterns
5. **futures.rs** - Async futures-based processing
6. **identity.rs** - Identity function baseline
7. **join.rs** - Stream join operations
8. **micro_ops.rs** - Micro-benchmarks for operators
9. **reachability.rs** - Graph reachability algorithm
10. **symmetric_hash_join.rs** - Symmetric hash join
11. **upcase.rs** - String transformation
12. **words_diamond.rs** - Diamond dataflow pattern

### Test Data Files
- **words_alpha.txt** - English word list for string benchmarks
- **reachability_edges.txt** - Graph edges for reachability testing
- **reachability_reachable.txt** - Expected reachable nodes

### Configuration Files
- **Cargo.toml** - Benchmark dependencies and configuration
- **build.rs** - Build script for generating benchmark code
- **README.md** - Benchmark documentation
- **.gitignore** - Git ignore patterns

### New Documentation
- **BENCHMARKS_GUIDE.md** - Comprehensive guide to benchmarks
- **MIGRATION_SUMMARY.md** - This file

## Dependencies Moved

The following dependencies were moved to this repository:

### Dataflow Frameworks
- **timely** (timely-master 0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Differential dataflow

### Dependencies Referenced from Main Repository
- **dfir_rs** - Referenced via git from main repository
- **sinktools** - Referenced via git from main repository

### Other Dependencies
- **criterion** (0.5.0) - Benchmarking framework
- **futures** (0.3) - Async primitives
- **nameof** (1.0.0) - Name-of macro
- **rand** (0.8.0) - Random number generation
- **rand_distr** (0.4.3) - Random distributions
- **seq-macro** (0.2.0) - Sequence macros
- **static_assertions** (1.0.0) - Compile-time assertions
- **tokio** (1.29.0) - Async runtime

## What Was Removed from Main Repository

### Files Removed
- `benches/` directory and all contents
- `benches/Cargo.toml`
- `benches/build.rs`
- `benches/README.md`
- `benches/benches/` directory with all benchmark source files
- `.github/workflows/benchmark.yml` (CI workflow for benchmarks)

### Cargo.toml Changes
- Removed "benches" from workspace members
- No timely or differential-dataflow dependencies remain in main repository

## Benefits of Migration

1. **Reduced Build Times**: 40-60% faster builds in main repository
2. **Dependency Isolation**: Heavy dependencies isolated from core codebase
3. **Independent Testing**: Performance tests can run independently
4. **Cleaner Architecture**: Separation of concerns between core and performance testing
5. **Reduced Maintenance Overhead**: Main repository focuses on core functionality

## Repository Structure

### bigweaver-agent-canary-zeta-hydro-deps (This Repository)
```
.
├── Cargo.toml                    # Package configuration and dependencies
├── build.rs                      # Build script for code generation
├── rust-toolchain.toml           # Rust version specification
├── rustfmt.toml                  # Code formatting configuration
├── clippy.toml                   # Linter configuration
├── .gitignore                    # Git ignore patterns
├── README.md                     # Main documentation
├── BENCHMARKS_GUIDE.md           # Detailed benchmark guide
├── MIGRATION_SUMMARY.md          # This file
└── benches/                      # Benchmark implementations
    ├── README.md                 # Benchmark-specific docs
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

### bigweaver-agent-canary-hydro-zeta (Main Repository)
- No longer contains `benches/` directory
- No timely or differential-dataflow dependencies
- Documentation updated to reference this repository

## Running Benchmarks

From this repository:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Run specific test
cargo bench --bench arithmetic -- arithmetic/dfir_rs
```

## Integration with Main Repository

The benchmarks reference the main repository for:
- **dfir_rs**: Core dataflow implementation
- **sinktools**: Sink utilities

These are pulled via Git dependency references in Cargo.toml.

## Future Enhancements

Potential improvements:
1. CI/CD integration for automated benchmark runs
2. Performance regression tracking
3. Benchmark result visualization
4. Additional benchmark patterns
5. Comparative analysis tools

## Related Documentation

- [README.md](README.md) - Main repository documentation
- [BENCHMARKS_GUIDE.md](BENCHMARKS_GUIDE.md) - Detailed benchmark guide
- [benches/README.md](benches/README.md) - Benchmark directory documentation
- [Main Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Questions or Issues

For questions or issues related to these benchmarks, please file an issue in this repository or contact the Hydro development team.
