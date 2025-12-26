# Timely/Differential-Dataflow Benchmarks

Benchmarks for comparing Hydro implementations with Timely and Differential Dataflow implementations.

## Overview

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with Hydro-native implementations in the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Benchmark Categories

### Timely/Differential-Dataflow Benchmarks
These benchmarks compare Hydro implementations against timely/differential-dataflow:

- **arithmetic** - Arithmetic operations benchmark comparing pipeline implementations
- **fan_in** - Fan-in pattern benchmark (multiple inputs, single output)
- **fan_out** - Fan-out pattern benchmark (single input, multiple outputs)
- **fork_join** - Fork-join pattern benchmark with code generation
- **futures** - Futures-based operations benchmark with timely dataflow overhead comparison
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **micro_ops** - Micro-operations benchmark with timely operators (identity, map, flat_map, filter)
- **reachability** - Graph reachability benchmark with large datasets
- **symmetric_hash_join** - Symmetric hash join benchmark with timely and differential implementations
- **upcase** - String transformation benchmark (uppercase conversion)
- **words_diamond** - Word processing diamond pattern benchmark with timely implementation

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench futures
```

Run only timely/differential benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
```

Run benchmarks with timely/differential implementations:
```bash
# Timely benchmarks
cargo bench -p benches -- timely

# Differential-dataflow benchmarks
cargo bench -p benches -- differential
```

## Performance Comparison

To compare performance with Hydro-native implementations:

1. Run benchmarks in this repository to get timely/differential-dataflow performance
2. Run benchmarks in the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) to get Hydro-native performance
3. Compare the results from both repositories

### Benchmark Results Location

Criterion saves benchmark results in `target/criterion/` directory with HTML reports:
- Open `target/criterion/report/index.html` to view all benchmark results
- Individual benchmark reports are available in `target/criterion/<benchmark_name>/report/index.html`

### Comparing Across Runs

To compare benchmark results over time:
```bash
# Run baseline benchmarks
cargo bench -p benches

# Make changes, then run again
cargo bench -p benches

# Criterion will automatically compare with previous results
```

## Data Files

This directory includes several test data files:

- **words_alpha.txt** - Word list for words_diamond benchmark (from [dwyl/english-words](https://github.com/dwyl/english-words))
- **reachability_edges.txt** - Graph edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for verification

## Build Configuration

The `build.rs` script generates code for the fork_join benchmark at build time. Generated files are ignored in version control (see `.gitignore`).

## Dependencies

This benchmark suite requires:
- **timely-master** (version 0.13.0-dev.1) - Timely dataflow engine
- **differential-dataflow-master** (version 0.13.0-dev.1) - Differential dataflow engine
- **dfir_rs** - Hydro's DFIR implementation (from main repository)
- **criterion** - Benchmarking framework with HTML reports
- **tokio** - Async runtime for futures benchmarks
- **rand** - Random number generation for micro_ops benchmarks

## Independent Execution

All benchmarks in this repository can run independently without the main Hydro repository. The benchmarks are self-contained and include all necessary test data and dependencies.

To verify independent execution:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo build
cargo bench
```

## Benchmark Implementation Details

### Timely Dataflow Benchmarks
Each benchmark with a `timely` variant demonstrates:
- Timely dataflow setup and execution
- Operator composition (map, filter, inspect, etc.)
- Stream processing patterns
- Progress tracking and completion

### Differential Dataflow Benchmarks
Benchmarks with `differential` variants show:
- Collection-based incremental computation
- Join operations on differential collections
- Iterative computations with fixed-point semantics
- Efficient handling of data changes

### Hydro DFIR Benchmarks
Hydro-specific implementations demonstrate:
- Surface syntax for dataflow specification
- Compiled execution paths
- Async/await integration
- Custom operator implementations

## Notes

- These benchmarks are maintained separately from the main Hydro repository to avoid imposing timely/differential-dataflow as build dependencies
- The Hydro-native implementations remain in the main repository for faster development iteration
- Performance comparison functionality is fully retained through this cross-repository approach
- All benchmarks include multiple implementation variants for fair comparison
- Criterion's statistical analysis helps identify meaningful performance differences
