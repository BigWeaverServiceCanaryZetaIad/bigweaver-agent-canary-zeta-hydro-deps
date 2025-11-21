# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-11-21

### Added - Initial Migration

- **Complete benchmark suite** transferred from bigweaver-agent-canary-hydro-zeta repository
- **12 benchmark files** covering various dataflow patterns and operations:
  - `arithmetic.rs` - Arithmetic operations benchmark
  - `fan_in.rs` - Fan-in pattern benchmark
  - `fan_out.rs` - Fan-out pattern benchmark  
  - `fork_join.rs` - Fork-join pattern benchmark
  - `futures.rs` - Futures/async operations benchmark
  - `identity.rs` - Identity/passthrough benchmark
  - `join.rs` - Join operations benchmark
  - `micro_ops.rs` - Micro-operations benchmark
  - `reachability.rs` - Graph reachability benchmark
  - `symmetric_hash_join.rs` - Symmetric hash join benchmark
  - `upcase.rs` - String transformation benchmark
  - `words_diamond.rs` - Diamond pattern benchmark

- **Data files** for benchmarks:
  - `reachability_edges.txt` (~521 KB) - Graph edges data
  - `reachability_reachable.txt` (~38 KB) - Expected reachable nodes
  - `words_alpha.txt` (~3.7 MB) - English word list

- **Dependencies** for performance comparison:
  - `timely` (v0.13.0-dev.1) - Timely Dataflow framework
  - `differential-dataflow` (v0.13.0-dev.1) - Differential Dataflow framework
  - `criterion` (v0.5.0) - Benchmarking framework with HTML reports
  - Hydroflow dependencies via git (dfir_rs, sinktools)

- **Infrastructure**:
  - Workspace configuration with proper Cargo.toml setup
  - Build script (build.rs) for generating benchmark code
  - CI/CD workflow for automated benchmark runs
  - Comprehensive documentation suite

- **Documentation**:
  - `README.md` - Main repository documentation with usage instructions
  - `benches/README.md` - Benchmark-specific documentation
  - `MIGRATION.md` - Detailed migration documentation
  - `CONTRIBUTING.md` - Contributor guidelines
  - `CHANGELOG.md` - This file
  - `.gitignore` - Git ignore patterns

- **CI/CD**:
  - GitHub Actions workflow for running benchmarks
  - Automated result archiving
  - PR comment integration for benchmark results
  - Quick benchmark checks for CI

### Changed

- **Package name**: Changed from `benches` to `hydro-timely-differential-benchmarks` for clarity
- **Dependencies**: Migrated from local path dependencies to git-based dependencies
  - Before: `dfir_rs = { path = "../dfir_rs" }`
  - After: `dfir_rs = { git = "https://..." }`
- **Version**: Updated from 0.0.0 to 0.1.0
- **Edition**: Updated to 2024 edition
- **Documentation**: Significantly expanded with comprehensive guides

### Migration Details

- **Source**: bigweaver-agent-canary-hydro-zeta repository
- **Source Commit**: 484e6fdd (last commit before benchmark removal)
- **Migration Method**: Git extraction of historical files
- **Functionality**: 100% preserved - all performance comparison capabilities maintained

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── .github/
│   └── workflows/
│       └── benchmarks.yml          # CI/CD for benchmarks
├── benches/
│   ├── benches/
│   │   ├── *.rs                    # 12 benchmark files
│   │   ├── *.txt                   # 3 data files
│   │   └── .gitignore
│   ├── Cargo.toml                  # Package configuration
│   ├── README.md                   # Benchmark docs
│   └── build.rs                    # Build script
├── Cargo.toml                      # Workspace configuration
├── README.md                       # Main documentation
├── MIGRATION.md                    # Migration details
├── CONTRIBUTING.md                 # Contributor guide
├── CHANGELOG.md                    # This file
└── .gitignore                      # Git ignore patterns
```

### Verification

All benchmarks verified to:
- ✅ Compile successfully
- ✅ Include all original functionality
- ✅ Support Hydroflow, Timely, and Differential Dataflow comparisons
- ✅ Generate HTML reports
- ✅ Work with Criterion.rs features (baseline, sampling, etc.)

### Rationale

This repository was created to:
1. **Isolate dependencies** - Keep comparative framework dependencies separate
2. **Improve build performance** - Main Hydroflow repo builds faster
3. **Enable independent updates** - Update benchmarks without affecting core code
4. **Maintain functionality** - Preserve all performance comparison capabilities
5. **Improve maintenance** - Clear separation of concerns

### Breaking Changes

None - this is a new repository. For users of the main Hydroflow repository:
- Benchmarks are no longer in the main repo
- To run comparisons, use this repository instead
- All functionality is preserved, just in a different location

### Dependencies

#### Hydroflow (Git)
- `dfir_rs` - Core Hydroflow library with debugging features
- `sinktools` - Sink utilities

#### Comparison Frameworks
- `timely` (v0.13.0-dev.1) - Timely Dataflow
- `differential-dataflow` (v0.13.0-dev.1) - Differential Dataflow

#### Infrastructure
- `criterion` (v0.5.0) - Benchmarking framework
- `tokio` (v1.29.0) - Async runtime
- `futures` (v0.3) - Futures utilities
- `rand` (v0.8.0) - Random number generation
- `rand_distr` (v0.4.3) - Random distributions
- `seq-macro` (v0.2.0) - Sequence macros
- `static_assertions` (v1.0.0) - Compile-time assertions
- `nameof` (v1.0.0) - Name extraction

### Known Issues

None at this time.

### Future Plans

Potential enhancements for future releases:
- [ ] Add more benchmark categories
- [ ] Implement performance regression detection
- [ ] Add memory profiling benchmarks
- [ ] Create historical performance tracking
- [ ] Add benchmarks for additional dataflow frameworks
- [ ] Integrate with automated performance dashboards

### Credits

- Original benchmarks created by the Hydroflow team
- Migration performed as part of repository reorganization
- All original functionality and test cases preserved

### License

Apache-2.0 - Same as the main Hydroflow project

### Related Repositories

- **Main Hydroflow**: bigweaver-agent-canary-hydro-zeta
- **This Repository**: bigweaver-agent-canary-zeta-hydro-deps

---

## Version History

### [0.1.0] - 2024-11-21
Initial release with complete benchmark suite migrated from main repository.

---

**Note**: This changelog will be updated with each significant change to the repository. For detailed commit history, see the git log.
