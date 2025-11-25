# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The benchmarks were moved to:
1. **Reduce dependency footprint** - Keep the main repository lean by isolating dependencies on `timely` and `differential-dataflow` packages
2. **Improve separation of concerns** - Separate performance comparison code from core functionality
3. **Maintain benchmark capabilities** - Preserve the ability to run performance comparisons between Hydro and other dataflow systems
4. **Better dependency management** - Allow independent versioning and updates of benchmark dependencies

## Migrated Benchmarks

### Timely Dataflow Benchmarks

The following benchmarks use Timely Dataflow operators:

1. **arithmetic.rs** - Tests sequential arithmetic operations with map operators
   - Compares pipeline, iterator, raw copy, and timely implementations
   - Includes Hydro dfir_rs implementations

2. **fan_in.rs** - Tests multiple streams combining into one using concatenate
   - Benchmarks stream merging performance

3. **fan_out.rs** - Tests one stream splitting into multiple outputs
   - Benchmarks stream distribution patterns

4. **fork_join.rs** - Tests fork and join dataflow patterns
   - Uses filter and concatenate operations
   - Includes generated Hydro code from build script

5. **identity.rs** - Tests identity/passthrough transformations
   - Baseline benchmark for overhead measurement

6. **join.rs** - Tests join operations between two streams
   - Compares HashMap-based and Timely operator implementations

7. **upcase.rs** - Tests string uppercase transformations
   - String processing benchmark with map operators

### Differential Dataflow Benchmarks

1. **reachability.rs** - Graph reachability computation
   - Uses differential dataflow iterative operators (Iterate, Join, Threshold)
   - Includes data files: `reachability_edges.txt` and `reachability_reachable.txt`
   - Demonstrates incremental computation capabilities

## Supporting Files Migrated

### Infrastructure
- **Cargo.toml** - Package manifest with benchmark definitions and dependencies
- **build.rs** - Build script for generating fork_join benchmark code
- **README.md** - Documentation for running benchmarks

### Data Files
- **reachability_edges.txt** (524KB) - Graph edges for reachability benchmark
- **reachability_reachable.txt** (40KB) - Expected reachable nodes
- **words_alpha.txt** (3.7MB) - English words dictionary for upcase benchmark

## Files NOT Migrated

The following benchmarks remain in the main repository as they don't depend on timely/differential:

- **futures.rs** - Tests async/futures functionality
- **micro_ops.rs** - Tests dfir_rs micro-operations
- **symmetric_hash_join.rs** - Tests dfir_rs symmetric hash join
- **words_diamond.rs** - Tests dfir_rs diamond patterns

## Dependency Changes

### Main Repository
After migration, the main repository can remove these dev-dependencies from benches:
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)

### This Repository
Dependencies are maintained via git references to the main repository:
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

Direct dependencies:
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

## Performance Comparison Workflow

### Before Migration
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### After Migration

**For Timely/Differential benchmarks:**
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

**For Hydro-specific benchmarks:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Verification

To verify the migration was successful:

1. **Check benchmark compilation:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo check -p benches
   ```

2. **Run a quick benchmark:**
   ```bash
   cargo bench -p benches --bench identity
   ```

3. **Verify all benchmarks are present:**
   ```bash
   cargo bench -p benches --list
   ```

Expected output should include:
- arithmetic
- fan_in
- fan_out
- fork_join
- identity
- join
- reachability
- upcase

## Benchmark Functionality Preservation

All benchmark functionality has been preserved:
- ✅ All source code copied without modifications
- ✅ All data files included
- ✅ Build scripts maintained
- ✅ Criterion configuration preserved
- ✅ Performance comparison capabilities intact

## Integration with CI/CD

### Recommendations for CI Configuration

1. **Separate benchmark jobs** - Run benchmarks from both repositories in separate CI jobs
2. **Performance tracking** - Maintain separate performance baselines for each repository
3. **Coordinated updates** - When updating dfir_rs, test benchmarks in both repositories

### Example CI Structure
```yaml
jobs:
  bench-main:
    name: Benchmarks (Main Repository)
    runs-on: ubuntu-latest
    steps:
      - checkout: bigweaver-agent-canary-hydro-zeta
      - run: cargo bench -p benches

  bench-deps:
    name: Benchmarks (Timely/Differential)
    runs-on: ubuntu-latest
    steps:
      - checkout: bigweaver-agent-canary-zeta-hydro-deps
      - run: cargo bench -p benches
```

## Maintenance Guidelines

1. **Updating benchmarks** - Changes to benchmark logic should be made in this repository
2. **Updating dfir_rs** - When dfir_rs changes affect benchmarks, update git dependencies
3. **Adding new benchmarks**:
   - Timely/Differential benchmarks → This repository
   - Pure Hydro benchmarks → Main repository
4. **Data files** - Large data files should remain here to avoid bloating the main repository

## Related Documentation

- Main repository: `bigweaver-agent-canary-hydro-zeta/benches/README.md`
- This repository: `benches/README.md`
- Main repository RELEASING.md for version coordination

## Migration Metadata

- **Migration Date**: 2024-11-25
- **Source Repository**: bigweaver-agent-canary-hydro-zeta
- **Destination Repository**: bigweaver-agent-canary-zeta-hydro-deps
- **Benchmarks Migrated**: 8 (arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase)
- **Data Files Migrated**: 3 (reachability_edges.txt, reachability_reachable.txt, words_alpha.txt)
- **Total Size Migrated**: ~4.3 MB
