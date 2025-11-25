# Changelog

All notable changes to the bigweaver-agent-canary-zeta-hydro-deps repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with timely and differential-dataflow benchmarks
- Comprehensive benchmark suite with 12 benchmark files:
  - `arithmetic.rs` - Mathematical operations
  - `fan_in.rs` - Multiple sources merging patterns
  - `fan_out.rs` - Single source splitting patterns
  - `fork_join.rs` - Fork-join parallelism patterns
  - `futures.rs` - Async/await operations
  - `identity.rs` - Pass-through operations
  - `join.rs` - Join operations
  - `micro_ops.rs` - Micro-operations and basic patterns
  - `reachability.rs` - Graph reachability algorithms
  - `symmetric_hash_join.rs` - Symmetric hash join operations
  - `upcase.rs` - String transformation operations
  - `words_diamond.rs` - Diamond pattern word processing
- Benchmark data files:
  - `reachability_edges.txt` - Graph edges for reachability benchmark (524KB)
  - `reachability_reachable.txt` - Expected reachable nodes (40KB)
  - `words_alpha.txt` - English words dictionary (3.7MB)
- Rust tooling configuration:
  - `rust-toolchain.toml` - Rust 1.91.1 with required components
  - `rustfmt.toml` - Code formatting configuration
  - `clippy.toml` - Linting configuration
- Documentation:
  - `README.md` - Repository overview and quick start
  - `CONTRIBUTING.md` - Contributing guidelines and development setup
  - `BENCHMARK_GUIDE.md` - Comprehensive benchmark guide
  - `QUICK_REFERENCE.md` - Quick reference for common operations
  - `benches/README.md` - Benchmark-specific documentation
- Helper scripts:
  - `run_benchmarks.sh` - Convenient benchmark runner with multiple options
  - `verify_setup.sh` - Setup verification script
- Cargo workspace configuration:
  - Optimized release profile (opt-level 3, LTO fat, strip symbols)
  - Profile configuration for profiling with debug symbols
  - Workspace lints for consistent code quality
- Dependencies:
  - `timely-master` 0.13.0-dev.1 - Timely dataflow
  - `differential-dataflow-master` 0.13.0-dev.1 - Differential dataflow
  - `criterion` 0.5.0 - Benchmarking framework with HTML reports
  - Path dependencies to main repository (`dfir_rs`, `sinktools`)
  - Supporting dependencies: `futures`, `tokio`, `rand`, etc.

### Repository Structure
```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                        # Benchmark package
│   ├── benches/                    # Benchmark source files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   ├── words_alpha.txt
│   │   └── words_diamond.rs
│   ├── Cargo.toml                  # Benchmark dependencies
│   ├── README.md                   # Benchmark documentation
│   └── build.rs                    # Build script
├── BENCHMARK_GUIDE.md              # Comprehensive guide
├── CHANGELOG.md                    # This file
├── CONTRIBUTING.md                 # Contributing guidelines
├── Cargo.toml                      # Workspace configuration
├── QUICK_REFERENCE.md              # Quick reference
├── README.md                       # Main documentation
├── clippy.toml                     # Clippy configuration
├── run_benchmarks.sh               # Benchmark runner
├── rust-toolchain.toml             # Rust toolchain
├── rustfmt.toml                    # Rustfmt configuration
└── verify_setup.sh                 # Setup verification
```

### Features
- **Performance Comparison**: Compare DFIR, timely, and differential-dataflow implementations
- **Multiple Implementation Variants**: Test different execution strategies (scheduled, surface syntax, etc.)
- **HTML Reports**: Criterion generates detailed HTML reports with charts and statistics
- **Baseline Comparison**: Save and compare performance against baselines
- **Isolated Dependencies**: Keeps main repository clean by isolating timely/differential dependencies
- **Comprehensive Documentation**: Multiple levels of documentation for different use cases
- **Easy Setup**: Helper scripts for running benchmarks and verifying setup
- **Consistent Tooling**: Matches main repository's Rust formatting and linting standards

### Notes
- Benchmarks require the main `bigweaver-agent-canary-hydro-zeta` repository to be cloned alongside this repository
- Path dependencies point to `../../bigweaver-agent-canary-hydro-zeta/` for `dfir_rs` and `sinktools`
- Benchmark results are stored in `target/criterion/` with HTML reports
- All benchmarks use `criterion` with `harness = false` configuration
- Repository uses Rust edition 2024

## Migration History

This repository was created to isolate benchmarks and dependencies from the main bigweaver-agent-canary-hydro-zeta repository. The benchmarks were previously located in the `benches/` directory of the main repository.

### Rationale for Separation
1. **Dependency Isolation**: Avoid including timely and differential-dataflow dependencies in the main repository
2. **Cleaner Main Repository**: Keep the main codebase focused on core functionality
3. **Independent Development**: Allow benchmarks to be updated independently
4. **Performance Testing**: Maintain ability to run performance comparisons without cluttering main repo

### Related Documentation
- Main repository: `BENCHMARK_REMOVAL.md` - Documents the benchmark migration
- Main repository: `CHANGES_SUMMARY.md` - Summary of changes during migration

---

**Note**: This is the initial version of the repository. Future changes will be documented here following the changelog format.
