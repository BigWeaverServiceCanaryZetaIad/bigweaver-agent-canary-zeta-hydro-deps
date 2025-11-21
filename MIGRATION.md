# Benchmark Migration Documentation

## Overview

This document describes the migration of Timely Dataflow and Differential Dataflow benchmarks from the main Hydroflow repository (`bigweaver-agent-canary-hydro-zeta`) to this dedicated benchmarks repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

Migrated: 2024

## Rationale

The benchmarks were moved to a separate repository for several reasons:

1. **Repository Focus** - Keep the main Hydroflow repository focused on core functionality
2. **Dependency Isolation** - Isolate timely and differential-dataflow dependencies
3. **Build Performance** - Reduce build times for the main repository
4. **Independent Updates** - Allow benchmark framework updates without affecting core codebase
5. **Maintenance Clarity** - Clear separation between implementation and comparative analysis

## What Was Migrated

### Files Transferred

All files from the `benches/` directory in the source repository:

#### Root Level Files
- `Cargo.toml` - Package configuration with all dependencies
- `README.md` - Benchmark usage documentation
- `build.rs` - Build script for generating benchmark code

#### Benchmark Source Files (`benches/benches/`)
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `futures.rs` - Futures/async benchmark
- `identity.rs` - Identity/passthrough benchmark
- `join.rs` - Join operations benchmark
- `micro_ops.rs` - Micro-operations benchmark
- `reachability.rs` - Graph reachability benchmark
- `symmetric_hash_join.rs` - Symmetric hash join benchmark
- `upcase.rs` - String transformation benchmark
- `words_diamond.rs` - Diamond pattern benchmark

#### Data Files (`benches/benches/`)
- `reachability_edges.txt` - Graph edges (~521 KB)
- `reachability_reachable.txt` - Expected reachable nodes (~38 KB)
- `words_alpha.txt` - English word list (~3.7 MB)
- `.gitignore` - Git ignore patterns

**Total:** 12 Rust source files, 3 data files, 4 configuration files

### Dependencies Migrated

#### Hydroflow Dependencies
```toml
dfir_rs = { git = "...", features = [ "debugging" ] }
sinktools = { git = "...", version = "^0.0.1" }
```

#### Timely and Differential Dataflow
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

#### Supporting Dependencies
```toml
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
futures = "0.3"
nameof = "1.0.0"
rand = "0.8.0"
rand_distr = "0.4.3"
seq-macro = "0.2.0"
static_assertions = "1.0.0"
tokio = { version = "1.29.0", features = [ "rt-multi-thread" ] }
```

## Changes Made During Migration

### 1. Package Configuration Updates

**Original (`benches/Cargo.toml`):**
```toml
name = "benches"
version = "0.0.0"
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**Updated:**
```toml
name = "hydro-timely-differential-benchmarks"
version = "0.1.0"
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

### 2. Workspace Configuration

Created new workspace `Cargo.toml` at repository root:
```toml
[workspace]
resolver = "2"
members = ["benches"]

[workspace.package]
edition = "2024"
repository = "..."
license = "Apache-2.0"

[workspace.lints.rust]
# ... (lints configuration)
```

### 3. Documentation Updates

- Updated README.md with comprehensive usage instructions
- Updated benches/README.md with benchmark-specific details
- Created MIGRATION.md (this document)
- Added extensive documentation about benchmark usage and maintenance

### 4. Dependency Resolution

Changed from local path dependencies to git dependencies:
- **Before:** Local paths (`path = "../dfir_rs"`)
- **After:** Git URLs pointing to the main Hydroflow repository

This ensures the benchmarks always use a specific version of Hydroflow for consistent comparisons.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── README.md                           # Main repository documentation
├── MIGRATION.md                        # This file
└── benches/                            # Benchmark crate
    ├── Cargo.toml                      # Package configuration
    ├── README.md                       # Benchmark-specific docs
    ├── build.rs                        # Build script
    └── benches/                        # Benchmark source files
        ├── *.rs                        # Benchmark implementations
        └── *.txt                       # Data files
