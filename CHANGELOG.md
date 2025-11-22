# Changelog

All notable changes to the Hydro Dependencies Benchmarks repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial migration of timely and differential-dataflow benchmarks from main repository
- Comprehensive README with setup and usage instructions
- PERFORMANCE_COMPARISON.md with detailed methodology
- QUICK_START.md for fast onboarding
- CONTRIBUTING.md with contribution guidelines
- benches/README.md documenting individual benchmarks
- All benchmark implementations:
  - arithmetic.rs: Arithmetic pipeline benchmarks
  - fan_in.rs: Fan-in pattern benchmarks
  - fan_out.rs: Fan-out pattern benchmarks
  - fork_join.rs: Fork-join pattern benchmarks
  - futures.rs: Futures-based benchmarks
  - identity.rs: Identity operation benchmarks
  - join.rs: Join operation benchmarks
  - micro_ops.rs: Micro-operations benchmarks
  - reachability.rs: Graph reachability benchmarks
  - symmetric_hash_join.rs: Symmetric hash join benchmarks
  - upcase.rs: String uppercase benchmarks
  - words_diamond.rs: Words diamond pattern benchmarks
- Test data files:
  - words_alpha.txt: 370K word dictionary
  - reachability_edges.txt: Graph edge data
  - reachability_reachable.txt: Expected reachability results

### Changed
- Cargo.toml updated to work as standalone package (not workspace member)
- Dependencies reference main repository via git
- Removed pusherator dependency (was internal and removed from main repo)
- Commented out pusherator-dependent benchmark code

### Notes
- This repository maintains benchmarks that compare DFIR/Hydro with external frameworks
- Separated from main repository to prevent dependency bloat
- Follows team's architectural principle of clean separation of concerns

## Migration Details

### Origin
These benchmarks were originally in the `benches/` directory of the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

### Why Moved
1. **Dependency Isolation**: Keep timely/differential-dataflow dependencies out of main codebase
2. **Build Performance**: Main repository builds faster without benchmark dependencies
3. **Clear Separation**: Distinguish core functionality from comparative analysis
4. **Maintainability**: Easier to maintain benchmark infrastructure independently

### What's Preserved
- ✅ All benchmark implementations
- ✅ Test data files
- ✅ Performance comparison functionality
- ✅ Ability to execute independently
- ✅ Historical benchmark intent and design

### What Changed
- Cargo.toml adapted for standalone use
- Git dependencies instead of path dependencies
- Pusherator-based benchmarks commented out (internal API)
- Enhanced documentation for standalone use

## Future Plans

### Planned Enhancements
- [ ] CI/CD integration for automated benchmark runs
- [ ] Historical performance tracking system
- [ ] Benchmark result visualization dashboard
- [ ] Additional framework comparisons (Flink, Spark Streaming, etc.)
- [ ] More real-world application benchmarks
- [ ] Performance regression detection
- [ ] Benchmark suite for different hardware configurations

### Framework Updates
- [ ] Update to Timely 0.14 when released
- [ ] Update to Differential Dataflow 0.14 when released
- [ ] Track DFIR/Hydro API changes

## How to Contribute

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines on:
- Adding new benchmarks
- Improving existing benchmarks
- Reporting issues
- Submitting pull requests

## Version History

### Version 0.1.0 (Unreleased)
Initial release with all migrated benchmarks from main repository.

---

For changes to the main DFIR/Hydro project, see the [main repository changelog](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CHANGELOG.md).
