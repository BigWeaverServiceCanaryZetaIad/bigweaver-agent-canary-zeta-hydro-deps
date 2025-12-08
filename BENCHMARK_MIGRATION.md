# Benchmark Migration Guide

## Overview

This document explains the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Rationale

The benchmarks were moved to achieve better separation of concerns and maintain a cleaner codebase:

1. **Dependency Isolation**: The main Hydro repository no longer needs to depend on timely and differential-dataflow packages
2. **Repository Organization**: Benchmarks comparing Hydro with external frameworks are logically separated
3. **Maintainability**: Clearer boundaries between core functionality and comparative benchmarks
4. **Build Performance**: Reduced dependency tree in the main repository

## What Was Moved

All benchmarks that depend on timely and/or differential-dataflow were migrated:

### Benchmark Files
- `benches/benches/arithmetic.rs`
- `benches/benches/fan_in.rs`
- `benches/benches/fan_out.rs`
- `benches/benches/fork_join.rs`
- `benches/benches/futures.rs`
- `benches/benches/identity.rs`
- `benches/benches/join.rs`
- `benches/benches/micro_ops.rs`
- `benches/benches/reachability.rs`
- `benches/benches/symmetric_hash_join.rs`
- `benches/benches/upcase.rs`
- `benches/benches/words_diamond.rs`

### Supporting Files
- `benches/Cargo.toml` - Package manifest with dependencies
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script
- `benches/benches/.gitignore` - Git ignore patterns

### Test Data
- `benches/benches/reachability_edges.txt` - Graph edges for reachability tests
- `benches/benches/reachability_reachable.txt` - Expected reachability results
- `benches/benches/words_alpha.txt` - English word list for text processing benchmarks

## Changes to Main Repository

The following changes were made to `bigweaver-agent-canary-hydro-zeta`:

1. **Removed**: Entire `benches/` directory and all its contents
2. **Removed**: Workspace member `"benches"` from root `Cargo.toml`
3. **Removed**: Benchmark workflow `.github/workflows/benchmark.yml` (if existed)
4. **Updated**: Documentation references to benchmarks

## Changes to This Repository

This repository was set up with:

1. **Added**: All benchmark files and supporting infrastructure
2. **Created**: Root workspace `Cargo.toml` with proper configuration
3. **Updated**: `benches/Cargo.toml` to use Git dependencies for:
   - `dfir_rs` - References main repository via Git URL
   - `sinktools` - References main repository via Git URL
4. **Retained**: Direct dependencies on `timely` and `differential-dataflow`
5. **Created**: Comprehensive README.md with usage instructions
6. **Created**: This migration guide

## Running Performance Comparisons

### Before Migration
```bash
# In bigweaver-agent-canary-hydro-zeta repository
cargo bench -p benches
```

### After Migration

#### Option 1: Run Benchmarks in This Repository
```bash
# In bigweaver-agent-canary-zeta-hydro-deps repository
cargo bench -p benches
```

#### Option 2: Compare Across Repositories

1. Clone both repositories:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Run benchmarks in this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench arithmetic
```

3. Run equivalent benchmarks in the main repository (if they exist):
```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench # Run any equivalent benchmarks
```

4. Compare results using Criterion's comparison tools

### Criterion Benchmark Comparison

Criterion saves benchmark results in `target/criterion/`. You can:

- View HTML reports in `target/criterion/<benchmark-name>/report/index.html`
- Use `cargo bench -- --save-baseline <name>` to save baselines
- Use `cargo bench -- --baseline <name>` to compare against a saved baseline

Example workflow:
```bash
# Save baseline before changes
cargo bench -p benches -- --save-baseline before

# Make changes to code...

# Compare against baseline
cargo bench -p benches -- --baseline before
```

## Developer Workflow

### For Core Hydro Development

Developers working on the main `bigweaver-agent-canary-hydro-zeta` repository no longer need to:
- Install or manage timely/differential-dataflow dependencies
- Build benchmark code during normal development
- Wait for benchmark compilation

### For Performance Analysis

Developers wanting to run performance comparisons:

1. Clone this repository separately
2. Run benchmarks as needed
3. Reference results when optimizing the main repository

### For Adding New Benchmarks

To add benchmarks comparing Hydro with timely/differential:

1. Add to this repository, not the main one
2. Follow existing patterns in `benches/benches/`
3. Register new benchmarks in `benches/Cargo.toml`
4. Update documentation

## Continuous Integration

If benchmark automation is desired:

1. Set up CI workflows in this repository
2. Configure scheduled benchmark runs
3. Store historical results for trend analysis
4. Generate comparison reports

Example GitHub Actions workflow structure:
```yaml
name: Benchmarks
on:
  schedule:
    - cron: '0 0 * * 0'  # Weekly
  workflow_dispatch:  # Manual trigger

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions-rs/toolchain@v1
      - run: cargo bench -p benches
      # Store results, generate reports, etc.
```

## Benefits of This Approach

1. **Cleaner Main Repository**: No timely/differential dependencies polluting the main codebase
2. **Performance Preserved**: All benchmarks remain runnable and accessible
3. **Better Organization**: Clear separation between core code and comparative benchmarks
4. **Flexible Comparison**: Can still compare Hydro performance against other frameworks
5. **Independent Evolution**: Benchmarks can evolve separately from main codebase
6. **Reduced Maintenance Burden**: Main repository developers don't need to maintain comparative benchmarks

## Troubleshooting

### Git Dependency Issues

If you see errors related to dfir_rs or sinktools:

1. Ensure you have network access to GitHub
2. Check that the Git URL in `benches/Cargo.toml` is correct
3. Try updating dependencies: `cargo update`
4. Clear cargo cache if needed: `cargo clean`

### Version Compatibility

The benchmarks reference the main repository via Git. To use a specific version:

```toml
# In benches/Cargo.toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", rev = "abc123", features = [ "debugging" ] }
```

### Performance Regression Testing

To detect regressions:

1. Save baseline before main repository changes
2. After changes, rebuild dependencies: `cargo update`
3. Re-run benchmarks to compare

## Questions and Support

For questions about:
- **Benchmarks**: Open issues in this repository
- **Core Hydro functionality**: Open issues in the main repository
- **Performance concerns**: Open issues in the relevant repository with benchmark data

## History

- **Migration Date**: December 2025
- **Migrated From**: bigweaver-agent-canary-hydro-zeta repository
- **Reason**: Dependency isolation and better code organization
- **Migrated By**: Development team via automated tooling
