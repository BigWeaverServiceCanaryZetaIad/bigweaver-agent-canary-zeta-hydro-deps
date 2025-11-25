# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup for timely and differential-dataflow benchmarks
- Migrated benchmarks from bigweaver-agent-canary-hydro-zeta repository:
  - arithmetic: Basic arithmetic operations benchmark
  - fan_in: Stream concatenation benchmark  
  - upcase: String transformation benchmark
  - join: Hash join operations benchmark
  - reachability: Graph reachability with differential dataflow benchmark
- Workspace Cargo.toml configuration with Rust edition 2024
- Comprehensive README.md with usage instructions and benchmark descriptions
- MIGRATION.md document explaining the migration process
- .gitignore configuration for Rust projects
- Supporting benchmark data files (reachability_edges.txt, reachability_reachable.txt)

### Changed
- Removed dfir_rs and sinktools dependencies from benchmarks
- Updated benchmarks to focus on timely and differential-dataflow implementations
- Removed Hydroflow-specific benchmark functions

### Removed
- Hydroflow/dfir_rs specific benchmarks (remained in source repository)
- Dependencies on dfir_rs and sinktools packages

## [0.1.0] - 2024-11-25

### Added
- Initial release
- Core timely dataflow benchmarks
- Differential dataflow reachability benchmark
- Baseline comparison benchmarks
- Criterion-based benchmark harness integration

[Unreleased]: https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps/releases/tag/v0.1.0
