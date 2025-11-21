# Migration Guide: Timely and Differential-Dataflow Benchmarks

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Reason for Migration

The benchmarks were moved to:
1. **Separate concerns** - Keep the main Hydro repository focused on core functionality
2. **Isolate dependencies** - Timely and Differential-Dataflow dependencies are now isolated
3. **Improve maintainability** - Benchmark updates don't affect main repository
4. **Enable independent versioning** - Benchmarks can evolve at their own pace

## What Was Migrated

### Source Files
All files from the `benches/` directory in bigweaver-agent-canary-hydro-zeta:

- **Cargo.toml** - Package configuration with all benchmark entries
- **build.rs** - Build script for generating fork_join tests
- **README.md** - Benchmark documentation
- **benches/** directory:
  - `arithmetic.rs` - Arithmetic operations benchmark
  - `fan_in.rs` - Fan-in pattern benchmark
  - `fan_out.rs` - Fan-out pattern benchmark
  - `fork_join.rs` - Fork-join pattern benchmark
  - `futures.rs` - Futures resolution benchmark
  - `identity.rs` - Identity operation benchmark
  - `join.rs` - Join operation benchmark
  - `micro_ops.rs` - Micro-operations benchmark
  - `reachability.rs` - Graph reachability benchmark
  - `symmetric_hash_join.rs` - Symmetric hash join benchmark
  - `upcase.rs` - String uppercasing benchmark
  - `words_diamond.rs` - Word processing diamond pattern
  - Test data files: `reachability_edges.txt`, `reachability_reachable.txt`, `words_alpha.txt`
  - `.gitignore` - Git ignore rules for generated files

### CI/CD Workflow
The `.github/workflows/benchmark.yml` workflow was migrated and updated to:
- Run benchmarks on schedule, manual trigger, or with `[ci-bench]` tag
- Generate HTML reports and JSON data
- Upload artifacts for PR review
- Publish results to gh-pages branch

## Changes Made During Migration

### 1. Workspace Setup
Created a new workspace `Cargo.toml` at the repository root with:
- Edition 2024
- Apache-2.0 license
- Optimized release profiles
- Workspace lints matching the original repository

### 2. Dependency Updates
Updated `benches/Cargo.toml`:
```toml
# Before (path dependency)
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }

# After (git dependency)
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
```

### 3. Workflow Adjustments
Modified the benchmark workflow to:
- Add explicit Rust toolchain installation
- Handle missing gh-pages branch gracefully on first run
- Remove dependencies on files from the main repository (gh-pages static files)

## Performance Comparison Functionality

### Retained Features

All performance comparison capabilities are preserved:

1. **Multi-framework comparison**:
   - Timely Dataflow implementations
   - Differential Dataflow implementations
   - DFIR scheduled runtime implementations
   - DFIR compiled runtime implementations

2. **Benchmark suite**:
   - All 12 benchmark files are functional
   - Test data files are included
   - Build scripts work correctly

3. **Statistical analysis**:
   - Criterion integration for robust measurements
   - HTML report generation
   - Historical tracking via gh-pages

4. **CI/CD automation**:
   - Scheduled daily runs
   - Pull request benchmarking
   - Artifact uploads
   - Historical data preservation

### How to Run Comparisons

The same commands work as before:

```bash
# All benchmarks
cargo bench -p benches

# Specific benchmark
cargo bench -p benches --bench reachability

# Filter by framework
cargo bench -p benches -- dfir
cargo bench -p benches -- timely
cargo bench -p benches -- differential
```

## Configuration in New Location

### Repository Structure
```
bigweaver-agent-canary-zeta-hydro-deps/
├── .github/
│   └── workflows/
│       └── benchmark.yml       # CI/CD for benchmarks
├── benches/                     # Benchmark package
│   ├── Cargo.toml              # Package manifest
│   ├── build.rs                # Build script
│   ├── README.md               # Benchmark docs
│   └── benches/                # Benchmark implementations
│       ├── *.rs                # Benchmark source files
│       └── *.txt               # Test data files
├── Cargo.toml                  # Workspace manifest
├── README.md                   # Repository overview
└── MIGRATION_GUIDE.md          # This file
```

### Build Configuration
The workspace is configured with:
- **Resolver**: Version 2 (for better dependency resolution)
- **Edition**: 2024 (latest stable features)
- **Profile**: Optimized release profile for accurate benchmarking

### Testing the Migration
To verify the benchmarks work correctly:

```bash
# 1. Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# 2. Run a quick benchmark
cargo bench -p benches --bench identity

# 3. Check that all benchmarks build
cargo bench -p benches --no-run

# 4. Run full benchmark suite (takes longer)
cargo bench -p benches
```

## Integration with Main Repository

### Linking Back
The benchmarks depend on dfir_rs from the main repository via git dependency:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
```

### Version Pinning
To use a specific version of dfir_rs:
```toml
dfir_rs = { 
    git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git",
    branch = "main",  # or tag = "v0.14.0", or rev = "abc123"
    features = [ "debugging" ] 
}
```

### Updating Dependencies
To update to the latest dfir_rs:
```bash
cargo update -p dfir_rs
```

## Continuous Integration

### Triggering Benchmarks
Benchmarks run automatically on:

1. **Schedule**: Daily at 8:35 PM PDT / 7:35 PM PST
2. **Push to main**: If commit message contains `[ci-bench]`
3. **Push to feature branches**: If commit message contains `[ci-bench]`
4. **Pull requests**: If PR title or body contains `[ci-bench]`
5. **Manual**: Via workflow dispatch

### Viewing Results
Results are available:
- **In PRs**: As uploaded artifacts
- **On main**: Published to gh-pages branch
- **Locally**: In `target/criterion/` directory

## Maintenance

### Adding New Benchmarks
1. Create new `.rs` file in `benches/benches/`
2. Add `[[bench]]` entry in `benches/Cargo.toml`
3. Follow existing patterns for multi-framework comparison
4. Test locally before pushing

### Updating Dependencies
```bash
# Update all dependencies
cargo update

# Update specific dependency
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

### Troubleshooting
Common issues and solutions:

1. **Build failures**: Check that dfir_rs API hasn't changed
2. **Benchmark timeouts**: Adjust timeout in workflow or reduce dataset size
3. **Missing gh-pages**: Workflow handles this automatically on first run

## Migration Checklist

- [x] Extract all benchmark files from git history
- [x] Create workspace structure
- [x] Update dependencies to use git references
- [x] Migrate CI/CD workflow
- [x] Update documentation
- [x] Verify benchmarks compile and run
- [x] Configure performance comparison functionality
- [x] Create migration guide

## References

- Original removal documentation: `REMOVAL_SUMMARY.md` in bigweaver-agent-canary-hydro-zeta
- Benchmark workflow: `.github/workflows/benchmark.yml`
- Main repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
