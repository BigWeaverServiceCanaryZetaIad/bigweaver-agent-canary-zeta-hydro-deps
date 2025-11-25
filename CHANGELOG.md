# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-11-25

### Added

- Initial release of timely and differential-dataflow benchmarks repository
- Migrated 8 benchmark files from bigweaver-agent-canary-hydro-zeta:
  - `arithmetic.rs` - Arithmetic operations benchmark using timely dataflow
  - `fan_in.rs` - Fan-in pattern benchmark using timely dataflow
  - `fan_out.rs` - Fan-out pattern benchmark using timely dataflow
  - `fork_join.rs` - Fork-join pattern benchmark using timely dataflow
  - `identity.rs` - Identity operations benchmark using timely dataflow
  - `join.rs` - Join operations benchmark using timely dataflow
  - `upcase.rs` - String transformation benchmark using timely dataflow
  - `reachability.rs` - Graph reachability benchmark using differential dataflow
- Included benchmark data files:
  - `reachability_edges.txt` - Graph edges dataset (521 KB)
  - `reachability_reachable.txt` - Expected reachable nodes (38 KB)
- Build infrastructure:
  - `build.rs` - Build script for generating optimized benchmark code
  - `Cargo.toml` - Workspace and package configuration
  - `rust-toolchain.toml` - Rust toolchain specification
  - `rustfmt.toml` - Code formatting configuration
  - `clippy.toml` - Linting rules
- Comprehensive documentation:
  - `README.md` - Repository overview and usage guide
  - `QUICKSTART.md` - Quick start guide for new users
  - `BENCHMARK_DETAILS.md` - Detailed benchmark documentation
  - `MIGRATION.md` - Migration history and guide
  - `CHANGELOG.md` - This file

### Changed

- Updated dependency paths from local paths to git dependencies:
  - `dfir_rs` now references hydro-project/hydro repository
  - `sinktools` now references hydro-project/hydro repository
- Renamed package from `benches` to `timely-differential-benchmarks` for clarity
- Established independent workspace structure

### Dependencies

- criterion = "0.5.0" (with async_tokio and html_reports features)
- timely-master = "0.13.0-dev.1"
- differential-dataflow-master = "0.13.0-dev.1"
- dfir_rs (from hydro-project/hydro, main branch)
- sinktools (from hydro-project/hydro, main branch)
- futures = "0.3"
- tokio = "1.29.0" (with rt-multi-thread feature)
- rand = "0.8.0"
- rand_distr = "0.4.3"
- seq-macro = "0.2.0"
- static_assertions = "1.0.0"
- nameof = "1.0.0"

## Migration History

This repository was created to separate timely and differential-dataflow benchmarks from the main hydro repository (bigweaver-agent-canary-hydro-zeta). This separation:

- Reduces dependencies in the main repository
- Improves maintainability through clearer separation of concerns
- Enables independent versioning of benchmark code
- Maintains performance comparison capabilities
- Follows the team's architectural pattern for benchmark organization

For detailed migration information, see [MIGRATION.md](MIGRATION.md).

## Future Plans

### Planned Enhancements

- [ ] CI/CD integration for automated benchmark runs
- [ ] Performance regression detection
- [ ] Benchmark result visualization dashboard
- [ ] Additional timely dataflow benchmarks
- [ ] Additional differential dataflow benchmarks
- [ ] Comparative analysis tools
- [ ] Historical performance tracking

### Under Consideration

- Integration with main repository for cross-implementation comparison
- Automated performance reports
- Benchmark parameter tuning tools
- Memory profiling integration
- Support for distributed benchmarks

---

## Version History

- **0.1.0** (2024-11-25) - Initial release with migrated benchmarks

[0.1.0]: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/releases/tag/v0.1.0
