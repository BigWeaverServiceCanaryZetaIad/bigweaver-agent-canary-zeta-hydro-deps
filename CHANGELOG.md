# Changelog

All notable changes to the Hydro external framework benchmarks will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-12-12

### Added

#### Benchmark Migration
- Migrated timely-dataflow and differential-dataflow benchmarks from bigweaver-agent-canary-hydro-zeta repository
- Complete benchmark suite including:
  - `arithmetic.rs`: Numerical computation benchmarks
  - `fan_in.rs`: Multiple input convergence patterns
  - `fan_out.rs`: Single input distribution patterns
  - `fork_join.rs`: Parallel processing with synchronization
  - `futures.rs`: Asynchronous operation handling
  - `identity.rs`: Framework overhead baseline measurements
  - `join.rs`: Standard equi-join operations
  - `micro_ops.rs`: Fine-grained operation benchmarks
  - `reachability.rs`: Graph traversal algorithms
  - `symmetric_hash_join.rs`: Hash-based join implementations
  - `upcase.rs`: String transformation operations
  - `words_diamond.rs`: Diamond dataflow pattern benchmarks

#### Dependencies
- Added timely-dataflow (timely-master 0.13.0-dev.1)
- Added differential-dataflow (differential-dataflow-master 0.13.0-dev.1)
- Added criterion 0.5.0 for benchmarking framework
- Added supporting dependencies: futures, rand, tokio, etc.
- Configured git dependencies for dfir_rs and sinktools from main Hydro repository

#### Test Data
- `words_alpha.txt`: English word dictionary (~370K words) for text processing benchmarks
- `reachability_edges.txt`: Graph edge data for reachability benchmarks
- `reachability_reachable.txt`: Expected reachable nodes for validation

#### Configuration
- `rust-toolchain.toml`: Rust 1.91.1 with required components
- `rustfmt.toml`: Code formatting configuration (consistent with main Hydro repo)
- `clippy.toml`: Linting configuration (consistent with main Hydro repo)
- Workspace configuration with proper lints and profiles
- Release profile optimized for performance measurements

#### Documentation
- `README.md`: Comprehensive repository overview and usage guide
- `benches/README.md`: Detailed benchmark descriptions and usage instructions
- `PERFORMANCE_COMPARISON.md`: In-depth guide for running performance comparisons
- `CONTRIBUTING.md`: Guidelines for adding and improving benchmarks
- `QUICK_START.md`: Fast-track guide for new users
- `CHANGELOG.md`: This file

#### Repository Structure
- Workspace-based Cargo project structure
- Separate package for benchmarks (`hydro-timely-benchmarks`)
- Organized directory layout:
  ```
  bigweaver-agent-canary-zeta-hydro-deps/
  ├── benches/          # Benchmark package
  │   ├── benches/      # Benchmark implementations
  │   └── Cargo.toml    # Package configuration
  └── Cargo.toml        # Workspace configuration
  ```

### Migration Details

#### Rationale
These benchmarks were separated from the main Hydro repository to:
1. Eliminate timely/differential dependencies from main codebase
2. Reduce build times for Hydro developers
3. Maintain benchmark capability for cross-framework performance research
4. Enable independent versioning of external framework dependencies

#### Source
Benchmarks extracted from commit `e5c5e224` of bigweaver-agent-canary-hydro-zeta repository, which was the last commit containing the full benchmark suite before removal.

#### Changes from Original
- Updated package name from `benches` to `hydro-timely-benchmarks`
- Changed dfir_rs and sinktools from path dependencies to git dependencies
- Reorganized as standalone repository with workspace structure
- Enhanced documentation for independent usage
- Added comprehensive guides for performance comparison

### Technical Notes

#### Benchmark Framework
All benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) for:
- Statistical analysis of measurements
- HTML report generation
- Baseline comparison support
- Reproducible results

#### Framework Versions
- **DFIR**: Latest from main Hydro repository
- **Timely**: 0.13.0-dev.1 (timely-master)
- **Differential**: 0.13.0-dev.1 (differential-dataflow-master)

#### Performance Profiles
- `release`: Optimized for benchmark execution (LTO, single codegen unit)
- `profile`: Debug symbols enabled for profiling

### Known Issues
None at initial release.

### Future Work
- [ ] Add more complex workflow benchmarks
- [ ] Include memory usage measurements
- [ ] Add CI/CD integration for continuous benchmarking
- [ ] Implement automated performance regression detection
- [ ] Add flamegraph generation for profiling
- [ ] Create benchmark comparison visualizations

---

## Release Notes

### Version 0.1.0 - Initial Release

This is the initial release of the separated benchmark repository. All benchmarks have been validated to run correctly and produce consistent results across DFIR, Timely, and Differential frameworks.

**Migration Status**: ✅ Complete

**Validation**: All 12 benchmark suites successfully extracted and tested

**Documentation**: Comprehensive guides provided for all usage scenarios

---

For questions or issues, please refer to the main README.md or open an issue in the repository.
