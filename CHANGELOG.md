# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-11-24

### Added

#### Benchmarks
- Added 12 comprehensive benchmark files migrated from bigweaver-agent-canary-hydro-zeta:
  - `arithmetic.rs` - Arithmetic operation pipeline benchmarks
  - `fan_in.rs` - Fan-in pattern benchmarks
  - `fan_out.rs` - Fan-out pattern benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `futures.rs` - Async futures benchmarks
  - `identity.rs` - Identity dataflow benchmarks
  - `join.rs` - Join operation benchmarks
  - `micro_ops.rs` - Micro-operation benchmarks
  - `reachability.rs` - Graph reachability benchmarks
  - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
  - `upcase.rs` - String uppercase transformation benchmarks
  - `words_diamond.rs` - Word processing diamond pattern benchmarks

#### Benchmark Data Files
- Added `reachability_edges.txt` (521 KB) - Graph edge data for reachability benchmarks
- Added `reachability_reachable.txt` (38 KB) - Expected reachable nodes for validation
- Added `words_alpha.txt` (3.7 MB) - English word list for string processing benchmarks

#### Dependencies
- Added timely dataflow dependency (v0.13.0-dev.1)
- Added differential-dataflow dependency (v0.13.0-dev.1)
- Added criterion benchmarking framework (v0.5.0) with async_tokio and html_reports features
- Added path dependencies to dfir_rs and sinktools from main repository
- Added supporting dependencies: futures, nameof, rand, rand_distr, seq-macro, static_assertions, tokio

#### Build System
- Added `build.rs` build script for generating fork_join benchmark code
- Configured all 12 benchmarks in Cargo.toml with `harness = false`

#### Documentation
- Created comprehensive `README.md` with:
  - Repository overview and purpose
  - Complete benchmark descriptions
  - Quick start guide
  - Running benchmarks instructions
  - Performance comparison overview
  - Troubleshooting guide
  - Development workflow
  - Repository structure documentation

- Created `BENCHMARK_GUIDE.md` with:
  - Detailed explanation of each benchmark
  - Running benchmark commands and options
  - Result interpretation guide
  - HTML report usage
  - Best practices for benchmarking
  - Advanced usage including profiling and flamegraphs
  - Troubleshooting common issues

- Created `PERFORMANCE_COMPARISON.md` with:
  - Guide for comparing different implementations
  - Tracking performance over time
  - Cross-repository comparison workflows
  - Regression detection strategies
  - Automated comparison tools
  - Example workflows and scripts
  - Statistical analysis guidance

- Created `CHANGELOG.md` (this file) for tracking changes

### Context

This initial release establishes the bigweaver-agent-canary-zeta-hydro-deps repository as the dedicated location for benchmarks that require timely and differential-dataflow dependencies. These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to achieve:

1. **Dependency Isolation**: Keep external dependencies separate from core codebase
2. **Reduced Complexity**: Minimize compilation time in main repository
3. **Maintained Performance Testing**: Retain ability to run comprehensive performance comparisons
4. **Separation of Concerns**: Keep benchmark code separate from production code

### Migration Details

- **Source Repository**: bigweaver-agent-canary-hydro-zeta
- **Original Location**: `benches/` directory
- **Migration Date**: November 24, 2024
- **Related Documentation**: See `BENCHMARK_REMOVAL.md` in the main repository

### Performance Comparison Capabilities

This repository enables comprehensive performance comparisons between:
- Hydro (dfir_rs) dataflow system
- Timely dataflow system
- Differential dataflow system
- Raw Rust baseline implementations
- Standard Rust iterator implementations

Each benchmark includes multiple implementations allowing for direct performance comparison and regression detection.

### Dependencies on Main Repository

The benchmarks in this repository depend on the following crates from bigweaver-agent-canary-hydro-zeta:
- `dfir_rs` - Core Hydro dataflow functionality (with debugging features)
- `sinktools` - Utility tools for dataflow sinks

These are configured as path dependencies expecting the main repository to be located at `../bigweaver-agent-canary-hydro-zeta`.

### Future Enhancements

Potential future additions:
- Continuous benchmarking integration
- Automated performance regression detection
- Historical performance tracking
- Additional benchmark patterns
- Performance comparison dashboard
- Integration with CI/CD pipelines

---

**Repository**: bigweaver-agent-canary-zeta-hydro-deps  
**Owner**: BigWeaverServiceCanaryZetaIad  
**License**: Apache-2.0
