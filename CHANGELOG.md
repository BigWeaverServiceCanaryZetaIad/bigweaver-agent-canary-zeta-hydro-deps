# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-11-25

### Added

- Initial repository setup for timely and differential-dataflow benchmarks
- Migrated 8 benchmark files from bigweaver-agent-canary-hydro-zeta:
  - `arithmetic.rs` - Arithmetic pipeline benchmarks
  - `fan_in.rs` - Fan-in pattern benchmarks
  - `fan_out.rs` - Fan-out pattern benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `identity.rs` - Identity/overhead benchmarks
  - `join.rs` - Join operation benchmarks
  - `reachability.rs` - Graph reachability benchmarks
  - `upcase.rs` - String transformation benchmarks
- Migrated 2 data files:
  - `reachability_edges.txt` - Graph edge data (521 KB)
  - `reachability_reachable.txt` - Expected reachable nodes (38 KB)
- Created comprehensive documentation:
  - `README.md` - Repository overview and quick start
  - `BENCHMARK_GUIDE.md` - Detailed benchmarking guide
  - `MIGRATION_SUMMARY.md` - Migration details and rationale
  - `CHANGELOG.md` - This file
- Configured dependencies in `Cargo.toml`:
  - timely-master 0.13.0-dev.1
  - differential-dataflow-master 0.13.0-dev.1
  - criterion 0.5.0 with async and HTML features
  - Path dependencies to dfir_rs and sinktools from main repository
- Created verification script (`verify_setup.sh`)

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

## Migration Notes

This repository was created to host benchmarks that were removed from the main `bigweaver-agent-canary-hydro-zeta` repository. The separation allows the main repository to avoid dependencies on timely and differential-dataflow packages, improving build times and maintaining cleaner separation of concerns.

For detailed migration information, see `MIGRATION_SUMMARY.md`.

## Future Plans

- Add additional timely/differential-dataflow benchmarks as needed
- Maintain compatibility with main repository's dfir_rs API
- Expand benchmark coverage for dataflow patterns
- Add CI/CD integration for automated benchmark runs
- Create performance regression tracking
