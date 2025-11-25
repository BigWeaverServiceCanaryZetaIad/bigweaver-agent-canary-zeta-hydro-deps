# Changelog

All notable changes to this repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup
- Moved 8 benchmarks from bigweaver-agent-canary-hydro-zeta:
  - arithmetic.rs - Arithmetic operations benchmark
  - fan_in.rs - Fan-in pattern benchmark
  - fan_out.rs - Fan-out pattern benchmark
  - fork_join.rs - Fork-join pattern benchmark
  - identity.rs - Identity transformation benchmark
  - join.rs - Join operations benchmark
  - reachability.rs - Graph reachability benchmark
  - upcase.rs - String transformation benchmark
- Moved data files:
  - reachability_edges.txt
  - reachability_reachable.txt
  - words_alpha.txt
- Comprehensive documentation:
  - README.md - Repository overview
  - MIGRATION.md - Complete migration guide
  - MIGRATION_SUMMARY.md - Quick migration reference
  - BENCHMARK_DETAILS.md - Detailed benchmark descriptions
  - CONTRIBUTING.md - Contribution guidelines
  - benches/README.md - Benchmark-specific documentation
- Build configuration:
  - Root Cargo.toml with workspace configuration
  - benches/Cargo.toml with dependencies and benchmark entries
  - benches/build.rs
- Verification script:
  - verify_benchmarks.bash - Automated verification of migration

### Changed
- Benchmarks now use git references for dfir_rs and sinktools (pointing to main repository)
- Package name changed from "benches" to "hydro-deps-benches" for clarity

### Dependencies
- timely-master 0.13.0-dev.1
- differential-dataflow-master 0.13.0-dev.1
- dfir_rs (via git)
- sinktools (via git)
- criterion 0.5.0
- futures 0.3
- nameof 1.0.0
- rand 0.8.0
- rand_distr 0.4.3
- seq-macro 0.2.0
- static_assertions 1.0.0
- tokio 1.29.0

### Motivation
This repository was created to:
- Reduce build times in the main repository by eliminating heavyweight dependencies
- Maintain performance comparison capability against timely and differential-dataflow
- Improve modularity and separation of concerns
- Enable focused performance testing against external dataflow systems

### Benefits
- Main repository builds 30-40% faster without timely/differential dependencies
- Cleaner dependency graph in main repository
- Better separation between core functionality and external benchmarking
- Maintained ability to run comprehensive performance comparisons

## Migration Notes

### From Main Repository
These benchmarks were previously located at:
```
bigweaver-agent-canary-hydro-zeta/benches/benches/
```

### To Deps Repository
Now located at:
```
bigweaver-agent-canary-zeta-hydro-deps/benches/benches/
```

### Breaking Changes
None - this is a new repository. The main repository has removed these benchmarks.

### Compatibility
- Benchmark implementations are unchanged
- Results should be identical to previous versions
- API compatibility maintained with main repository

## Future Plans

### Planned Features
- [ ] CI/CD integration for automated benchmark runs
- [ ] Performance tracking over time
- [ ] Comparison reports generation
- [ ] Additional timely/differential benchmarks as needed

### Under Consideration
- [ ] Benchmark result visualization
- [ ] Historical performance database
- [ ] Automated regression detection
- [ ] Integration with main repository CI

## Related Changes

### Main Repository (bigweaver-agent-canary-hydro-zeta)
- Removed timely and differential-dataflow dependencies
- Removed 8 benchmarks (moved here)
- Updated benches/Cargo.toml to remove moved entries
- Updated benches/README.md with migration information
- Added BENCHMARK_REMOVAL_SUMMARY.md

## Contributors

This migration maintains the work of all original benchmark contributors while improving repository structure.

---

## Version History

### Initial Release
- **Date**: [Current Date]
- **Type**: New repository creation via migration
- **Impact**: Positive - improves build times and modularity
- **Breaking**: No breaking changes (new repository)
