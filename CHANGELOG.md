# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup for Hydro benchmarks
- Migrated 12 benchmark implementations from bigweaver-agent-canary-hydro-zeta
  - arithmetic.rs - Arithmetic operation benchmarks
  - fan_in.rs - Many-to-one dataflow patterns
  - fan_out.rs - One-to-many dataflow patterns
  - fork_join.rs - Parallel fork-join patterns
  - futures.rs - Async operations benchmarks
  - identity.rs - Identity transformation overhead
  - join.rs - Two-way join operations
  - micro_ops.rs - Comprehensive microbenchmark suite
  - reachability.rs - Graph reachability with joins
  - symmetric_hash_join.rs - Symmetric hash join performance
  - upcase.rs - String transformation operations
  - words_diamond.rs - Diamond-shaped dataflow patterns
- Test data files (4.4MB total)
  - reachability_edges.txt (521KB)
  - reachability_reachable.txt (38KB)
  - words_alpha.txt (3.7MB)
- Build script (build.rs) for generated benchmarks
- Comprehensive documentation
  - README.md - Repository overview and usage
  - QUICK_START.md - Quick start guide
  - EXAMPLES.md - Detailed benchmark explanations and examples
  - CHANGELOG.md - This file
- Utilities
  - setup.sh - Setup verification script

### Changed
- Updated Cargo.toml to reference dfir_rs and sinktools from main Hydro repository
  - Changed paths from `../dfir_rs` to `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
  - Changed paths from `../sinktools` to `../../bigweaver-agent-canary-hydro-zeta/sinktools`
- Removed workspace configuration, made standalone project
- Updated edition, repository, and license fields to be explicit

### Migration Details

**Date**: November 2025  
**From**: bigweaver-agent-canary-hydro-zeta (commit b417ddd6 and earlier)  
**To**: bigweaver-agent-canary-zeta-hydro-deps  

**Rationale**:
- Reduce dependency footprint in main Hydro repository
- Faster CI/CD builds without heavy benchmark dependencies
- Cleaner separation of concerns
- Optional performance testing
- Independent benchmark development and versioning

**Preserved Functionality**:
- ✅ All 12 benchmark implementations
- ✅ Performance comparison between Hydro, timely-dataflow, and differential-dataflow
- ✅ Test data and fixtures
- ✅ Build scripts and configuration
- ✅ Criterion-based statistical analysis
- ✅ HTML report generation
- ✅ Historical performance tracking

**Dependencies**:
- criterion 0.5.0 - Benchmarking framework
- dfir_rs (from main repo) - Hydro dataflow runtime
- sinktools (from main repo) - Utility tools
- timely-master 0.13.0-dev.1 - Timely-dataflow framework
- differential-dataflow-master 0.13.0-dev.1 - Differential dataflow
- Supporting libraries: futures, rand, tokio, etc.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                    # Main documentation
├── CHANGELOG.md                 # This file
└── benches/                     # Benchmark project
    ├── Cargo.toml               # Project configuration
    ├── README.md                # Benchmark-specific docs
    ├── QUICK_START.md           # Quick start guide
    ├── EXAMPLES.md              # Detailed examples
    ├── setup.sh                 # Setup verification script
    ├── build.rs                 # Build script
    └── benches/                 # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_diamond.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── words_alpha.txt
```

## Usage

### Prerequisites
- Rust toolchain (https://rustup.rs/)
- Both repositories cloned in same parent directory

### Running Benchmarks
```bash
cd benches
./setup.sh              # Verify setup
cargo bench             # Run all benchmarks
cargo bench --bench NAME  # Run specific benchmark
```

### Viewing Results
```bash
open target/criterion/report/index.html
```

## Related Projects

- **bigweaver-agent-canary-hydro-zeta** - Main Hydro repository
  - Contains dfir_rs, sinktools, and other core components
  - See BENCHMARK_MIGRATION.md for migration documentation

## Contributing

When adding new benchmarks:
1. Add benchmark file to `benches/benches/`
2. Register in `Cargo.toml` under `[[bench]]`
3. Include implementations for all frameworks when possible
4. Update documentation (README.md, EXAMPLES.md)
5. Update this CHANGELOG

## License

Apache-2.0

## Authors

Migrated from the Hydro project by the BigWeaver Service team.
Original benchmark implementations by the Hydro project contributors.
