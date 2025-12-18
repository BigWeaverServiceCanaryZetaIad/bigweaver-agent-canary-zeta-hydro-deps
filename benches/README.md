# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for performance comparison with timely and differential-dataflow implementations.

## Overview

These benchmarks are maintained separately from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid pulling in timely and differential-dataflow dependencies for the core Hydro development workflow.

## Available Benchmarks

This directory contains 12 benchmarks organized by dataflow pattern:

### Basic Patterns
- **arithmetic.rs** - Basic arithmetic pipeline operations
- **identity.rs** - Identity function baseline measurement
- **upcase.rs** - String transformation operations

### Flow Patterns
- **fan_in.rs** - Multiple streams merging to one
- **fan_out.rs** - Single stream splitting to multiple
- **fork_join.rs** - Fork and join with filtering
- **words_diamond.rs** - Diamond pattern with word processing (requires timely/differential-dataflow)

### Join Operations
- **join.rs** - Hash join operations
- **symmetric_hash_join.rs** - Symmetric hash join (requires timely/differential-dataflow)

### Advanced Patterns
- **futures.rs** - Async futures-based processing (requires timely/differential-dataflow)
- **micro_ops.rs** - Individual operator micro-benchmarks (requires timely/differential-dataflow)
- **reachability.rs** - Graph reachability algorithm

## Dependencies

This benchmark suite includes:
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)
- `criterion` for benchmarking framework
- Supporting libraries (futures, rand, tokio, etc.)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmark:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
cargo bench --bench arithmetic
cargo bench --bench reachability
```

Run specific test within a benchmark:
```bash
cargo bench --bench arithmetic -- arithmetic/dfir_rs
```

## Performance Comparison

### Running Hydro-Native Benchmarks
From the main repository:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench
```

### Running Timely/Differential-Dataflow Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Comparing Results
Results from both repositories can be compared to evaluate performance characteristics between:
- Hydro-native implementations (main repository)
- Timely/Differential-Dataflow implementations (this repository)

Criterion generates HTML reports in `target/criterion/` that can be used to compare performance between implementations.

## Test Data

- **words_alpha.txt** - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edges for reachability testing
- **reachability_reachable.txt** - Expected reachable nodes

## Results

Benchmark results are output in HTML format in `target/criterion/` directory.
Open `target/criterion/report/index.html` in a browser to view detailed results.

## Migration Notes

These benchmarks were migrated from the main repository to reduce build dependencies and improve build times for core development. The Hydro-native implementations remain in the main repository for development and testing.

For more information about the benchmark migration, see [MIGRATION_SUMMARY.md](../MIGRATION_SUMMARY.md) in this repository.

## More Information

See [BENCHMARKS_GUIDE.md](../BENCHMARKS_GUIDE.md) in the repository root for detailed documentation about each benchmark and how to interpret results.
