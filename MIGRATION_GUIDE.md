# Benchmark Migration Guide

## Overview

The benchmarks have been reorganized to separate Hydroflow-specific benchmarks from performance comparison benchmarks that require external dependencies (Timely Dataflow and Differential Dataflow).

## Repository Structure

### bigweaver-agent-canary-hydro-zeta (Main Repository)
**Contains:** Hydroflow-specific microbenchmarks
**Benchmarks:**
- `futures` - Async futures operations
- `micro_ops` - Micro-operations performance
- `symmetric_hash_join` - Symmetric hash join implementation
- `words_diamond` - Word processing diamond pattern

**Running:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### bigweaver-agent-canary-zeta-hydro-deps (Dependencies Repository)
**Contains:** Performance comparison benchmarks against Timely/Differential Dataflow
**Benchmarks:**
- `arithmetic` - Sequential arithmetic operations
- `fan_in` - Multiple input stream merging
- `fan_out` - Broadcasting to multiple streams
- `fork_join` - Splitting and rejoining streams
- `identity` - Simple pass-through operations
- `join` - Hash join operations
- `reachability` - Graph reachability computation
- `upcase` - String transformation operations

**Running:**
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
cargo bench --bench arithmetic    # Run specific benchmark
cargo bench -- timely             # Run only Timely implementations
cargo bench -- dfir               # Run only Hydroflow implementations
```

## Why the Split?

1. **Dependency Isolation:** The main Hydroflow repository no longer needs to depend on `timely` and `differential-dataflow` packages
2. **Focused Testing:** Each repository can focus on its specific testing needs
3. **Performance Comparison:** The comparison benchmarks are preserved for ongoing performance analysis
4. **Cleaner Dependencies:** Reduces the dependency footprint of the main repository

## For Developers

### Adding New Benchmarks

**Hydroflow-only benchmarks:** Add to `bigweaver-agent-canary-hydro-zeta/benches/`

**Comparison benchmarks (requires Timely/Differential):** Add to `bigweaver-agent-canary-zeta-hydro-deps/benches/`

### CI/CD Integration

The benchmark GitHub workflow in the main repository will now only run the Hydroflow-specific benchmarks. If you need to run comparison benchmarks in CI, you'll need to set up a workflow in the deps repository.

## Migration Summary

- **Moved:** 8 benchmark files + 2 data files + build.rs to deps repository
- **Retained:** 4 benchmark files + 1 data file in main repository
- **Removed Dependencies:** `timely` and `differential-dataflow` from main repository
- **Preserved:** All performance comparison functionality in deps repository
