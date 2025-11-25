# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

November 25, 2024

## Rationale

### Why Separate the Benchmarks?

1. **Dependency Isolation**: The timely and differential-dataflow dependencies were only needed for performance comparison benchmarks, not for the core hydro functionality.

2. **Faster Build Times**: Removing these dependencies from the main repository reduces compilation time for the core project.

3. **Cleaner Architecture**: Separation of concerns between core functionality and external performance comparisons.

4. **Better Maintainability**: Benchmarks comparing different frameworks are easier to maintain in a dedicated repository.

5. **Reduced Complexity**: The main repository's dependency tree is simplified, making it easier to reason about and maintain.

## Migrated Files

### Benchmark Source Files (8 files)
- `arithmetic.rs` (7,687 bytes) - Arithmetic operations benchmark
- `fan_in.rs` (3,530 bytes) - Multiple input convergence benchmark
- `fan_out.rs` (3,625 bytes) - Single input to multiple outputs benchmark
- `fork_join.rs` (4,333 bytes) - Complex branching and joining patterns
- `identity.rs` (6,891 bytes) - Identity operation overhead measurement
- `join.rs` (4,484 bytes) - Join operation performance
- `reachability.rs` (13,681 bytes) - Graph reachability analysis
- `upcase.rs` (3,170 bytes) - String transformation benchmark

### Data Files (2 files)
- `reachability_edges.txt` (532,876 bytes) - Edge list for reachability benchmark
- `reachability_reachable.txt` (38,704 bytes) - Expected reachable nodes

### Configuration Files
- `build.rs` (1,050 bytes) - Build script for generating benchmark code
- `Cargo.toml` - Benchmark dependencies and configuration

**Total migrated data**: ~610 KB

## Dependencies Added

### Primary Dependencies
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

### Development Dependencies
```toml
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
dfir_rs = { git = "https://github.com/hydro-project/hydro", features = [ "debugging" ] }
futures = "0.3"
nameof = "1.0.0"
rand = "0.8.0"
rand_distr = "0.4.3"
seq-macro = "0.2.0"
static_assertions = "1.0.0"
tokio = { version = "1.29.0", features = [ "rt-multi-thread" ] }
```

## Repository Structure

### New Structure in hydro-deps
```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                 # Workspace configuration
├── rust-toolchain.toml        # Rust toolchain specification
├── rustfmt.toml              # Formatting configuration
├── clippy.toml               # Linting configuration
├── README.md                 # Repository documentation
├── MIGRATION.md              # This file
├── BENCHMARK_DETAILS.md      # Detailed benchmark documentation
└── benches/
    ├── Cargo.toml            # Benchmark crate configuration
    ├── build.rs              # Build script
    ├── README.md             # Benchmark documentation
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── reachability_edges.txt
        └── reachability_reachable.txt
```

## Changes from Original

### Modified: Cargo.toml
- Changed package name from `benches` to `hydro-deps-benches` for clarity
- Added explicit timely and differential-dataflow dependencies
- Changed dfir_rs path dependency to git dependency (pointing to main hydro repo)
- Updated repository URL to point to this repository

### Retained: All Benchmark Code
- All benchmark source code retained without modifications
- All data files retained in original format
- build.rs script retained without changes

### Added: Documentation
- Comprehensive README.md for the repository
- Detailed MIGRATION.md (this file)
- BENCHMARK_DETAILS.md with benchmark descriptions
- Enhanced benches/README.md with usage instructions

## Impact on Main Repository

### Removed from bigweaver-agent-canary-hydro-zeta
- 8 benchmark source files
- 2 data files
- timely and differential-dataflow dependencies from benches/Cargo.toml
- 8 [[bench]] entries from benches/Cargo.toml

### Retained in bigweaver-agent-canary-hydro-zeta
- 4 pure hydro benchmarks (micro_ops, symmetric_hash_join, words_diamond, futures)
- Core hydro functionality unchanged
- All library code and dependencies

### Benefits
- ✅ Reduced build time (fewer dependencies to compile)
- ✅ Cleaner dependency tree
- ✅ Smaller repository size (~610 KB removed)
- ✅ Maintained performance comparison capability
- ✅ Better separation of concerns

## Running Benchmarks

### In This Repository
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench                           # Run all benchmarks
cargo bench --bench arithmetic        # Run specific benchmark
```

### In Main Repository
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches                # Run core hydro benchmarks
```

## Verification

### Verify benchmarks compile
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check
cargo bench --no-run
```

### Verify benchmarks run
```bash
cargo bench --bench arithmetic -- --test  # Quick test run
cargo bench                                # Full benchmark run
```

## Maintenance

### Updating Benchmarks
1. Make changes to benchmark files in this repository
2. Test with `cargo bench --bench <name>`
3. Update documentation if behavior changes
4. Commit and push changes

### Adding New Benchmarks
1. Add new .rs file to `benches/benches/`
2. Add [[bench]] entry to `benches/Cargo.toml`
3. Update `benches/README.md` with benchmark description
4. Test with `cargo bench --bench <new-name>`

### Syncing with Main Repository
If dfir_rs APIs change:
1. Update the git dependency version in `benches/Cargo.toml`
2. Update benchmark code to match new APIs
3. Test all benchmarks
4. Document any breaking changes

## Related Issues

- Original removal: See `bigweaver-agent-canary-hydro-zeta` repository's `BENCHMARK_REMOVAL_COMPLETED.md`
- Migration task: See task completion summary in main repository

## Questions or Issues

For questions about these benchmarks:
1. Check the README.md and BENCHMARK_DETAILS.md documentation
2. Review the benchmark source code comments
3. Consult the main hydro repository for dfir_rs documentation
4. Check timely-dataflow and differential-dataflow documentation

## Future Considerations

### Potential Enhancements
- Add more comparison benchmarks for other dataflow frameworks
- Create automated performance regression testing
- Set up CI/CD for benchmark validation
- Generate performance comparison reports
- Track historical performance trends

### Maintenance Notes
- Keep dfir_rs dependency synchronized with main repository
- Update timely/differential versions when available
- Review and update benchmarks as frameworks evolve
- Consider adding benchmark variants for different workload sizes

## Acknowledgments

These benchmarks were originally developed as part of the hydro project to evaluate performance characteristics across different dataflow implementations. The migration preserves this valuable comparison capability while improving repository organization.
