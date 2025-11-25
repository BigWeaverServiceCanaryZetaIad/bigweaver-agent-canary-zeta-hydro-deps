# Changelog

All notable changes to the Hydro benchmarks repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-11-25

### Added

#### Benchmarks
- **arithmetic.rs** - Pipeline of arithmetic operations comparing Hydro, Timely, and raw implementations
- **fan_in.rs** - Fan-in pattern benchmark comparing Hydro vs. Timely
- **fan_out.rs** - Fan-out pattern benchmark comparing Hydro vs. Timely
- **fork_join.rs** - Fork-join pattern benchmark comparing Hydro vs. Timely
- **identity.rs** - Identity/no-op benchmark measuring framework overhead
- **join.rs** - Stream join operations benchmark comparing Hydro vs. Timely
- **reachability.rs** - Graph reachability benchmark comparing Hydro, Timely, and Differential
- **upcase.rs** - String transformation benchmark comparing Hydro vs. Timely

#### Data Files
- **reachability_edges.txt** - Test graph edge list (~520KB)
- **reachability_reachable.txt** - Expected reachable nodes (~40KB)

#### Configuration
- **Cargo.toml** - Workspace configuration with Rust 2024 edition
- **benches/Cargo.toml** - Benchmark package configuration with all dependencies
  - criterion 0.5.0 with async support
  - timely-master 0.13.0-dev.1
  - differential-dataflow-master 0.13.0-dev.1
  - References to dfir_rs and sinktools from main repository

#### Documentation
- **README.md** - Comprehensive repository overview
  - Quick start guide
  - Available benchmarks table
  - Prerequisites and setup instructions
  - Troubleshooting section
  - Performance tips
  
- **BENCHMARK_GUIDE.md** - Detailed benchmarking guide
  - Complete benchmark descriptions
  - Running and customizing benchmarks
  - Interpreting results
  - Advanced profiling techniques
  - Performance analysis guidelines
  
- **CONTRIBUTING.md** - Contribution guidelines
  - Development setup instructions
  - Adding new benchmarks
  - Testing requirements
  - Documentation standards
  - Pull request process
  - Coding standards
  
- **benches/README.md** - Benchmarks directory overview
  - Individual benchmark descriptions
  - Usage examples
  - Troubleshooting tips

- **CHANGELOG.md** - This file

#### Scripts
- **verify_benchmarks.sh** - Comprehensive verification script
  - Checks repository structure
  - Verifies dependencies
  - Validates benchmark files
  - Tests compilation
  - Runs quick benchmark test
  - Checks code formatting and lints

### Repository Features

#### Dependency Management
- Separated timely and differential-dataflow dependencies from main repository
- References dfir_rs and sinktools from main repository via relative paths
- Maintains workspace structure for consistent linting and configuration

#### Performance Comparison
- All benchmarks include multiple implementation variants
- Criterion-based benchmarking with HTML reports
- Statistical analysis of results
- Historical comparison support

#### Code Quality
- Workspace-level linting configuration
- Rust 2024 edition
- Clippy and rustfmt integration
- Comprehensive test coverage via verification script

### Migration

This repository contains benchmarks migrated from the main Hydro repository 
(bigweaver-agent-canary-hydro-zeta) to:
- Reduce dependency footprint in main repository
- Improve build times for users not running benchmarks
- Enable independent benchmark development
- Maintain cleaner separation of concerns

All functionality has been preserved with no loss of performance comparison capabilities.

### Notes

- Benchmarks require the main Hydro repository to be cloned alongside this one
- Recommended directory structure:
  ```
  workspace/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
  ```
- Build times: Initial build may take 5-10 minutes due to timely/differential dependencies
- System requirements: 4GB RAM minimum, more recommended for reachability benchmark

## [Unreleased]

### Planned Features
- CI/CD integration for automated benchmark runs
- Performance regression detection
- Historical performance tracking
- Additional benchmarks for new Hydro features
- Flamegraph generation integration
- Memory profiling utilities

---

## Version History

- **0.1.0** (2025-11-25) - Initial release with 8 benchmarks migrated from main repository

[0.1.0]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/releases/tag/v0.1.0
[Unreleased]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/compare/v0.1.0...HEAD
