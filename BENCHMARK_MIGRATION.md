# Benchmark Migration Guide

## Overview

This document describes the migration of Timely Dataflow and Differential Dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The benchmarks were moved to:

1. **Reduce Dependencies**: Remove `timely` and `differential-dataflow` dependencies from the main repository, keeping it focused on Hydro's core functionality
2. **Improve Build Times**: Avoid compiling these heavy dependencies for developers working on the main codebase
3. **Maintain Comparisons**: Preserve the ability to run performance comparisons between Hydro and Timely/Differential implementations
4. **Cleaner Architecture**: Separate concerns between the main framework and comparative benchmarking

## What Was Moved

### Benchmarks Migrated to hydro-deps Repository

The following benchmarks depend on Timely or Differential Dataflow and have been moved:

- `arithmetic.rs` - Arithmetic operations pipeline
- `fan_in.rs` - Fan-in dataflow pattern
- `fan_out.rs` - Fan-out dataflow pattern
- `fork_join.rs` - Fork-join pattern
- `identity.rs` - Identity operation
- `join.rs` - Join operations
- `reachability.rs` - Graph reachability
- `upcase.rs` - String uppercase transformation
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Test data for reachability benchmark

### Benchmarks Remaining in Main Repository

Note: As of the completion of this migration, the main repository does not contain a separate `benches/` directory with benchmark files. Individual crates may contain their own benchmarks as needed, but there are currently no benchmarks in the main repository that mirror the functionality of the moved benchmarks.

## Dependencies Removed from Main Repository

From the main repository's `benches/Cargo.toml`, the following dependencies were removed:

```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

## Repository Structure

### Main Repository (bigweaver-agent-canary-hydro-zeta)

```
bigweaver-agent-canary-hydro-zeta/
├── dfir_rs/
├── hydro_lang/
├── hydro_test/
└── ... (other crates)
```

Note: The main repository no longer contains a separate `benches/` workspace member. Individual crates may contain their own internal benchmarks as needed.

### Deps Repository (bigweaver-agent-canary-zeta-hydro-deps)

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── Cargo.toml          # With timely/differential deps
│   ├── benches/
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   └── upcase.rs
│   ├── build.rs
│   └── README.md
├── Cargo.toml
├── README.md
└── BENCHMARK_MIGRATION.md (this file)
```

## Running Performance Comparisons

### Step 1: Run Benchmarks in hydro-deps Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench reachability
# ... etc
```

Results will be in `target/criterion/`.

### Step 2: Run Benchmarks in Main Repository (if applicable)

```bash
cd bigweaver-agent-canary-hydro-zeta
# Individual crates may have their own benchmarks
# Check specific crate documentation for benchmark availability
```

### Step 3: Compare Results

Compare the output from both repositories' `target/criterion/` directories. The benchmarks in this repository test various dataflow patterns and can be used as performance baselines when developing similar patterns in Hydro.

## For Performance Engineering Team

When evaluating Hydro's performance against Timely/Differential:

1. Clone both repositories:
   ```bash
   git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
   git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run benchmarks in the deps repository for Timely/Differential baseline
3. Compare with any equivalent benchmarks in the main repository (if available)
4. Analyze comparative performance using Criterion's HTML reports

## For Development Team

When working on the main Hydro codebase:

- You no longer need to compile Timely or Differential Dataflow dependencies
- Faster build times for regular development
- Individual crates may contain their own benchmarks as needed
- Refer to this deps repository only when needed for comparative analysis

## For CI/CD Team

### Main Repository CI

```yaml
- name: Run Tests
  run: |
    cd bigweaver-agent-canary-hydro-zeta
    cargo test
    # Individual crates may have benchmarks - see crate documentation
```

### Deps Repository CI (for comparative benchmarks)

```yaml
- name: Run Timely/Differential Benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench
```

Consider running these on separate schedules:
- Main repo benchmarks: On every PR/commit
- Deps repo benchmarks: Weekly or on-demand for performance analysis

## Migration Checklist

- [x] Identify benchmarks with timely/differential dependencies
- [x] Create hydro-deps repository structure
- [x] Move timely/differential benchmarks to deps repo
- [x] Remove timely/differential dependencies from main repo
- [x] Update Cargo.toml files
- [x] Create comprehensive documentation
- [x] Add README files
- [x] Update CONTRIBUTING.md references

## Maintaining Both Repositories

### Adding New Timely/Differential Benchmarks

Add them to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

### Adding New Hydro-Only Benchmarks

Add them to the appropriate crate in the main `bigweaver-agent-canary-hydro-zeta` repository. Individual crates can include their own benchmark configurations.

### Dependency Updates

- Main repo: Update Hydro dependencies as needed
- Deps repo: Keep Timely/Differential versions in sync with main repo's test requirements

## Support and Questions

For questions about:
- **Benchmark migration**: See this document
- **Running benchmarks**: See `benches/README.md` in respective repositories
- **Performance analysis**: Contact the Performance Engineering team
- **Repository structure**: See `CONTRIBUTING.md` in the main repository

## History

- **2024-12**: Initial migration of timely/differential benchmarks to separate repository
- Preserves ability to run performance comparisons
- Reduces main repository dependencies
- Improves developer experience with faster build times
