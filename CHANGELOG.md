# Changelog

All notable changes to this repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2024-11-21

### Added
- Initial migration of timely and differential-dataflow benchmarks from bigweaver-agent-canary-hydro-zeta
- Complete benchmark suite with 12 benchmark implementations:
  - arithmetic.rs - Arithmetic operations benchmark
  - fan_in.rs - Fan-in pattern benchmark
  - fan_out.rs - Fan-out pattern benchmark
  - fork_join.rs - Fork-join pattern benchmark
  - futures.rs - Async/futures benchmark
  - identity.rs - Identity/baseline benchmark
  - join.rs - Join operations benchmark
  - micro_ops.rs - Micro-operations benchmark
  - reachability.rs - Graph reachability benchmark with differential-dataflow
  - symmetric_hash_join.rs - Hash join benchmark
  - upcase.rs - String transformation benchmark
  - words_diamond.rs - Diamond pattern benchmark
- Test data files:
  - reachability_edges.txt - Graph edges for reachability testing
  - reachability_reachable.txt - Expected reachability results
  - words_alpha.txt - English word list for text processing
- Build infrastructure:
  - Cargo workspace configuration
  - benches package with all dependencies
  - build.rs script for code generation
- Comprehensive documentation:
  - README.md - Repository overview and usage
  - MIGRATION.md - Detailed migration documentation
  - QUICKSTART.md - Quick start guide for new users
  - PERFORMANCE_COMPARISON.md - Performance comparison methodology
  - VERIFICATION_CHECKLIST.md - Verification procedures
  - CONTRIBUTING.md - Contribution guidelines
  - SUMMARY.md - Migration summary
  - CHANGELOG.md - This file

### Changed
- Updated dfir_rs dependency from path to published crates.io version 0.14.0
- Updated sinktools dependency from path to git repository reference
- Converted workspace structure for standalone operation

### Dependencies
- criterion = 0.5.0
- dfir_rs = 0.14.0
- timely (timely-master) = 0.13.0-dev.1
- differential-dataflow (differential-dataflow-master) = 0.13.0-dev.1
- futures = 0.3
- nameof = 1.0.0
- rand = 0.8.0
- rand_distr = 0.4.3
- seq-macro = 0.2.0
- sinktools = 0.0.1 (from git)
- static_assertions = 1.0.0
- tokio = 1.29.0

### Notes
- All benchmarks migrated from commit 9c5c622e^ of source repository
- Total of 19 files transferred (~4.5 MB)
- Maintains compatibility with original benchmarking capabilities
- Ready for independent version management and updates

[Unreleased]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/releases/tag/v1.0.0
