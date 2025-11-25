# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with benchmark code migrated from bigweaver-agent-canary-hydro-zeta
- Comprehensive benchmark suite comparing DFIR/Hydro with timely-dataflow and differential-dataflow
- Benchmark implementations:
  - Arithmetic operations pipeline
  - Fan-in dataflow patterns
  - Fan-out dataflow patterns
  - Fork-join patterns
  - Identity operations
  - Join operations
  - Graph reachability algorithms
  - Symmetric hash joins
  - String transformation (upcase)
  - Words diamond pattern
  - Micro-operations
  - Futures-based async operations
- Build configuration and workspace setup
- Comprehensive documentation (README, QUICKSTART, BENCHMARK_DETAILS)
- Rust toolchain and code style configuration (rustfmt, clippy)

### Migration Notes
- All benchmark code extracted from bigweaver-agent-canary-hydro-zeta repository
- Dependencies configured to reference main repository via Git
- Preserved all benchmark functionality including performance comparison capabilities
- Test data files migrated (word lists, graph data)

[Unreleased]: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
