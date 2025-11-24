# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with benchmarks migrated from bigweaver-agent-canary-hydro-zeta
- Workspace configuration with Cargo.toml
- Comprehensive documentation:
  - README.md with repository overview and quick start guide
  - benches/README.md with detailed benchmark usage documentation
  - BENCHMARK_MIGRATION.md documenting the migration rationale and process
  - CONTRIBUTING.md with contribution guidelines
- CI/CD workflow for automated benchmark execution
- Rust configuration files (rustfmt.toml, clippy.toml, rust-toolchain.toml)
- All 12 benchmark implementations:
  - arithmetic: Arithmetic operations
  - fan_in: Multiple inputs to single output
  - fan_out: Single input to multiple outputs
  - fork_join: Parallel execution with synchronization
  - futures: Async/future operations
  - identity: Pass-through baseline benchmarks
  - join: Data joining operations
  - micro_ops: Fine-grained operation benchmarks
  - reachability: Graph reachability algorithms
  - symmetric_hash_join: Hash join implementations
  - upcase: String transformations
  - words_diamond: Diamond dataflow pattern
- Benchmark data files:
  - words_alpha.txt (370K+ words)
  - reachability_edges.txt (graph data)
  - reachability_reachable.txt (expected results)

### Changed
- Updated dependency references from path-based to git-based:
  - dfir_rs now references main Hydro repository via git
  - sinktools now references main Hydro repository via git
- Configured workspace to support independent execution

### Infrastructure
- GitHub Actions workflow for automated benchmarking
- Support for scheduled, manual, and PR-triggered benchmark runs
- GitHub Pages publishing for benchmark results
- Performance tracking over time

## Notes

### Migration Context

This repository was created to isolate timely and differential-dataflow dependencies from the main Hydro repository (bigweaver-agent-canary-hydro-zeta). The benchmarks provide performance comparisons between:
- Timely Dataflow
- Differential Dataflow  
- Hydroflow/dfir_rs

### Performance Comparison Capabilities

All benchmarks retain their ability to:
- Compare implementations fairly
- Generate statistical analysis via Criterion
- Produce HTML reports with visualizations
- Track performance over time
- Run independently without the main repository

### Related Changes

Companion changes in bigweaver-agent-canary-hydro-zeta repository:
- Removed benches/ directory
- Updated workspace members in Cargo.toml
- Removed .github/workflows/benchmark.yml
- Added BENCHMARK_REMOVAL.md documentation
- Added verify_removal.sh script

[Unreleased]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/compare/v0.0.0...HEAD
