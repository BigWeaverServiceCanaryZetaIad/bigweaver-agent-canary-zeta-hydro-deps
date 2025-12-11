# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated deps repository.

## Motivation

The benchmarks were moved to:

1. **Reduce unnecessary dependencies**: The main repository no longer needs timely and differential-dataflow as dependencies
2. **Maintain clean dependency graph**: Separating comparison benchmarks from production code
3. **Preserve benchmarking capability**: All performance comparison functionality is retained
4. **Enable independent updates**: Timely/differential-dataflow versions can be updated independently

## What Was Moved

### Benchmark Files

The following benchmark files were moved to `benches/benches/`:

- `arithmetic.rs` - Pipeline benchmark with arithmetic operations using timely
- `fan_in.rs` - Fan-in pattern benchmark using timely
- `fan_out.rs` - Fan-out pattern benchmark using timely
- `fork_join.rs` - Fork-join pattern benchmark using timely
- `identity.rs` - Identity/passthrough benchmark using timely
- `join.rs` - Join operation benchmark using timely
- `reachability.rs` - Graph reachability benchmark using differential-dataflow
- `upcase.rs` - String manipulation benchmark using timely

### Data Files

- `reachability_edges.txt` - Graph edges data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for reachability benchmark

### Dependencies Moved

From the main repository's Cargo.toml/Cargo.lock to this repository's benches/Cargo.toml:

- `differential-dataflow` (package: differential-dataflow-master, version 0.13.0-dev.1)
- `timely` (package: timely-master, version 0.13.0-dev.1)
- Related timely sub-packages (timely-bytes, timely-communication, timely-container, timely-logging)

## What Remains in Main Repository

The main repository still contains benchmarks that do NOT depend on timely or differential-dataflow:

- `futures.rs` - Async futures benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Hash join benchmarks
- `words_diamond.rs` - Diamond pattern with string manipulation

These benchmarks use only dfir_rs and remain in the main repository's `benches` package.

## Directory Structure

### This Repository (bigweaver-agent-canary-zeta-hydro-deps)

```
benches/
├── Cargo.toml                     # Dependencies including timely & differential-dataflow
├── README.md                      # Benchmark documentation
└── benches/
    ├── arithmetic.rs              # Timely benchmark
    ├── fan_in.rs                  # Timely benchmark
    ├── fan_out.rs                 # Timely benchmark
    ├── fork_join.rs               # Timely benchmark
    ├── identity.rs                # Timely benchmark
    ├── join.rs                    # Timely benchmark
    ├── reachability.rs            # Differential-dataflow benchmark
    ├── reachability_edges.txt     # Data file
    ├── reachability_reachable.txt # Data file
    └── upcase.rs                  # Timely benchmark
```

### Main Repository (bigweaver-agent-canary-hydro-zeta)

```
benches/
├── Cargo.toml                     # Dependencies: dfir_rs, criterion, etc.
├── README.md                      # Benchmark documentation
└── benches/
    ├── futures.rs                 # dfir_rs benchmark
    ├── micro_ops.rs               # dfir_rs benchmark
    ├── symmetric_hash_join.rs     # dfir_rs benchmark
    ├── words_diamond.rs           # dfir_rs benchmark
    └── words_alpha.txt            # Data file
```

## Running Benchmarks After Migration

### In This Repository (Timely/Differential Benchmarks)

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

Or use the helper script:
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
./run_benchmarks.sh
```

### In Main Repository (dfir_rs Benchmarks)

```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Performance Comparison Workflow

To compare performance between timely/differential-dataflow and dfir_rs:

1. **Run timely/differential benchmarks:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench
   ```
   Results stored in `target/criterion/`

2. **Run dfir_rs benchmarks:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```
   Results stored in `target/criterion/`

3. **Compare results:**
   - Both use criterion v0.5.0 with identical configuration
   - Open `target/criterion/report/index.html` in each repository
   - Use criterion's built-in comparison tools
   - Historical data is tracked automatically

## Dependency References

The benchmarks in this repository reference dfir_rs and sinktools from the main repository via git:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

This ensures benchmarks always compare against the latest version of the main repository.

## Impact on CI/CD

### Main Repository

- CI/CD no longer needs to install timely/differential-dataflow dependencies
- Faster builds and reduced dependency complexity
- Cargo.lock no longer contains timely/differential-dataflow entries

### This Repository

- Can set up separate CI/CD pipeline for performance benchmarks
- Can run on a schedule rather than on every commit
- Allows tracking performance trends over time

## Verification

To verify the migration was successful:

1. **Check main repository has no timely/differential deps:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   grep -i "timely\|differential" Cargo.lock
   # Should return no results
   ```

2. **Check this repository has the benchmarks:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches/benches
   ls -1 *.rs
   # Should list: arithmetic.rs, fan_in.rs, fan_out.rs, fork_join.rs, 
   #              identity.rs, join.rs, reachability.rs, upcase.rs
   ```

3. **Verify benchmarks compile:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo check --benches
   ```

## Migration Date

This migration was completed on: 2025-12-11

## References

- Main repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- This repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
