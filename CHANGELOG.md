# Changelog

All notable changes to the bigweaver-agent-canary-zeta-hydro-deps benchmark suite will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive documentation suite
  - BENCHMARKS.md with detailed benchmark descriptions
  - SETUP.md with installation and usage guide
  - CONTRIBUTING.md with contribution guidelines
  - Enhanced README.md with quick start and overview
- Development tooling
  - Makefile with convenient build and test commands
  - .criterion.toml for benchmark configuration
  - GitHub Actions workflows for CI/CD
- Comparison and analysis tools
  - Enhanced compare_benchmarks.sh script
  - Performance tracking capabilities
  - Automated regression detection

### Changed
- README.md enhanced with comprehensive information
- Documentation reorganized for better discoverability

## [0.1.0] - Initial Release

### Added
- Core benchmark suite with 8 benchmarks:
  - arithmetic.rs - Sequential arithmetic operations
  - fan_in.rs - Multiple inputs to single output
  - fan_out.rs - Single input to multiple outputs
  - fork_join.rs - Fork-join dataflow patterns
  - identity.rs - Identity/passthrough operations
  - join.rs - Hash join between streams
  - reachability.rs - Graph reachability algorithm
  - upcase.rs - String transformation operations
- Timely dataflow implementations for all benchmarks
- Differential dataflow implementation for reachability
- Baseline implementations (raw, iter, pipeline) for comparison
- Test data files for reachability benchmark
- Cargo workspace configuration
- Dependencies:
  - criterion 0.5.0 (benchmarking framework)
  - timely-master 0.13.0-dev.1
  - differential-dataflow-master 0.13.0-dev.1
  - Supporting dependencies (futures, rand, etc.)
- Basic documentation:
  - Repository README
  - Benchmark README
  - Comparison script

### Repository Structure
- Separated from bigweaver-agent-canary-hydro-zeta repository
- Clean dependency isolation
- Dedicated benchmark crate structure
- Workspace-based organization

### Performance Comparison
- Cross-repository comparison support
- Criterion.rs integration for HTML reports
- Consistent benchmark naming for easy comparison
- Comparison script for automated workflows

## Migration Notes

### From Main Repository

This repository was created by migrating timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository. The migration included:

1. **Moved benchmarks**: 8 benchmark files + 2 data files
2. **Removed dependencies**: Cleaned dfir_rs (Hydroflow) implementations from migrated benchmarks
3. **Maintained baselines**: Kept raw/iter/pipeline baseline implementations for comparison
4. **Created infrastructure**: New workspace, documentation, and tooling

### Benefits of Separation

- **Build time improvement**: Main repository no longer compiles timely/differential dependencies
- **Reduced binary size**: Smaller artifacts in main repository
- **Cleaner dependencies**: No dependency conflicts between frameworks
- **Maintained comparability**: Full performance comparison capabilities retained
- **Better organization**: Clear separation between Hydroflow and timely/differential benchmarks

## Benchmark Evolution

### arithmetic.rs
- **v0.1.0**: Initial implementation with timely + baselines
- Multiple map operations (20 sequential ops)
- 1M integers processed
- Variants: timely, raw, iter, iter-collect, pipeline

### fan_in.rs  
- **v0.1.0**: Initial implementation
- N→1 dataflow pattern
- Configurable number of inputs
- Variants: timely, raw

### fan_out.rs
- **v0.1.0**: Initial implementation
- 1→N dataflow pattern
- Configurable number of outputs
- Variants: timely, raw

### fork_join.rs
- **v0.1.0**: Initial implementation
- Fork-join pattern with merge
- Variants: timely, raw

### identity.rs
- **v0.1.0**: Initial implementation
- Minimal overhead benchmark
- Variants: timely, raw

### join.rs
- **v0.1.0**: Initial implementation
- Hash join between two streams
- 10K tuples per side
- Variants: timely, raw

### reachability.rs
- **v0.1.0**: Initial implementation
- Graph reachability algorithm
- Both timely and differential implementations
- Real-world graph data
- Variants: timely, differential, raw

### upcase.rs
- **v0.1.0**: Initial implementation
- String transformation benchmark
- Allocation-heavy workload
- Variants: timely, raw

## Dependencies

### Current Versions
- Rust: 1.70+ required
- criterion: 0.5.0
- timely: 0.13.0-dev.1 (package: timely-master)
- differential-dataflow: 0.13.0-dev.1 (package: differential-dataflow-master)

### Dependency Updates
Track major dependency updates here.

## Performance Tracking

### Baseline Performance (Example)
These are example baseline metrics - actual performance varies by hardware:

| Benchmark | Timely | Raw | Speedup |
|-----------|--------|-----|---------|
| arithmetic | ~45ms | ~30ms | 1.5x |
| identity | ~20ms | ~15ms | 1.3x |
| join | ~50ms | ~40ms | 1.25x |
| reachability (timely) | ~100ms | ~80ms | 1.25x |
| reachability (diff) | ~90ms | ~80ms | 1.1x |

*Note: These are illustrative values. Run benchmarks on your hardware for accurate measurements.*

## Known Issues

### Current
- None reported

### Resolved
- None (initial release)

## Future Plans

### Planned Features
- [ ] Additional benchmarks for complex patterns
- [ ] Memory profiling integration
- [ ] Distributed benchmark support
- [ ] Automated regression detection
- [ ] Performance history tracking
- [ ] Cross-platform benchmarking (Windows, macOS, Linux)
- [ ] GPU-accelerated baseline comparisons

### Under Consideration
- [ ] Real-time streaming benchmarks
- [ ] State management benchmarks
- [ ] Fault tolerance benchmarks
- [ ] Network overhead benchmarks

## Versioning Strategy

This project uses [Semantic Versioning](https://semver.org/):

- **MAJOR** version: Breaking changes to benchmark APIs or structure
- **MINOR** version: New benchmarks or features
- **PATCH** version: Bug fixes, documentation updates, performance improvements

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on contributing to this benchmark suite.

## Links

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)

---

## Legend

- **Added**: New features or benchmarks
- **Changed**: Changes to existing functionality
- **Deprecated**: Features that will be removed in future versions
- **Removed**: Deleted features or files
- **Fixed**: Bug fixes
- **Security**: Security-related changes
