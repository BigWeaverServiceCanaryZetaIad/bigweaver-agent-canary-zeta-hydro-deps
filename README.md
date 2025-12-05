# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on heavyweight dataflow dependencies like `timely` and `differential-dataflow`. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to reduce build times and dependency overhead in the core project.

## Contents

- **benches/**: Microbenchmarks for Hydro and other dataflow frameworks
  - Includes implementations using **Timely Dataflow** and **Differential Dataflow** for performance comparison

## Quick Start

```bash
# Run all benchmarks
cargo bench -p benches

# Run benchmarks with Timely Dataflow implementations
cargo bench -p benches -- timely

# Run benchmarks with Differential Dataflow implementations
cargo bench -p benches -- differential

# Run specific benchmark
cargo bench -p benches --bench reachability
```

## Available Benchmarks

### Benchmarks with Timely Dataflow Implementations
- ✅ `arithmetic` - Pipeline arithmetic operations (20 sequential maps)
- ✅ `fan_in` - Fan-in dataflow patterns (multiple streams → one)
- ✅ `fan_out` - Fan-out dataflow patterns (one stream → multiple)
- ✅ `fork_join` - Fork-join patterns (parallel branches)
- ✅ `identity` - Identity operation (minimal transformation)
- ✅ `join` - Join operations between streams
- ✅ `upcase` - String transformation benchmarks
- ✅ `reachability` - Graph reachability (also includes Differential)

### Benchmarks with Differential Dataflow Implementations
- ✅ `reachability` - Incremental graph reachability algorithm

### Hydro-Specific Benchmarks
- `futures` - Async/futures handling
- `micro_ops` - Individual operator micro-benchmarks
- `symmetric_hash_join` - Optimized hash join implementations
- `words_diamond` - Diamond pattern with word processing

## Performance Comparisons

These benchmarks enable direct performance comparisons between:
- **Hydro/DFIR** - The main framework being developed
- **Timely Dataflow** - Low-level dataflow framework baseline
- **Differential Dataflow** - Incremental computation framework

### Comparison Workflow

1. **Establish Baseline**
   ```bash
   cargo bench -p benches > baseline.txt
   ```

2. **Make Changes** in `bigweaver-agent-canary-hydro-zeta`

3. **Run Comparison**
   ```bash
   cargo bench -p benches > updated.txt
   ```

4. **Analyze Results**
   - View HTML reports: `target/criterion/*/report/index.html`
   - Compare console output for statistical analysis

## Documentation

- **[BENCHMARK_IMPLEMENTATIONS.md](BENCHMARK_IMPLEMENTATIONS.md)** - Detailed guide to all benchmark implementations
- **[BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md)** - Migration history and rationale
- **[QUICK_START.md](QUICK_START.md)** - Quick start guide for running benchmarks

## Dependencies

This repository maintains dependencies on:
- `timely` (timely-master v0.13.0-dev.1) - For Timely Dataflow benchmarks
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1) - For Differential Dataflow benchmarks
- `dfir_rs` - Referenced via path from the main repository
- `sinktools` - Referenced via path from the main repository

**Note:** Path dependencies assume both repositories are cloned side-by-side:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Key Features

- ✅ **Performance Comparison**: Direct comparison between Hydro, Timely, and Differential implementations
- ✅ **Real Workloads**: Includes realistic test data (word lists, graph data)
- ✅ **Comprehensive Coverage**: Tests dataflow patterns, operations, and algorithms
- ✅ **Statistical Analysis**: Uses Criterion for robust benchmarking with statistical rigor
- ✅ **Visual Reports**: HTML reports with charts and historical tracking

## Contributing

When adding new benchmarks or implementations:
1. Follow existing naming conventions (`benchmark_timely`, `benchmark_differential`, etc.)
2. Add benchmark definitions to `benches/Cargo.toml`
3. Update `BENCHMARK_IMPLEMENTATIONS.md` with implementation details
4. Include test data if needed

## Migration History

For details on how these benchmarks were migrated from the main repository, see [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md).

**Migration Date:** December 5, 2025  
**Original Removal:** November 28, 2025 (commit b161bc10)