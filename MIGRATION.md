# Migration Guide

This document explains the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated benchmarks repository.

## Overview

**Migration Date**: November 21, 2024

**Reason**: To reduce dependency footprint in the main repository while maintaining complete performance comparison capabilities.

## What Was Moved

### Code
All benchmark implementations comparing DFIR/Hydroflow with timely-dataflow and differential-dataflow:
- 12 benchmark files (arithmetic, fan_in, fan_out, fork_join, futures, identity, join, micro_ops, reachability, symmetric_hash_join, upcase, words_diamond)
- Build scripts and configuration
- Test data files (~4.4MB)

### Dependencies
The following dependencies now reside only in this repository:
- `timely-master` (0.13.0-dev.1)
- `differential-dataflow-master` (0.13.0-dev.1)
- All transitive dependencies

## Repository Structure

### Before Migration (in bigweaver-agent-canary-hydro-zeta)
```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── Cargo.toml
│   ├── README.md
│   ├── build.rs
│   └── benches/
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── ...
│       └── test data files
├── dfir_rs/
├── hydro_lang/
└── ... (other crates)
```

### After Migration (in bigweaver-agent-canary-zeta-hydro-deps)
```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml
├── README.md
├── CONFIGURATION.md
├── MIGRATION.md
├── build.rs
└── benches/
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── ...
    └── test data files
```

## Changes Made

### 1. Repository Configuration
- Created standalone repository with self-contained benchmark code
- Updated `Cargo.toml` to use git dependencies by default
- Added configuration options for local path and published crate dependencies

### 2. Documentation
- Created comprehensive README with setup and usage instructions
- Added CONFIGURATION.md for dependency management
- Created this MIGRATION.md guide
- All documentation includes examples and troubleshooting

### 3. Build Configuration
- Retained original build.rs for fork_join benchmark generation
- Updated package name to "hydro-benchmarks"
- Added rust-toolchain.toml for consistency

## Performance Comparison Functionality

### Retained Capabilities
✅ All benchmark implementations preserved exactly as they were
✅ Performance comparison between DFIR, Timely, and Differential
✅ Statistical analysis via Criterion framework
✅ HTML report generation
✅ Historical performance tracking
✅ All test data files

### How It Works
Each benchmark file contains multiple implementations:
```rust
// DFIR/Hydroflow implementation
fn benchmark_dfir(c: &mut Criterion) {
    dfir_syntax! { /* DFIR code */ }
}

// Timely Dataflow implementation  
fn benchmark_timely(c: &mut Criterion) {
    timely::execute(...) { /* Timely code */ }
}

// Differential Dataflow implementation
fn benchmark_differential(c: &mut Criterion) {
    differential_dataflow::... { /* Differential code */ }
}

criterion_group!(
    benches,
    benchmark_dfir,
    benchmark_timely, 
    benchmark_differential
);
```

This structure ensures apples-to-apples comparison across all three frameworks.

## Usage After Migration

### Running Benchmarks

Same as before:
```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Compare specific frameworks
cargo bench --bench join -- timely
cargo bench --bench join -- differential
```

### Viewing Results

Results are still in `target/criterion/`:
```bash
# Open HTML reports
open target/criterion/report/index.html
```

## For Developers

### If You Previously Ran Benchmarks

**Before** (in main repo):
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

**After** (in dedicated repo):
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### If You're Adding New Benchmarks

1. Clone this repository
2. Add your benchmark file to `benches/`
3. Update `Cargo.toml` [[bench]] sections
4. Follow existing patterns for framework comparisons
5. Update README with new benchmark description

### If You Need to Modify dfir_rs

**Option 1**: Use local path dependencies (see CONFIGURATION.md)
```toml
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

**Option 2**: Make changes in main repo, push, then update this repo:
```bash
# In main repo
git add dfir_rs/...
git commit -m "fix: ..."
git push

# In benchmark repo
cargo update
cargo bench
```

## Benefits of Migration

### For Main Repository
- ✅ Reduced dependency tree (no timely/differential)
- ✅ Faster CI/CD builds
- ✅ Smaller repository size (~4.4MB less)
- ✅ Cleaner focus on core functionality
- ✅ Easier maintenance

### For Benchmark Repository  
- ✅ Independent versioning
- ✅ Isolated performance testing
- ✅ Optional dependency (clone only when needed)
- ✅ Easier to extend with new benchmarks
- ✅ Clear separation of concerns

### For Users
- ✅ Faster main repository builds
- ✅ Optional performance testing
- ✅ Same benchmark functionality
- ✅ Better documentation
- ✅ Flexible configuration options

## Verification

All functionality verified to be working:
- ✅ All 12 benchmarks compile
- ✅ Dependencies resolve correctly
- ✅ Test data files present
- ✅ Build scripts functional
- ✅ Documentation complete

## Rollback Plan

If needed, benchmarks can be restored to main repository:
1. Copy all files from this repo to `benches/` in main repo
2. Update main repo's `Cargo.toml` workspace members
3. Update dependency paths in benchmark `Cargo.toml`
4. Rebuild

However, the separation is beneficial and rollback is not recommended.

## Timeline

- **2024-11-21**: Benchmarks removed from main repository
- **2024-11-21**: Benchmarks migrated to dedicated repository
- **2024-11-21**: Documentation and configuration completed

## Questions?

For questions about:
- **This migration**: See this document or main repo's REMOVAL_SUMMARY.md
- **Running benchmarks**: See README.md
- **Configuration**: See CONFIGURATION.md
- **Technical issues**: Open an issue in this repository

## References

- [Main Repository REMOVAL_SUMMARY.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/REMOVAL_SUMMARY.md)
- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Hydro Project](https://hydro.run)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
