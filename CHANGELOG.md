# Changelog

All notable changes to the bigweaver-agent-canary-zeta-hydro-deps repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added - 2024-11-22

#### Benchmark Files
- Added `arithmetic.rs` - Pipeline arithmetic operations comparison with timely
- Added `fan_in.rs` - Fan-in pattern benchmarks with timely
- Added `fan_out.rs` - Fan-out pattern benchmarks with timely
- Added `fork_join.rs` - Fork-join pattern benchmarks with timely
- Added `identity.rs` - Identity operation benchmarks with timely
- Added `join.rs` - Join operation benchmarks with timely
- Added `upcase.rs` - Uppercase transformation benchmarks with timely
- Added `reachability.rs` - Graph reachability benchmarks (timely, differential-dataflow, and dfir_rs)

#### Data Files
- Added `reachability_edges.txt` - Graph edge data for reachability benchmark (532KB)
- Added `reachability_reachable.txt` - Expected reachable nodes for reachability benchmark (38KB)

#### Configuration Files
- Added `Cargo.toml` - Workspace configuration with optimized release profile
- Added `benches/Cargo.toml` - Benchmark package configuration with all dependencies
- Added `benches/build.rs` - Build script for benchmark compilation

#### Documentation
- Added `README.md` - Comprehensive repository documentation
- Added `QUICKSTART.md` - Quick start guide for new users
- Added `TESTING_GUIDE.md` - Complete testing and verification guide
- Added `CHANGELOG.md` - This changelog file
- Updated `benches/README.md` - Detailed benchmark documentation

#### Scripts and Tools
- Added `run_comparisons.sh` - Helper script for running performance comparisons with various options

#### Dependencies
- Added `timely-master` v0.13.0-dev.1 - Timely dataflow system
- Added `differential-dataflow-master` v0.13.0-dev.1 - Differential dataflow system
- Added `criterion` v0.5.0 - Benchmark framework with async support and HTML reports
- Added local path dependencies to main repository:
  - `dfir_rs` - Hydro's dataflow implementation
  - `sinktools` - Helper utilities

### Changed - 2024-11-22

- **Dependency References:** Changed from git dependencies to local path dependencies for `dfir_rs` and `sinktools` to enable local development and performance comparisons
- **Repository Metadata:** Updated workspace package information with proper repository URL, homepage, and documentation links

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── README.md                           # Main documentation
├── QUICKSTART.md                       # Quick start guide
├── TESTING_GUIDE.md                    # Testing documentation
├── CHANGELOG.md                        # This file
├── run_comparisons.sh                  # Benchmark runner script
└── benches/
    ├── Cargo.toml                      # Benchmark package configuration
    ├── README.md                       # Benchmark documentation
    ├── build.rs                        # Build script
    └── benches/
        ├── arithmetic.rs               # Arithmetic benchmark
        ├── fan_in.rs                   # Fan-in benchmark
        ├── fan_out.rs                  # Fan-out benchmark
        ├── fork_join.rs                # Fork-join benchmark
        ├── identity.rs                 # Identity benchmark
        ├── join.rs                     # Join benchmark
        ├── upcase.rs                   # Upcase benchmark
        ├── reachability.rs             # Reachability benchmark
        ├── reachability_edges.txt      # Graph data
        └── reachability_reachable.txt  # Expected results
```

## Purpose

This repository was created to separate timely and differential-dataflow benchmark dependencies from the main Hydro repository while maintaining the ability to perform comprehensive performance comparisons.

## Benefits

- **Clean Dependencies:** Main repository no longer needs timely/differential-dataflow
- **Reduced Build Time:** Main repository builds faster
- **Independent Execution:** Benchmarks can run without affecting main repository
- **Maintained Capability:** Full performance comparison functionality preserved
- **Better Organization:** Clear separation of internal vs comparison benchmarks

## Migration Notes

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta` repository on 2024-11-22. For detailed migration information, see:
- `REMOVAL_SUMMARY.md` in main repository
- `MIGRATION_NOTES.md` in main repository
- `CHANGES_README.md` in main repository

## Usage Examples

### Run All Benchmarks
```bash
cargo bench -p benches-timely-differential
```

### Run Specific Benchmark
```bash
cargo bench -p benches-timely-differential --bench reachability
```

### Quick Mode
```bash
cargo bench -p benches-timely-differential -- --quick
```

### Filter by Implementation
```bash
cargo bench -p benches-timely-differential --bench reachability -- dfir
```

### Using Helper Script
```bash
./run_comparisons.sh --quick
./run_comparisons.sh --bench reachability --filter timely
./run_comparisons.sh --save-baseline
```

## Performance Comparison Capabilities

All benchmarks support performance comparisons between:
- Hydro (dfir_rs) - Multiple variants where applicable
- Timely Dataflow
- Differential Dataflow (for applicable benchmarks)

Results are generated in HTML format using Criterion and can be viewed in `target/criterion/report/index.html`.

## Future Enhancements

Potential future additions:
- Additional benchmark patterns
- CI/CD integration for automated performance tracking
- Performance regression detection
- Benchmark result storage and historical tracking
- Cross-version performance comparisons
- Memory usage profiling
- Throughput measurements

## References

- Main Repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion: https://bheisler.github.io/criterion.rs/book/

## Contact

For questions or issues:
- Review documentation in this repository
- Check main repository documentation
- Open an issue in the appropriate repository

---

**Note:** This repository maintains benchmarks that reference the main Hydro repository via local path dependencies. Ensure the main repository is checked out at `../bigweaver-agent-canary-hydro-zeta` for proper functionality.
