# Timely/Differential-Dataflow Comparison Benchmarks

This directory contains benchmarks comparing DFIR with timely-dataflow and differential-dataflow. These benchmarks have been moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid adding unnecessary dependencies to the core project.

## Purpose

These benchmarks allow for performance comparisons between DFIR and other dataflow frameworks. They include implementations of various dataflow patterns using both DFIR and timely/differential-dataflow.

## Available Benchmarks

- **arithmetic**: Tests arithmetic operations in dataflow pipelines
- **fan_in**: Tests fan-in dataflow patterns (multiple inputs merging)
- **fan_out**: Tests fan-out dataflow patterns (single input to multiple outputs)
- **fork_join**: Tests fork-join patterns with parallel branches
- **identity**: Tests identity operations (passthrough with minimal overhead)
- **join**: Tests join operations between streams
- **reachability**: Tests graph reachability algorithms
- **upcase**: Tests string transformation operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

Run a specific benchmark function:
```bash
cargo bench -p benches --bench arithmetic -- "arithmetic/dfir"
```

## Dependencies

These benchmarks depend on:
- `dfir_rs` - from the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - from the main bigweaver-agent-canary-hydro-zeta repository
- `timely-master` - the timely-dataflow framework
- `differential-dataflow-master` - the differential-dataflow framework
- `criterion` - for benchmark harness

## Performance Comparison

To compare DFIR performance with timely/differential-dataflow:

1. Clone this repository
2. Run the benchmarks: `cargo bench -p benches`
3. View the results in `target/criterion/` directory
4. HTML reports are generated for each benchmark showing performance comparisons

## Cross-Repository Benchmarking

For DFIR-native benchmarks (without timely/differential-dataflow comparisons), see the main repository at [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) under the `benches/` directory.

Those benchmarks include:
- futures
- micro_ops
- symmetric_hash_join
- words_diamond

## Data Files

Some benchmarks require data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Build Configuration

The `build.rs` file generates additional benchmark code at compile time for certain benchmarks (e.g., fork_join).
