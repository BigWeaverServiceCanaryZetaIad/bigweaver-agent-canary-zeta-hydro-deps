# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2024-11-25

### Added
- Initial repository setup with workspace configuration
- Migrated 8 benchmark files from bigweaver-agent-canary-hydro-zeta:
  - `arithmetic.rs` - Arithmetic operations performance comparison
  - `fan_in.rs` - Multiple input convergence benchmarks
  - `fan_out.rs` - Single input to multiple outputs benchmarks
  - `fork_join.rs` - Complex branching and joining patterns
  - `identity.rs` - Identity operation overhead measurement
  - `join.rs` - Join operation performance comparison
  - `reachability.rs` - Graph reachability analysis
  - `upcase.rs` - String transformation benchmarks
- Migrated 2 data files:
  - `reachability_edges.txt` - Graph edge data (521 KB)
  - `reachability_reachable.txt` - Expected reachable nodes (38 KB)
- Added timely and differential-dataflow dependencies
  - timely-master v0.13.0-dev.1
  - differential-dataflow-master v0.13.0-dev.1
- Configuration files:
  - `rust-toolchain.toml` - Rust 1.91.1 toolchain
  - `rustfmt.toml` - Code formatting rules
  - `clippy.toml` - Linting configuration
  - `build.rs` - Build script for generating benchmark code
- Comprehensive documentation:
  - `README.md` - Repository overview and usage
  - `MIGRATION.md` - Detailed migration documentation
  - `BENCHMARK_DETAILS.md` - In-depth benchmark descriptions
  - `benches/README.md` - Benchmark-specific documentation
  - `CHANGELOG.md` - This file
- Verification script:
  - `verify_benchmarks.sh` - Automated verification of repository setup
- Development dependencies:
  - criterion v0.5.0 with async_tokio and html_reports features
  - dfir_rs from main hydro repository
  - Supporting dependencies: futures, rand, tokio, static_assertions, etc.

### Documentation
- Detailed description of each benchmark's purpose and methodology
- Instructions for running benchmarks
- Migration rationale and impact analysis
- Performance interpretation guidelines
- Troubleshooting guide

### Infrastructure
- Cargo workspace setup with proper dependency management
- Benchmark harness configuration (harness = false for all benchmarks)
- Build script for dynamic code generation (fork_join benchmark)
- Linting and formatting configurations matching parent project

### Notes
- This repository was created to separate timely and differential-dataflow benchmarks from the main hydro project
- The separation improves build times and maintains cleaner dependency boundaries
- All benchmarks retain their original functionality and performance characteristics
- The repository uses git dependency for dfir_rs to ensure compatibility with the main hydro project

### Migration Details
- Source repository: bigweaver-agent-canary-hydro-zeta
- Total code migrated: ~610 KB
- Benefits: Faster main repo builds, cleaner architecture, better maintainability
- No breaking changes to benchmark functionality

[Unreleased]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/releases/tag/v0.1.0
