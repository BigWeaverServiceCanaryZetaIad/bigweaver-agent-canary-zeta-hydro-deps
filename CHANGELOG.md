# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial repository setup with workspace configuration
- Moved timely and differential-dataflow benchmarks from bigweaver-agent-canary-hydro-zeta
- Added 8 benchmark files:
  - `arithmetic.rs` - Arithmetic operations pipeline comparison
  - `fan_in.rs` - Fan-in pattern benchmark
  - `fan_out.rs` - Fan-out pattern benchmark
  - `fork_join.rs` - Fork-join pattern benchmark
  - `identity.rs` - Identity transformation benchmark
  - `join.rs` - Join operations benchmark
  - `reachability.rs` - Graph reachability benchmark
  - `upcase.rs` - String uppercasing benchmark
- Added supporting files:
  - `build.rs` - Build script for benchmark code generation
  - `reachability_edges.txt` - Test data for reachability benchmark
  - `reachability_reachable.txt` - Expected reachability results
  - `words_alpha.txt` - Word list for text processing benchmarks
- Added dependencies:
  - timely-master (v0.13.0-dev.1)
  - differential-dataflow-master (v0.13.0-dev.1)
  - criterion (v0.5.0) with async_tokio and html_reports features
  - futures, rand, rand_distr, tokio, and other supporting libraries
- Added configuration files:
  - `rust-toolchain.toml` - Rust 1.91.1 toolchain specification
  - `rustfmt.toml` - Code formatting rules
  - `clippy.toml` - Linting configuration
- Added documentation:
  - `README.md` - Main repository documentation
  - `benches/README.md` - Benchmark-specific documentation
  - `MIGRATION.md` - Migration guide from main repository
  - `CHANGELOG.md` - This file

### Changed

- N/A (initial release)

### Deprecated

- N/A

### Removed

- N/A

### Fixed

- N/A

### Security

- N/A

## Notes

This repository was created to separate timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository. This separation allows for:
- Cleaner dependency management in the main repository
- Better build times by isolating heavy external dependencies
- Clear modular architecture with separation of concerns
- Independent version management for comparative benchmarking tools
