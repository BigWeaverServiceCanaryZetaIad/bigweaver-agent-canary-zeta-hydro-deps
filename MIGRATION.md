# Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated benchmark repository.

## Migration Date

November 21, 2024

## Source Repository

- **Repository**: bigweaver-agent-canary-hydro-zeta
- **Original Path**: `/benches`
- **Last Commit with Benchmarks**: 9c5c622e^ (parent of removal commit)

## What Was Migrated

### Complete Benchmark Suite

All 19 files from the original `/benches` directory were transferred:

#### Configuration Files (4 files)
1. `Cargo.toml` - Package configuration with all dependencies
2. `README.md` - Benchmark execution instructions
3. `build.rs` - Build script for generated code
4. `.gitignore` - Git ignore patterns

#### Benchmark Files (12 files)
1. `arithmetic.rs` - Arithmetic operations benchmark
2. `fan_in.rs` - Fan-in pattern benchmark
3. `fan_out.rs` - Fan-out pattern benchmark
4. `fork_join.rs` - Fork-join pattern benchmark
5. `futures.rs` - Async/futures benchmark
6. `identity.rs` - Identity/baseline benchmark
7. `join.rs` - Join operations benchmark
8. `micro_ops.rs` - Micro-operations benchmark
9. `reachability.rs` - Graph reachability benchmark
10. `symmetric_hash_join.rs` - Hash join benchmark
11. `upcase.rs` - String transformation benchmark
12. `words_diamond.rs` - Diamond pattern benchmark

#### Data Files (3 files)
1. `reachability_edges.txt` - Graph edge data (~533 KB)
2. `reachability_reachable.txt` - Expected reachable nodes (~38 KB)
3. `words_alpha.txt` - English word list (~3.9 MB)

## Changes Made During Migration

### 1. Dependency Resolution

**Original dependencies (path-based):**
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**New dependencies (published/git-based):**
```toml
# Published on crates.io
dfir_rs = { version = "0.14.0", features = [ "debugging"] }

# Git dependency from hydro repository
sinktools = { git = "https://github.com/hydro-project/hydro", version = "0.0.1" }
```

### 2. Workspace Configuration

Created a new workspace `Cargo.toml` at repository root:
- Edition: 2021
- License: Apache-2.0
- Includes all necessary workspace lints

### 3. Documentation Enhancements

**New files created:**
- `README.md` - Comprehensive repository documentation
- `MIGRATION.md` - This file, documenting the migration process

**Updated files:**
- `benches/Cargo.toml` - Added migration comments
- `benches/README.md` - Retained from original

### 4. Preserved Functionality

All original benchmark functionality was preserved:
- All 12 benchmark targets remain functional
- Build script for fork_join generation maintained
- Test data files included
- Performance comparison capabilities retained

## Dependency Versions

### Unchanged Dependencies
```toml
criterion = "0.5.0"
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
futures = "0.3"
nameof = "1.0.0"
rand = "0.8.0"
rand_distr = "0.4.3"
seq-macro = "0.2.0"
static_assertions = "1.0.0"
tokio = "1.29.0"
```

### Changed Dependencies
- `dfir_rs`: Changed from path to version 0.14.0 (latest published)
- `sinktools`: Changed from path to git dependency

## Verification Steps

To verify the migration was successful:

### 1. Check Benchmark Compilation
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo check -p benches
```

### 2. Run Individual Benchmarks
```bash
# Test a simple benchmark
cargo bench -p benches --bench identity

# Test a timely benchmark
cargo bench -p benches --bench arithmetic

# Test differential-dataflow benchmark
cargo bench -p benches --bench reachability
```

### 3. Verify All Benchmarks
```bash
cargo bench -p benches
```

## Compatibility Notes

### Required Rust Version
The benchmarks require Rust 2021 edition or later due to:
- Use of `LazyLock` in reachability benchmarks
- Async/await syntax in futures benchmarks

### Operating System Compatibility
Benchmarks are platform-independent and should work on:
- Linux
- macOS
- Windows

### Performance Considerations
- Large data files (words_alpha.txt) are embedded using `include_bytes!`
- Reachability benchmark requires ~4.5 MB of memory for test data
- Criterion generates HTML reports in `target/criterion/`

## Integration with Original Repository

### Reference to Original
The benchmarks maintain compatibility with the original hydro project:
- Uses published `dfir_rs` crate (v0.14.0)
- References `sinktools` from official hydro repository
- Maintains same benchmark structure and patterns

### Future Updates
To update dependencies:

1. Check for new dfir_rs versions on crates.io
2. Update Cargo.toml version numbers
3. Run `cargo update` to refresh dependencies
4. Verify benchmarks still compile and run

## Known Issues and Limitations

### 1. Sinktools Dependency
Currently uses git dependency. Future options:
- Wait for sinktools to be published to crates.io
- Vendor sinktools code if needed
- Use specific git revision for reproducibility

### 2. Timely/Differential Versions
Using development versions (`0.13.0-dev.1`):
- May need updates as new versions release
- Consider pinning to specific git revisions for stability

## Restoration from Git History

If needed, original files can be retrieved from source repository:

```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta

# View commit history
git log --all --oneline -- benches/

# Restore from specific commit (9c5c622e^)
git show 9c5c622e^:benches/Cargo.toml
git show 9c5c622e^:benches/benches/reachability.rs

# Or checkout entire directory
git checkout 9c5c622e^ -- benches/
```

## Testing Strategy

### Smoke Tests
1. Verify compilation: `cargo check`
2. Verify individual benchmarks: `cargo bench --bench <name> -- --test`
3. Run quick iterations: `cargo bench -- --quick`

### Full Validation
1. Run complete benchmark suite: `cargo bench`
2. Review generated HTML reports
3. Compare results with historical baselines if available

### Continuous Integration
Consider adding:
- Automated compilation checks
- Benchmark regression detection
- Performance tracking over time

## Related Documentation

In the source repository (`bigweaver-agent-canary-hydro-zeta`):
- `BENCHMARK_FILES_REMOVED.md` - Complete inventory of removed files
- `REMOVAL_SUMMARY.md` - Why benchmarks were removed
- `VERIFICATION_REPORT.md` - Impact analysis of removal

## Contact and Support

For questions about:
- **Benchmark implementation**: Refer to inline code comments
- **Hydro/DFIR functionality**: See [Hydro documentation](https://github.com/hydro-project/hydro)
- **Timely/Differential**: See respective project documentation

## Changelog

### 2024-11-21 - Initial Migration
- Transferred all 19 benchmark files
- Updated dependencies for standalone operation
- Created workspace configuration
- Added comprehensive documentation
- Verified compilation and basic functionality
