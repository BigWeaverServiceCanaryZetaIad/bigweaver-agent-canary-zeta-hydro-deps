# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

These benchmarks were migrated from the main repository to separate the timely and differential-dataflow dependencies from the core codebase while maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
cargo bench -p timely-differential-benches --bench zip
```

## Benchmark Descriptions

- **arithmetic** - Arithmetic operations benchmark comparing different dataflow frameworks
  - Tests repeated arithmetic operations (20 map operations)
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow
  - Dataset: 1,000,000 integers
  
- **fan_in** - Fan-in pattern benchmark for data aggregation
  - Tests merging multiple input streams into one
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow
  
- **fan_out** - Fan-out pattern benchmark for data distribution
  - Tests splitting one stream into multiple outputs
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow
  
- **fork_join** - Fork-join pattern benchmark
  - Tests parallel processing with synchronization
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow
  
- **identity** - Identity operation benchmark (data pass-through)
  - Tests minimal overhead of dataflow frameworks
  - Uses black_box to prevent compiler optimizations
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow
  
- **join** - Join operation benchmark
  - Tests joining two data streams
  - Supports both usize and String join keys
  - Dataset: 100,000 elements per stream
  - Compares: Timely, Babyflow, Spinachflow
  
- **reachability** - Graph reachability computation benchmark
  - Tests iterative graph algorithms
  - Uses real graph data from included text files
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow
  
- **upcase** - String uppercase transformation benchmark
  - Tests string processing operations
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow
  
- **zip** - Zip operation benchmark
  - Tests combining two streams element-wise
  - Compares: Timely, Babyflow, Hydroflow, Spinachflow

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Cross-Repository Comparison

To compare performance between this repository and the main repository, use the comparison script in the parent directory:

```bash
cd ..
./scripts/compare_benchmarks.sh
```

## Framework Coverage

Each benchmark tests different dataflow implementations:

- **Timely-dataflow**: All benchmarks include timely implementations
- **Babyflow**: Most benchmarks (via path dependency to main repo)
- **Hydroflow**: Several benchmarks (via path dependency to main repo)
- **Spinachflow**: Several benchmarks (via path dependency to main repo)
- **Differential-dataflow**: Available as dependency for future incremental computation benchmarks

## Output Example

When running benchmarks, you'll see output similar to:

```
arithmetic/timely         time:   [10.234 ms 10.456 ms 10.678 ms]
arithmetic/babyflow       time:   [12.123 ms 12.345 ms 12.567 ms]
arithmetic/hydroflow      time:   [11.456 ms 11.678 ms 11.890 ms]
```

Detailed HTML reports are generated in `target/criterion/report/index.html`.
