# Changelog

All notable changes to this repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with benchmark suite
- Comprehensive documentation suite
  - Quick start guide (docs/QUICKSTART.md)
  - Performance comparison guide (docs/BENCHMARKS_COMPARISON.md)
  - Migration notes (docs/MIGRATION.md)
- Helper scripts for running benchmarks
  - run_benchmarks.sh - Main benchmark execution script
  - compare_performance.sh - Performance comparison workflow script
- Workspace configuration with proper dependency management
- Rust toolchain specification matching main repository

### Migrated from bigweaver-agent-canary-hydro-zeta

The following benchmarks were migrated from the main repository on 2024-11-22:

#### Benchmark Files
- arithmetic.rs - Arithmetic operations benchmarking
- fan_in.rs - Fan-in pattern benchmarking
- fan_out.rs - Fan-out pattern benchmarking
- fork_join.rs - Fork-join pattern benchmarking
- identity.rs - Identity operation benchmarking
- join.rs - Join operation benchmarking
- micro_ops.rs - Micro-operations benchmarking
- reachability.rs - Graph reachability benchmarking
- symmetric_hash_join.rs - Symmetric hash join benchmarking
- upcase.rs - Uppercase transformation benchmarking
- words_diamond.rs - Word processing diamond pattern

#### Test Data
- reachability_edges.txt - Graph edges for reachability tests
- reachability_reachable.txt - Expected reachable nodes
- words_alpha.txt - English word list for text processing

#### Supporting Files
- Cargo.toml - Benchmark dependencies configuration
- README.md - Benchmark documentation
- build.rs - Build script for generated code
- .gitignore - Git ignore patterns

### Dependencies Added
- timely-master (0.13.0-dev.1) - Timely dataflow framework
- differential-dataflow-master (0.13.0-dev.1) - Differential dataflow framework
- criterion (0.5.0) - Benchmarking framework
- rand (0.8.0) - Random number generation
- rand_distr (0.4.3) - Random distributions
- tokio (1.29.0) - Async runtime
- nameof (1.0.0) - Name reflection
- seq-macro (0.2.0) - Sequence macros
- static_assertions (1.0.0) - Compile-time assertions

### Changed
- Updated path dependencies to point to sibling main repository
- Added dfir_rs alias as hydroflow for compatibility
- Adapted workspace structure for standalone repository

## [0.1.0] - 2024-11-22

### Added
- Initial release of benchmark repository
- Complete migration of timely and differential-dataflow benchmarks
- Comprehensive documentation and helper scripts
- Full performance comparison infrastructure

[Unreleased]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/releases/tag/v0.1.0
