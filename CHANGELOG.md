# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with timely and differential-dataflow benchmark suite
- Transferred 8 benchmark files from bigweaver-agent-canary-hydro-zeta:
  - arithmetic.rs - Arithmetic operation pipeline benchmarks
  - fan_in.rs - Fan-in pattern benchmarks
  - fan_out.rs - Fan-out pattern benchmarks
  - fork_join.rs - Fork-join pattern benchmarks
  - identity.rs - Identity operation benchmarks
  - join.rs - Join operation benchmarks
  - reachability.rs - Graph reachability benchmarks
  - upcase.rs - String transformation benchmarks
- Benchmark test data files:
  - reachability_edges.txt (521K)
  - reachability_reachable.txt (38K)
- Comprehensive documentation:
  - README.md - Repository overview and quick start
  - benches/README.md - Detailed benchmark documentation
  - TESTING_GUIDE.md - Complete testing and usage guide
  - CHANGELOG.md - This file
- Build configuration:
  - Cargo.toml workspace configuration
  - benches/Cargo.toml with timely and differential-dataflow dependencies
  - benches/build.rs for generated benchmarks
- Code quality tools:
  - clippy.toml - Clippy configuration
  - rustfmt.toml - Code formatting configuration
  - rust-toolchain.toml - Rust toolchain specification
  - .gitignore - Git ignore rules
- Performance comparison functionality:
  - Criterion.rs integration for statistical analysis
  - HTML report generation
  - Regression detection capabilities
  - Multiple framework comparisons (timely, differential, dfir_rs)

### Dependencies
- timely v0.13.0-dev.1 (timely-master package)
- differential-dataflow v0.13.0-dev.1 (differential-dataflow-master package)
- criterion v0.5.0 with async_tokio and html_reports features
- dfir_rs from main repository (via git)
- sinktools from main repository (via git)
- Supporting dependencies: futures, tokio, rand, rand_distr, seq-macro, static_assertions, nameof

### Documentation
- Complete benchmark documentation with usage examples
- Performance comparison methodology and interpretation guide
- CI/CD integration examples
- Troubleshooting guide
- Best practices for benchmark development

### Infrastructure
- Workspace configuration for multi-package support
- Build scripts for generated code
- Lint and format configuration matching main repository standards

## Migration Notes

This repository was created to isolate timely and differential-dataflow dependencies from the main bigweaver-agent-canary-hydro-zeta repository while preserving performance comparison functionality. The benchmarks were previously part of the main repository but were moved to:

1. Reduce dependency complexity in the main codebase
2. Separate framework-specific benchmark dependencies
3. Enable independent development of comparison benchmarks
4. Follow clean architecture and separation of concerns principles

For detailed migration information, see the main repository's MIGRATION_NOTES.md and REMOVAL_SUMMARY.md files.

## Future Plans

### Planned Features
- CI/CD workflow for automated benchmark runs
- Performance regression detection and alerting
- Historical performance tracking and visualization
- Additional benchmark scenarios
- Cross-platform benchmark comparisons
- Benchmark result publishing to gh-pages

### Potential Improvements
- Parameterized benchmarks for multiple data sizes
- Memory usage benchmarks alongside timing
- Throughput and latency separate measurements
- Comparative flamegraphs
- Automated performance reports

---

[Unreleased]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/compare/initial...HEAD
