# Pure Timely and Differential Dataflow Benchmarks

This directory contains pure implementations of benchmarks using only Timely and Differential Dataflow frameworks, without Hydro comparisons. These benchmarks serve as baseline performance measurements and reference implementations.

## Purpose

This separate benchmark suite was created to:
- Provide clean baseline performance measurements for Timely and Differential Dataflow
- Enable isolated testing of timely/differential implementations
- Serve as reference implementations for comparison purposes
- Reduce complexity by separating concerns from the main benchmark suite

## Running Benchmarks

### All Benchmarks
```bash
cargo bench -p timely-differential-benches
```

### Individual Benchmarks
```bash
# Graph reachability benchmark
cargo bench -p timely-differential-benches --bench reachability

# Join operations benchmark
cargo bench -p timely-differential-benches --bench join

# Arithmetic operations benchmark
cargo bench -p timely-differential-benches --bench arithmetic
```

## Available Benchmarks

### reachability
Graph reachability computation using Timely and Differential Dataflow implementations.
- **Timely**: Feedback loop-based reachability
- **Differential**: Incremental iterative computation

### join
Hash join operations comparing different data types:
- **usize/usize**: Integer key-value joins
- **String/String**: String key-value joins

### arithmetic
Arithmetic pipeline operations (20 sequential additions):
- **Timely**: Map-based arithmetic pipeline

### fan_in
Fan-in pattern merging multiple streams:
- **Timely**: Concatenation of multiple input streams

### fan_out
Fan-out pattern distributing to multiple consumers:
- **Timely**: Multiple cloned stream consumers

### fork_join
Fork-join pattern with conditional routing:
- **Timely**: Filter and concatenate operations

### identity
Identity transformation (passthrough operations):
- **Timely**: Sequential map operations with black_box

### upcase
String transformation operations:
- **upcase_in_place**: In-place ASCII uppercase
- **upcase_allocating**: Allocating Unicode uppercase
- **concatting**: String concatenation

## Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - Word list for string-based benchmarks

## Dependencies

This benchmark suite depends only on:
- **timely**: Timely dataflow framework (timely-master)
- **differential-dataflow**: Differential dataflow framework (differential-dataflow-master)
- **criterion**: Benchmarking framework with statistics
- **seq-macro**: Macro for sequence generation
- **static_assertions**: Compile-time assertions
- **rand**: Random number generation

## Comparing with Hydro

To compare these baseline measurements with Hydro implementations:

1. Run these pure timely/differential benchmarks:
   ```bash
   cargo bench -p timely-differential-benches
   ```

2. Run the full comparison benchmarks (in `benches/`):
   ```bash
   cargo bench -p benches
   ```

3. Compare results using Criterion's HTML reports in `target/criterion/`

## Related Documentation

- Main benchmark suite: [../benches/README.md](../benches/README.md)
- Performance comparison guide: [../PERFORMANCE_COMPARISON.md](../PERFORMANCE_COMPARISON.md)
- Timely Dataflow: [TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- Differential Dataflow: [TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
