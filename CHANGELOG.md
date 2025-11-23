# Changelog

All notable changes to the bigweaver-agent-canary-zeta-hydro-deps repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with workspace configuration
- Timely and differential-dataflow benchmarks migrated from main repository
- Comprehensive benchmark suite including:
  - `arithmetic.rs` - Arithmetic operations comparison
  - `fan_in.rs` - Fan-in pattern benchmark
  - `fan_out.rs` - Fan-out pattern benchmark
  - `fork_join.rs` - Fork-join pattern benchmark
  - `identity.rs` - Identity operation baseline
  - `join.rs` - Relational join operations
  - `reachability.rs` - Graph reachability algorithms
  - `upcase.rs` - String transformation
- Test data files for reachability benchmark
- Comprehensive README documentation
- `run_benchmarks.sh` - Script for running benchmarks with various options
- `compare_with_main.sh` - Script for comparing results with main repository
- Build script (`build.rs`) for generating fork-join test cases
- Git dependency configuration for dfir_rs and sinktools

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

## Migration Details

This repository was created as part of a refactoring effort to separate timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository.

### Rationale
- Reduce compilation time for main repository development
- Isolate heavy dependencies (timely, differential-dataflow)
- Maintain performance comparison capabilities
- Enable independent benchmark evolution
- Improve CI/CD pipeline efficiency

### Migrated Components

**From**: `bigweaver-agent-canary-hydro-zeta/benches/benches/`
**To**: `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`

Files migrated:
- `arithmetic.rs` (7.6 KB)
- `fan_in.rs` (3.5 KB)
- `fan_out.rs` (3.6 KB)
- `fork_join.rs` (4.3 KB)
- `identity.rs` (6.8 KB)
- `join.rs` (4.4 KB)
- `reachability.rs` (14 KB)
- `upcase.rs` (3.1 KB)
- `reachability_edges.txt` (521 KB)
- `reachability_reachable.txt` (38 KB)

### Integration Points

This repository maintains integration with the main repository through:
- Git dependencies for `dfir_rs` and `sinktools`
- Shared performance comparison methodology
- Coordinated benchmark updates

### Verification

All migrated benchmarks have been verified to:
- Compile successfully with new dependency structure
- Maintain performance comparison functionality
- Produce consistent results with historical data
- Work with CI/CD integration

See `benches/README.md` for detailed benchmark documentation.