```

## Functionality Preserved

### Performance Comparison

All performance comparison functionality has been retained:

1. **Framework Comparisons** - Direct comparison between Hydroflow, Timely, and Differential
2. **Benchmark Metrics** - Execution time, throughput, memory usage
3. **Statistical Analysis** - Criterion.rs provides confidence intervals and trend analysis
4. **HTML Reports** - Visual performance comparison reports
5. **Baseline Comparisons** - Track performance over time

### Benchmark Categories

All benchmark categories are preserved:

- ✅ Basic operations (arithmetic, identity, micro_ops)
- ✅ Control flow patterns (fan_in, fan_out, fork_join)
- ✅ Data operations (join, symmetric_hash_join, reachability)
- ✅ String processing (upcase, words_diamond)
- ✅ Async operations (futures)

### Data Files

All benchmark data files are included:
- ✅ Graph data for reachability benchmarks
- ✅ Word lists for string processing benchmarks
- ✅ All test fixtures preserved

## Usage Changes

### Before Migration

In the main Hydroflow repository:
```bash
cargo bench -p benches
cargo bench -p benches --bench reachability
```

### After Migration

In this repository:
```bash
cargo bench -p hydro-timely-differential-benchmarks
cargo bench -p hydro-timely-differential-benchmarks --bench reachability
```

The functionality is identical, only the package name has changed.

## Git History

The benchmark files were extracted from commit `484e6fdd` in the source repository, which represents the last commit before the benchmark removal.

To view the original history:
```bash
# In the source repository
cd /path/to/bigweaver-agent-canary-hydro-zeta
git log --all --full-history -- benches/
```

## Verification

### Build Verification

To verify the migration was successful:

```bash
# Check that it builds
cargo check -p hydro-timely-differential-benchmarks

# Run a sample benchmark
cargo bench -p hydro-timely-differential-benchmarks --bench identity -- --sample-size 10
```

### Expected Output

Successful build should show:
```
   Compiling hydro-timely-differential-benchmarks v0.1.0
    Finished release [optimized] target(s) in XX.XXs
```

Successful benchmark should show:
```
Running benches/identity.rs
identity/hydroflow     time:   [XXX.XX µs XXX.XX µs XXX.XX µs]
identity/timely        time:   [XXX.XX µs XXX.XX µs XXX.XX µs]
```

## Maintenance

### Updating Hydroflow Dependency

To update to a specific commit or branch:

```toml
[dev-dependencies]
dfir_rs = { git = "...", rev = "abc123", features = [ "debugging" ] }
# or
dfir_rs = { git = "...", branch = "main", features = [ "debugging" ] }
```

### Updating Timely/Differential Dependencies

To update Timely and Differential Dataflow:

```toml
[dev-dependencies]
timely = { package = "timely-master", version = "0.14.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.14.0-dev.1" }
```

Or use stable releases:
```toml
timely = "0.12"
differential-dataflow = "0.12"
```

### Adding New Benchmarks

1. Create new benchmark file in `benches/benches/`
2. Add `[[bench]]` section to `Cargo.toml`
3. Follow existing patterns for framework comparisons
4. Document in README.md

## Troubleshooting

### Common Issues

**Issue: Git authentication fails**
```bash
# Solution: Ensure git credentials are configured
git config --global credential.helper store
```

**Issue: Dependency resolution fails**
```bash
# Solution: Update Cargo.lock
cargo update -p hydro-timely-differential-benchmarks
```

**Issue: Build fails with version conflicts**
```bash
# Solution: Clean and rebuild
cargo clean
cargo build -p hydro-timely-differential-benchmarks
```

## Future Enhancements

Potential improvements for this repository:

1. **CI/CD Integration** - Automated benchmark runs on commits
2. **Performance Tracking** - Historical performance database
3. **Comparison Reports** - Automated generation of comparison documents
4. **Additional Frameworks** - Benchmarks for other dataflow systems
5. **Profiling Integration** - Memory and CPU profiling alongside benchmarks

## Related Documentation

### In Main Hydroflow Repository
- `BENCHMARK_REMOVAL_DOCUMENTATION.md` - Details of what was removed
- `BENCHMARK_RESTORATION_GUIDE.md` - Guide for restoring or recreating benchmarks
- `BENCHMARKS_README.md` - Overview and rationale
- `REMOVAL_SUMMARY.md` - Executive summary

### In This Repository
- `README.md` - Main repository documentation
- `benches/README.md` - Benchmark-specific documentation
- `MIGRATION.md` - This document

## Contact and Support

For questions or issues related to:
- **Benchmark usage**: See README.md
- **Hydroflow functionality**: Refer to main repository
- **Timely/Differential**: See respective documentation
- **Migration issues**: Contact repository maintainers

## Conclusion

This migration successfully:
- ✅ Transferred all benchmark files
- ✅ Preserved all functionality
- ✅ Updated dependencies to use git sources
- ✅ Created comprehensive documentation
- ✅ Maintained performance comparison capabilities
- ✅ Established clear maintenance procedures

The benchmarks are now in a dedicated repository that can be maintained and updated independently of the main Hydroflow codebase while retaining full performance comparison functionality.
