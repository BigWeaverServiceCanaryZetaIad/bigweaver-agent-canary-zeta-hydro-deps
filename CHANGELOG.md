# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2024-11-26

### Added

- Initial repository setup for timely and differential-dataflow benchmarks
- Transferred benchmark files from bigweaver-agent-canary-hydro-zeta repository:
  - `arithmetic.rs` - Arithmetic operations benchmark
  - `fan_in.rs` - Fan-in pattern benchmark
  - `fan_out.rs` - Fan-out pattern benchmark
  - `fork_join.rs` - Fork-join pattern benchmark
  - `identity.rs` - Identity operation benchmark
  - `join.rs` - Join operation benchmark
  - `reachability.rs` - Graph reachability benchmark
  - `upcase.rs` - String uppercase benchmark
  - `reachability_edges.txt` - Test data
  - `reachability_reachable.txt` - Test data
- Cargo workspace configuration with benches package
- Dependencies for benchmarking:
  - timely-master (0.13.0-dev.1)
  - differential-dataflow-master (0.13.0-dev.1)
  - criterion (0.5.0) with async and HTML reports
  - dfir_rs (git) for comparison benchmarks
  - sinktools (git) for Hydroflow utilities
  - Supporting libraries (futures, tokio, rand, etc.)
- Build script (`build.rs`) for fork_join code generation
- Configuration files:
  - `rust-toolchain.toml` - Rust 1.91.1 toolchain
  - `rustfmt.toml` - Code formatting rules
  - `clippy.toml` - Linting configuration
  - `.gitignore` - Git ignore patterns
- Comprehensive documentation:
  - Root `README.md` with full repository documentation
  - `benches/README.md` with benchmark-specific instructions
  - `MIGRATION_SUMMARY.md` detailing the migration from main repository
  - This `CHANGELOG.md` for tracking changes

### Purpose

This repository was created to separate timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository, providing:
- Clean dependency separation
- Focused performance testing environment
- Better repository organization
- Preserved comparison functionality between Timely, Differential, and Hydroflow

[0.0.1]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/releases/tag/v0.0.1
