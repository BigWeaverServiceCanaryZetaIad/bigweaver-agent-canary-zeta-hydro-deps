# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with complete benchmark suite
- Benchmarks migrated from bigweaver-agent-canary-hydro-zeta repository:
  - `arithmetic` - Arithmetic operations benchmark
  - `fan_in` - Fan-in pattern benchmark (includes timely comparison)
  - `fan_out` - Fan-out pattern benchmark (includes timely comparison)
  - `fork_join` - Fork-join pattern benchmark
  - `futures` - Futures-based benchmark
  - `identity` - Identity transformation benchmark (includes timely comparison)
  - `join` - Join operations benchmark
  - `micro_ops` - Micro operations benchmark
  - `reachability` - Graph reachability benchmark (includes differential-dataflow comparison)
  - `symmetric_hash_join` - Symmetric hash join benchmark
  - `upcase` - String uppercase transformation benchmark
  - `words_diamond` - Words diamond pattern benchmark
- Test data files:
  - `reachability_edges.txt` - Graph edges for reachability testing
  - `reachability_reachable.txt` - Expected reachable nodes
  - `words_alpha.txt` - English word list for text processing benchmarks
- Comprehensive documentation:
  - `README.md` - Main repository documentation
  - `PERFORMANCE_COMPARISON.md` - Detailed performance testing guide
  - `CONTRIBUTING.md` - Contribution guidelines
  - `benches/README.md` - Benchmark-specific documentation
- Package configuration:
  - `Cargo.toml` - Workspace configuration with appropriate profiles
  - `benches/Cargo.toml` - Benchmark package with all dependencies
  - `benches/build.rs` - Build script
- Development tools:
  - `.gitignore` - Git ignore patterns
  - `rustfmt.toml` - Rust formatting configuration
  - `clippy.toml` - Clippy linting configuration
  - `rust-toolchain.toml` - Rust toolchain specification
- CI/CD:
  - `.github/workflows/benchmarks.yml` - GitHub Actions workflow for benchmarks and code quality checks
- License:
  - `LICENSE` - Apache 2.0 license

### Dependencies
- `criterion` v0.5.0 - Benchmarking framework with statistical analysis
- `timely` (timely-master) v0.13.0-dev.1 - Timely dataflow for comparative benchmarks
- `differential-dataflow` (differential-dataflow-master) v0.13.0-dev.1 - Differential dataflow for comparative benchmarks
- `dfir_rs` - Hydro DFIR runtime (from main repository)
- `sinktools` - Utility functions (from main repository)
- `futures` v0.3 - Async programming primitives
- `tokio` v1.29.0 - Async runtime
- `rand` v0.8.0 - Random number generation
- `rand_distr` v0.4.3 - Random distributions
- `seq-macro` v0.2.0 - Sequence macros
- `nameof` v1.0.0 - Name-of macro
- `static_assertions` v1.0.0 - Compile-time assertions

### Features
- Performance comparison functionality with timely and differential-dataflow
- Comprehensive benchmark suite covering various Hydro operations
- Statistical analysis and HTML report generation via Criterion
- Support for baseline comparisons to track performance over time
- Local development setup with path-based dependencies
- Git-based dependencies for CI/CD integration

### Documentation
- Detailed setup and usage instructions
- Performance comparison methodology
- Contribution guidelines
- Benchmark-specific documentation
- Troubleshooting guides

[Unreleased]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/commits/main
