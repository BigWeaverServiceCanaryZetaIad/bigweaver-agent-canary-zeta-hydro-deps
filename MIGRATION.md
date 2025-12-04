# Migration History

## Overview

This repository was created to house benchmarks that were removed from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency management.

## Source

**Original Repository:** `bigweaver-agent-canary-hydro-zeta`  
**Removal Commit:** `b161bc10` - "chore(benches): remove timely/differential-dataflow dependencies and benchmarks"  
**Date:** November 28, 2025

## What Was Moved

### Benchmark Files

All benchmark implementations from `benches/benches/`:
- `arithmetic.rs` - Arithmetic operations performance
- `fan_in.rs` - Fan-in dataflow pattern
- `fan_out.rs` - Fan-out dataflow pattern
- `fork_join.rs` - Fork-join parallel pattern
- `futures.rs` - Async/futures benchmarks
- `identity.rs` - Pass-through operations
- `join.rs` - Join operations
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability algorithms
- `symmetric_hash_join.rs` - Symmetric hash join implementation
- `upcase.rs` - String transformation
- `words_diamond.rs` - Diamond dataflow pattern with words

### Test Data Files

Large test data files required by benchmarks:
- `reachability_edges.txt` (524K) - Graph edges for reachability tests
- `reachability_reachable.txt` (40K) - Expected reachable nodes
- `words_alpha.txt` (3.7M) - English word list from dwyl/english-words

### Configuration Files

Build and configuration files:
- `benches/Cargo.toml` - Package manifest with all dependencies
- `benches/build.rs` - Build script for code generation
- `benches/README.md` - Benchmark documentation
- `benches/benches/.gitignore` - Git ignore patterns for generated files

### Repository Configuration

Configuration files copied from main repository to maintain consistency:
- `rust-toolchain.toml` - Rust version 1.91.1 specification
- `rustfmt.toml` - Code formatting rules
- `clippy.toml` - Linting configuration
- `Cargo.toml` - Workspace configuration
- `.gitignore` - Git ignore patterns

## Changes Made

### Path Updates

Updated dependency paths in `benches/Cargo.toml`:
- `dfir_rs`: `../dfir_rs` → `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- `sinktools`: `../sinktools` → `../../bigweaver-agent-canary-hydro-zeta/sinktools`

These paths assume both repositories are cloned in the same parent directory.

### New Documentation

Created comprehensive documentation:
- `README.md` - Repository overview and usage guide
- `CONTRIBUTING.md` - Contribution guidelines
- `MIGRATION.md` - This file, documenting the migration history

### CI/CD Workflows

Added GitHub Actions workflows:
- `.github/workflows/ci.yml` - Continuous integration checks
- `.github/workflows/benchmark.yml` - Benchmark execution workflow

## Dependencies Preserved

### Timely and Differential Dataflow

The primary reason for this repository separation was to preserve these dependencies:
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)

### From Main Repository

Dependencies that reference the main repository:
- `dfir_rs` - Hydro DFIR implementation
- `sinktools` - Output handling utilities

### External Dependencies

Third-party dependencies preserved:
- `criterion` (0.5.0) - Benchmarking framework
- `futures` (0.3) - Async runtime
- `tokio` (1.29.0) - Async runtime
- `rand` (0.8.0) - Random number generation
- `rand_distr` (0.4.3) - Random distributions
- `seq-macro` (0.2.0) - Sequence macros
- `nameof` (1.0.0) - Name reflection
- `static_assertions` (1.0.0) - Compile-time assertions

## Performance Comparison Functionality

All benchmarks maintain the ability to compare performance across multiple implementations:
- **Hydro/DFIR** - Native Hydro dataflow implementation
- **Timely** - Timely dataflow framework
- **Differential** - Differential dataflow (where applicable)

This enables direct performance comparison between different dataflow systems, which was a key requirement for the migration.

## Integration Points

### Repository Structure

Expected directory layout:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/     # Main Hydro repository
│   ├── dfir_rs/                            # Required dependency
│   └── sinktools/                          # Required dependency
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
    └── benches/                            # Benchmarks package
```

### Build Process

1. `build.rs` generates code at compile time (fork-join patterns)
2. Benchmarks reference the main repository via relative paths
3. Test data is included at compile time using `include_bytes!()`

## Verification

To verify the migration was successful:

```bash
# Check all files are present
ls -la benches/benches/*.rs
ls -la benches/benches/*.txt

# Verify dependencies
grep -E "(timely|differential)" benches/Cargo.toml

# Test builds (requires Rust toolchain)
cargo check -p benches

# Run benchmarks
cargo bench -p benches
```

## Statistics

**Total files moved:** 23  
**Total lines of code:** ~435,000+ (including large data files)  
**Benchmark implementations:** 12  
**Data files:** 3  
**Total size:** ~4.3MB

## Benefits

1. **Clean Separation:** Main repository no longer includes heavy benchmark dependencies
2. **Preserved Functionality:** All benchmarks retained with full performance comparison capability
3. **Independent Development:** Benchmarks can evolve independently from main codebase
4. **Focused Dependencies:** Each repository has only the dependencies it needs
5. **Better Organization:** Clear separation between library code and performance testing

## Future Considerations

- Consider publishing benchmark results to GitHub Pages
- Add trend tracking for performance over time
- Create comparison reports between Hydro and other frameworks
- Add more benchmark categories as needed
- Consider adding visualization tools for benchmark results
