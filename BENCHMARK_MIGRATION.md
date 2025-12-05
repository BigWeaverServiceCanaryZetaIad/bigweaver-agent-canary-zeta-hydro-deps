# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The benchmarks were moved to:
1. **Reduce build times** - Remove heavyweight `timely` and `differential-dataflow` dependencies from the main repository
2. **Isolate dependencies** - Keep specialized benchmarking dependencies separate from core development
3. **Improve developer experience** - Faster compilation for day-to-day development work
4. **Maintain benchmark capability** - Retain the ability to run performance comparisons when needed

## What Was Moved

### Benchmarks Directory
The entire `benches/` directory containing:
- All benchmark source files (`benches/benches/*.rs`)
- Benchmark data files (word lists, graph data)
- Cargo.toml with benchmark definitions
- build.rs for benchmark compilation
- README.md with benchmark documentation

### Specific Benchmarks
- `arithmetic.rs` - Pipeline arithmetic operations
- `fan_in.rs` - Fan-in dataflow patterns  
- `fan_out.rs` - Fan-out dataflow patterns
- `fork_join.rs` - Fork-join patterns
- `futures.rs` - Async/futures benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability algorithms (with test data files)
- `symmetric_hash_join.rs` - Hash join benchmarks
- `upcase.rs` - String transformation benchmarks
- `words_diamond.rs` - Diamond pattern with word processing (with word list)

## What Was Removed from Main Repository

1. **Workspace member**: `"benches"` removed from `Cargo.toml` workspace members
2. **CI Workflow**: `.github/workflows/benchmark.yml` removed
3. **Documentation**: References to benchmarks removed from `CONTRIBUTING.md`
4. **GitHub Pages**: Benchmark links removed from `.github/gh-pages/index.md`

## Dependencies

The benchmarks depend on:
- `timely` (timely-master v0.13.0-dev.1) - Core timely dataflow dependency
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1) - Differential dataflow dependency
- `dfir_rs` - Referenced via path from main repository
- `sinktools` - Referenced via path from main repository
- `criterion` - For benchmarking framework
- Various support crates (futures, rand, tokio, etc.)

## Running Benchmarks

### Local Execution
From the `bigweaver-agent-canary-zeta-hydro-deps` repository:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run with specific filter
cargo bench -p benches -- dfir
cargo bench -p benches -- micro/ops/
```

### Performance Comparisons

Since this repository references `dfir_rs` and `sinktools` from the main repository via path dependencies, you can:

1. Make changes in `bigweaver-agent-canary-hydro-zeta`
2. Run benchmarks from this repository
3. The benchmarks will use your latest changes
4. Compare results to establish performance impact

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                  # Workspace configuration
├── README.md                   # Repository documentation
├── BENCHMARK_MIGRATION.md      # This file
└── benches/
    ├── Cargo.toml              # Benchmark package configuration
    ├── README.md               # Benchmark-specific documentation
    ├── build.rs                # Build script
    └── benches/
        ├── .gitignore
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_alpha.txt
        └── words_diamond.rs
```

## Path Dependencies

The benchmarks reference the following from the main repository:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

This assumes both repositories are cloned side-by-side in the same parent directory. If your directory structure is different, adjust these paths accordingly.

## CI/CD Considerations

The original CI workflow (`.github/workflows/benchmark.yml`) was removed from the main repository. If automated benchmarking is desired, a similar workflow should be created in this repository with appropriate configuration to:
- Clone both repositories
- Run benchmarks on schedule or on-demand
- Publish results to GitHub Pages or artifact storage

## Future Enhancements

Potential improvements to consider:
1. Set up automated benchmark runs
2. Implement benchmark result tracking over time
3. Add benchmark comparison tools
4. Create performance regression detection
5. Document performance baselines

## Migration Date

Benchmarks were originally removed from the main repository in commit `b161bc10` on November 28, 2025.
Benchmarks were migrated to this repository on December 5, 2025.
