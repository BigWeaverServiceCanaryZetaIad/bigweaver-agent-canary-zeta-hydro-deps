# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with timely and differential-dataflow benchmarks
- Migrated benchmarks from bigweaver-agent-canary-hydro-zeta repository:
  - `arithmetic.rs` - Arithmetic operations comparison
  - `fan_in.rs` - Fan-in pattern benchmarks
  - `fan_out.rs` - Fan-out pattern benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `identity.rs` - Identity/pass-through benchmarks
  - `join.rs` - Join operation benchmarks
  - `reachability.rs` - Graph reachability with differential-dataflow
  - `upcase.rs` - String uppercase operations
  - `futures.rs` - Async/futures benchmarks
  - `micro_ops.rs` - Micro-operation benchmarks
  - `symmetric_hash_join.rs` - Symmetric hash join implementations
  - `words_diamond.rs` - Word processing diamond patterns
- Benchmark data files:
  - `words_alpha.txt` - Word list for text processing benchmarks
  - `reachability_edges.txt` - Graph edges for reachability benchmark
  - `reachability_reachable.txt` - Expected reachability results
- Configuration files:
  - `rust-toolchain.toml` - Rust version specification
  - `clippy.toml` - Clippy linting configuration
  - `rustfmt.toml` - Code formatting configuration
  - `.gitignore` - Git ignore patterns
- Documentation:
  - `README.md` - Repository overview and usage instructions
  - `benches/README.md` - Detailed benchmark documentation
  - `CHANGELOG.md` - This changelog
- Verification script `verify_benchmarks.sh` for validating benchmark builds

### Changed
- Updated benchmark dependencies to use git references to main hydro repository
- Enhanced README with comprehensive documentation about benchmark purpose and usage

[Unreleased]: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
