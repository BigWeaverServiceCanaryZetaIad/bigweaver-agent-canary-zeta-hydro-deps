# Benchmark Migration Guide

## Overview

The timely-dataflow and differential-dataflow benchmarks have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## What Was Moved

### Benchmarks
All benchmark code from the `benches/` directory, including:
- Benchmark source files (`benches/benches/*.rs`)
- Benchmark data files (`benches/benches/*.txt`)
- Benchmark configuration (`benches/Cargo.toml`)
- Benchmark documentation (`benches/README.md`)

### Dependencies
The following workspace crates were copied to support the benchmarks:
- `dfir_rs` - DFIR runtime (with hydro_deploy_integration removed)
- `dfir_lang` - DFIR language implementation
- `dfir_macro` - DFIR macro support
- `lattices` - Lattice types and operations
- `lattices_macro` - Lattice macro support
- `sinktools` - Sink utilities
- `variadics` - Variadic utilities
- `variadics_macro` - Variadic macro support
- `hydro_build_utils` - Build utilities

### CI/CD
- `.github/workflows/benchmark.yml` - GitHub Actions workflow for running benchmarks

### Configuration Files
- `rust-toolchain.toml` - Rust toolchain specification
- `rustfmt.toml` - Code formatting configuration
- `clippy.toml` - Clippy linting configuration
- `Cargo.toml` - Workspace configuration

## Running Benchmarks

### In the New Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability

# Run benchmarks with specific pattern
cargo bench -p benches -- identity
```

### Benchmark Comparison

To compare performance between different versions:

```bash
# Baseline
git checkout main
cargo bench -p benches -- --save-baseline main

# Feature branch
git checkout feature/my-optimization
cargo bench -p benches -- --baseline main
```

## What Was Removed from Main Repository

From `bigweaver-agent-canary-hydro-zeta`:
- The entire `benches/` directory and its contents
- References to `benches` in the workspace members (if any)
- The `.github/workflows/benchmark.yml` workflow
- Benchmark-related links in `.github/gh-pages/index.md`

Note: The `timely-master` and `differential-dataflow-master` dependencies remain in `Cargo.lock` as transitive dependencies if any other workspace crates depend on them indirectly.

## CI/CD Changes

### In bigweaver-agent-canary-zeta-hydro-deps

The benchmark workflow now runs in this repository:
- Triggered by `[ci-bench]` tag in commit messages or PR titles
- Daily scheduled runs
- Manual workflow dispatch option

### In bigweaver-agent-canary-hydro-zeta

The benchmark workflow has been removed. To run benchmarks:
1. Navigate to the `bigweaver-agent-canary-zeta-hydro-deps` repository
2. Follow the instructions in this guide

## Performance Comparison Capability

The ability to run performance comparisons has been maintained:

1. **Criterion Integration**: All benchmarks use Criterion, which supports:
   - Baseline comparisons
   - Statistical analysis
   - HTML report generation

2. **CI Integration**: The GitHub Actions workflow:
   - Runs benchmarks automatically
   - Generates and stores results
   - Publishes to GitHub Pages (if configured)

3. **Local Development**: Developers can:
   - Run benchmarks locally with full Criterion features
   - Compare branches using baseline functionality
   - Access all benchmark data files

## Migration Benefits

1. **Reduced Main Repository Size**: Removing large benchmark data files (370KB+ words file)
2. **Cleaner Dependencies**: timely/differential-dataflow isolated to this repository
3. **Focused Development**: Performance work doesn't clutter main repository
4. **Maintained Capability**: All benchmark functionality preserved
5. **Better Organization**: Clear separation between application code and performance testing

## Troubleshooting

### Missing Dependencies

If you encounter missing dependencies, ensure you're in the correct repository:
- Benchmarks: `bigweaver-agent-canary-zeta-hydro-deps`
- Application code: `bigweaver-agent-canary-hydro-zeta`

### Build Errors

If builds fail due to missing workspace members:
1. Verify all required crates are listed in the workspace `Cargo.toml`
2. Check that path dependencies are correct (use `../` prefix)
3. Ensure `rust-toolchain.toml` matches the main repository

### Benchmark Execution Issues

If benchmarks fail to run:
1. Verify benchmark data files are present in `benches/benches/`
2. Check that `cargo bench` is run from the repository root
3. Ensure sufficient disk space for criterion reports

## Future Updates

When updating benchmarks:
1. Make changes in `bigweaver-agent-canary-zeta-hydro-deps`
2. Create PR with `[ci-bench]` tag to trigger CI
3. Review criterion reports in the workflow artifacts
4. Merge when performance is acceptable

When updating shared crates (dfir_rs, etc.):
1. Update in main repository first
2. Sync changes to this repository as needed
3. Test benchmarks to ensure compatibility
