# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to this dedicated benchmarks repository.

## Migration Date

November 29, 2025

## Reason for Migration

The benchmarks were moved to a separate repository for the following reasons:

1. **Dependency Isolation**: The main repository no longer needs timely and differential-dataflow as dependencies, resulting in a cleaner dependency graph
2. **Separation of Concerns**: Performance testing infrastructure is isolated from the core implementation
3. **Maintenance Efficiency**: Benchmark updates can be managed independently from the main codebase
4. **Build Performance**: Reduced compilation time for the main repository
5. **Focused Development**: Teams can work on benchmarks without affecting core functionality

## Migrated Components

### Benchmark Files

The following benchmark files were migrated from `bigweaver-agent-canary-hydro-zeta/benches/benches/`:

1. **arithmetic.rs** - Arithmetic operations and pipeline benchmarks
2. **fan_in.rs** - Multiple input merging benchmarks
3. **fan_out.rs** - Stream splitting benchmarks
4. **fork_join.rs** - Fork-join parallel computation patterns
5. **futures.rs** - Async futures-based implementations
6. **identity.rs** - Identity transformation benchmarks
7. **join.rs** - Join operation benchmarks
8. **micro_ops.rs** - Microbenchmarks of individual operators
9. **reachability.rs** - Graph reachability algorithm benchmarks
10. **symmetric_hash_join.rs** - Symmetric hash join benchmarks
11. **upcase.rs** - String transformation benchmarks
12. **words_diamond.rs** - Diamond-shaped dataflow pattern benchmarks

### Data Files

Large test data files were also migrated:

- **words_alpha.txt** - English word list (~3.7 MB)
- **reachability_edges.txt** - Graph edge data (~521 KB)
- **reachability_reachable.txt** - Expected reachable nodes (~38 KB)

### Configuration Files

The following configuration files were migrated:

- **benches/Cargo.toml** - Benchmark package configuration
- **benches/README.md** - Benchmark usage instructions
- **benches/build.rs** - Build script for generated benchmarks
- **benches/benches/.gitignore** - Git ignore patterns

### Additional Files

New files created for this repository:

- **Cargo.toml** - Workspace configuration
- **README.md** - Repository documentation
- **BENCHMARK_GUIDE.md** - Comprehensive benchmark documentation
- **MIGRATION_SUMMARY.md** - This file
- **rust-toolchain.toml** - Rust version specification
- **rustfmt.toml** - Code formatting configuration
- **clippy.toml** - Linting configuration
- **.gitignore** - Repository ignore patterns

## Dependency Changes

### Main Repository (bigweaver-agent-canary-hydro-zeta)

**Removed**:
- `timely-master` (timely dataflow)
- `differential-dataflow-master` (differential dataflow)
- `benches` workspace member

**Impact**: Cleaner dependency graph, faster compilation

### This Repository (bigweaver-agent-canary-zeta-hydro-deps)

**Added**:
- `timely-master` version 0.13.0-dev.1
- `differential-dataflow-master` version 0.13.0-dev.1
- `criterion` version 0.5.0 with async and HTML report features
- `dfir_rs` (referenced from main repository via git)
- `sinktools` (referenced from main repository via git)
- Supporting dependencies: `futures`, `nameof`, `rand`, `rand_distr`, `seq-macro`, `static_assertions`, `tokio`

## Breaking Changes

### For Main Repository Users

No breaking changes - the benchmarks were in a separate workspace member and not part of the published API.

### For Benchmark Users

**Before**:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

**After**:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

## Repository Structure

### This Repository

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                 # Workspace configuration
├── README.md                  # Repository overview
├── BENCHMARK_GUIDE.md         # Detailed benchmark documentation
├── MIGRATION_SUMMARY.md       # This file
├── rust-toolchain.toml        # Rust version
├── rustfmt.toml              # Formatting rules
├── clippy.toml               # Linting rules
├── .gitignore                # Ignore patterns
└── benches/
    ├── Cargo.toml            # Benchmark package manifest
    ├── README.md             # Quick usage guide
    ├── build.rs              # Build script
    └── benches/
        ├── .gitignore        # Ignore generated files
        ├── *.rs              # Benchmark source files (12 files)
        ├── words_alpha.txt   # Word list data
        ├── reachability_edges.txt       # Graph edge data
        └── reachability_reachable.txt   # Graph expected results
```

## Compatibility

### Benchmark Results

Benchmark results are **fully comparable** between the old and new locations. The benchmark implementations remain unchanged, ensuring:

- Historical comparison is valid
- Performance baselines are maintained
- Regression detection continues to work

### Dependency References

The benchmarks reference `dfir_rs` and `sinktools` from the main repository using git references:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git" }
```

This ensures benchmarks always test against the current main repository code.

## Usage

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Performance Comparisons

Each benchmark includes implementations for:
- Hydro (dfir_rs)
- Timely Dataflow
- Differential Dataflow (where applicable)

Results are generated in HTML format in `target/criterion/`.

## CI/CD Integration

To integrate these benchmarks in CI:

```bash
# Fast check that benchmarks compile
cargo check -p benches --benches

# Run benchmarks with reduced sample size
cargo bench -p benches -- --sample-size 10 --quick
```

## Future Enhancements

Planned improvements for this repository:

1. **Automated Performance Tracking**: CI integration for performance regression detection
2. **Historical Results**: Archive of benchmark results over time
3. **Comparison Reports**: Automated generation of performance comparison reports
4. **Additional Benchmarks**: More comprehensive coverage of Hydro operations
5. **Profiling Integration**: Integration with profiling tools for deeper analysis

## Coordination with Main Repository

### When to Update

Update this repository when:
- New dataflow patterns need benchmarking
- Timely/Differential versions update
- Performance testing methodology changes
- New comparative analyses are needed

### Versioning Strategy

This repository follows the main repository's versioning for compatibility:
- Benchmark implementations track main repository features
- Dependencies are updated to match production versions
- Git references ensure latest code is tested

## References

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)

## Questions and Support

For questions about:
- **Benchmark Implementation**: See BENCHMARK_GUIDE.md
- **Migration Issues**: File an issue in this repository
- **Performance Results**: Consult the Criterion HTML reports
- **Main Repository**: See bigweaver-agent-canary-hydro-zeta documentation

## Change Log

### 2025-11-29 - Initial Migration
- Migrated all benchmark files from main repository
- Created comprehensive documentation
- Set up workspace configuration
- Added toolchain and formatting configuration
