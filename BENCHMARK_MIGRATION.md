# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Rationale

The benchmarks were moved to:
1. Remove unnecessary dependencies (timely, differential-dataflow) from the main repository
2. Keep the main repository focused on core functionality
3. Maintain the ability to run performance comparisons between repositories
4. Organize dependency-heavy components in a dedicated repository

## What Was Moved

### Files Recovered from Git History

All files were recovered from commit `b161bc10^` (the commit before "chore(benches): remove timely/differential-dataflow dependencies and benchmarks"):

#### Benchmark Structure
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark usage instructions
- `benches/build.rs` - Build script for code generation
- `benches/benches/.gitignore` - Git ignore rules for generated files

#### Benchmark Source Files
- `benches/benches/arithmetic.rs` - Arithmetic operations benchmarks
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Async futures benchmarks
- `benches/benches/identity.rs` - Identity operation benchmarks
- `benches/benches/join.rs` - Join operation benchmarks
- `benches/benches/micro_ops.rs` - Micro-operations benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/upcase.rs` - String uppercase benchmarks
- `benches/benches/words_diamond.rs` - Word processing diamond pattern benchmarks

#### Data Files
- `benches/benches/reachability_edges.txt` - Graph edges for reachability benchmark (521KB)
- `benches/benches/reachability_reachable.txt` - Expected reachable nodes (38KB)
- `benches/benches/words_alpha.txt` - English word list for benchmarks (3.7MB)

#### CI/CD Configuration
- `.github/workflows/benchmark.yml` - GitHub Actions workflow for running benchmarks

#### Configuration Files
- `rust-toolchain.toml` - Rust toolchain version specification
- `rustfmt.toml` - Code formatting rules
- `clippy.toml` - Linting configuration

## Changes Made

### Dependency Configuration

The `benches/Cargo.toml` was updated to use git dependencies instead of path dependencies:

**Before:**
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After:**
```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
# sinktools removed - it's re-exported from dfir_rs
```

Note: The `sinktools` dependency was removed because it's re-exported by `dfir_rs` and not needed as a separate dependency.

### Workspace Configuration

A new `Cargo.toml` workspace file was created at the root of the repository with:
- Workspace metadata (edition, license, repository)
- Build profiles (release, profile, dev)
- Linting rules (matching the main repository)

## Running Benchmarks

### Prerequisites

- Rust toolchain (as specified in `rust-toolchain.toml`)
- Git access to the main `bigweaver-agent-canary-hydro-zeta` repository

### Basic Usage

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

1. **arithmetic** - Tests various arithmetic operations
2. **fan_in** - Multiple inputs converging to single output
3. **fan_out** - Single input distributing to multiple outputs
4. **fork_join** - Parallel execution with synchronization
5. **futures** - Async/await and futures handling
6. **identity** - Identity transformations (baseline)
7. **join** - Stream join operations
8. **micro_ops** - Low-level operation performance
9. **reachability** - Graph reachability algorithms
10. **symmetric_hash_join** - Hash-based join operations
11. **upcase** - String transformation operations
12. **words_diamond** - Complex word processing pipeline

### Benchmark Output

Benchmarks use Criterion, which provides:
- Statistical analysis of results
- HTML reports in `target/criterion/`
- Comparison with previous runs
- Performance regression detection

## Performance Comparisons

The benchmarks enable performance comparisons between:

1. **Hydro (dfir_rs)** - The main dataflow framework
2. **Timely Dataflow** - Streaming dataflow computation framework
3. **Differential Dataflow** - Incremental computation framework

Each benchmark typically includes implementations for all three frameworks, allowing direct performance comparisons.

## CI/CD Integration

The `.github/workflows/benchmark.yml` workflow runs benchmarks:
- On push to main or feature branches
- On pull requests
- Daily via cron schedule
- Manually via workflow_dispatch

Benchmarks are triggered when:
- Commit message contains `[ci-bench]`
- PR title or body contains `[ci-bench]`
- Workflow is manually dispatched with `should_bench: true`

## Maintenance

### Updating Benchmarks

To update benchmarks to use a newer version of the main repository:
1. Cargo will automatically use the latest commit from the main branch
2. Run `cargo update` to refresh dependencies
3. Verify benchmarks still build and run correctly

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`
3. Follow the pattern of existing benchmarks
4. Update documentation in README.md

## Troubleshooting

### Build Failures

If benchmarks fail to build:
1. Check that you have git access to the main repository
2. Verify your Rust toolchain version matches `rust-toolchain.toml`
3. Try `cargo clean` and rebuild
4. Check for breaking changes in the main repository

### Performance Regressions

If benchmarks show performance regressions:
1. Review recent changes in the main repository
2. Compare HTML reports in `target/criterion/`
3. Check if the regression is consistent across multiple runs
4. Consider if the regression is expected due to functionality changes

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── .github/
│   └── workflows/
│       └── benchmark.yml          # CI/CD workflow
├── benches/
│   ├── benches/
│   │   ├── .gitignore
│   │   ├── *.rs                   # Benchmark implementations
│   │   ├── reachability_*.txt     # Graph data files
│   │   └── words_alpha.txt        # Word list
│   ├── build.rs                   # Build script
│   ├── Cargo.toml                 # Benchmark package config
│   └── README.md                  # Benchmark usage guide
├── Cargo.toml                     # Workspace configuration
├── clippy.toml                    # Linting rules
├── rust-toolchain.toml            # Rust version
├── rustfmt.toml                   # Formatting rules
├── BENCHMARK_MIGRATION.md         # This file
└── README.md                      # Repository overview
```

## Links

- Main Repository: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
- Original Migration Commit: `b161bc10` (removal of benchmarks from main repo)
- Recovery Source: `b161bc10^` (state before benchmark removal)
