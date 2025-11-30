# Benchmark Migration Summary

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this separate `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The benchmarks were separated to:
- Maintain cleaner dependency management in the main repository
- Avoid unnecessary dependencies on `timely-dataflow` and `differential-dataflow` packages in the core Hydro project
- Allow independent development and testing of benchmarks without affecting the main codebase
- Reduce build times for developers who don't need to run these specific benchmarks

## What Was Moved

### Benchmark Files

All benchmark files from `bigweaver-agent-canary-hydro-zeta/benches/benches/`:
- `arithmetic.rs` - Arithmetic operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Futures-based async benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks (uses differential-dataflow)
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase benchmarks
- `words_diamond.rs` - Word processing diamond pattern benchmarks

### Data Files
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - English word list for word processing benchmarks

### Configuration Files
- `Cargo.toml` - Package and benchmark configuration
- `build.rs` - Build script for generating test code
- `README.md` - Updated documentation
- Configuration files from parent repository:
  - `rust-toolchain.toml`
  - `rustfmt.toml`
  - `clippy.toml`

## Dependencies Removed from Main Repository

The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta`:
- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)

These dependencies are now only present in this repository.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Package configuration with timely/differential deps
├── build.rs                # Build script
├── README.md               # Usage documentation
├── MIGRATION_SUMMARY.md    # This file
├── rust-toolchain.toml     # Rust version specification
├── rustfmt.toml            # Code formatting configuration
├── clippy.toml             # Linting configuration
├── .gitignore              # Git ignore patterns
└── benches/                # Benchmark implementations
    ├── *.rs                # Individual benchmark files
    └── *.txt               # Test data files
```

## Dependencies on Main Repository

This repository maintains dependencies on the following crates from the main repository:
- `dfir_rs` - Located at `../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- `sinktools` - Located at `../bigweaver-agent-canary-hydro-zeta/sinktools`

These are specified as path dependencies, requiring both repositories to be cloned as siblings.

## How to Use the Separated Benchmarks

### Prerequisites

Clone both repositories as siblings:
```bash
cd /projects/sandbox/
git clone <repo-url>/bigweaver-agent-canary-hydro-zeta.git
git clone <repo-url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

### Running Benchmarks

From the `bigweaver-agent-canary-zeta-hydro-deps` directory:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability
cargo bench --bench identity

# Run benchmarks matching a pattern
cargo bench arithmetic
```

### Performance Comparisons

Criterion automatically tracks performance over time:

1. Run benchmarks to establish a baseline:
   ```bash
   cargo bench
   ```

2. Make changes to the code in either repository

3. Run benchmarks again:
   ```bash
   cargo bench
   ```

4. Criterion will show comparison with the previous run

5. View detailed HTML reports:
   ```bash
   open target/criterion/report/index.html
   ```

### Baseline Management

To save/load specific baselines:

```bash
# Save current results as baseline
cargo bench -- --save-baseline my-baseline

# Compare against saved baseline
cargo bench -- --baseline my-baseline
```

## Integration with CI/CD

The benchmarks can be run in CI/CD pipelines by:

1. Ensuring both repositories are checked out as siblings
2. Running `cargo bench` in this repository
3. Optionally publishing benchmark results as artifacts

Example CI step:
```yaml
- name: Run timely/differential benchmarks
  working-directory: bigweaver-agent-canary-zeta-hydro-deps
  run: cargo bench --no-fail-fast
```

## Maintenance Notes

### Updating Dependencies

When updating `dfir_rs` or `sinktools` in the main repository, verify that the benchmarks still compile and run correctly.

### Adding New Benchmarks

To add new benchmarks that require timely or differential-dataflow:

1. Add the benchmark file to `benches/` directory
2. Add a `[[bench]]` section in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_new_bench"
   harness = false
   ```
3. Update the README.md to list the new benchmark

### Syncing Configuration

Periodically sync configuration files from the main repository:
- `rust-toolchain.toml`
- `rustfmt.toml`
- `clippy.toml`

## References

- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
- Timely dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential dataflow: https://github.com/TimelyDataflow/differential-dataflow
