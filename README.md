# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark files and dependencies for the Hydro project, specifically for comparing DFIR performance with timely and differential-dataflow frameworks.

## Structure

* `benches` - Microbenchmarks comparing DFIR with other dataflow frameworks (timely and differential-dataflow). Includes implementations for all three frameworks (DFIR, Timely, and Differential) side-by-side for direct comparison.
* `timely-differential-benches` - Standalone benchmarks for Timely and Differential Dataflow frameworks only (without DFIR). These provide baseline performance measurements for comparison purposes.

## Running Benchmarks

### DFIR Comparison Benchmarks

Run all DFIR comparison benchmarks:
```bash
cargo bench -p benches
```

Run specific DFIR comparison benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

### Timely/Differential Standalone Benchmarks

Run all Timely/Differential standalone benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific Timely/Differential benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
```

### Run All Benchmarks

To run all benchmarks across both packages:
```bash
cargo bench
```

## Dependencies

The benchmarks depend on:
- `timely` (package: timely-master) - Core Timely Dataflow framework
- `differential-dataflow` (package: differential-dataflow-master) - Differential Dataflow framework
- `dfir_rs` (from the main Hydro repository) - Required by the `benches` package for DFIR comparisons
- `sinktools` (from the main Hydro repository) - Required by the `benches` package
- `criterion` - Statistics-driven benchmarking library

## Package Details

### benches
Contains comprehensive benchmarks that include implementations using DFIR, Timely, and Differential Dataflow. These benchmarks allow for direct performance comparisons between the frameworks on identical workloads.

### timely-differential-benches
Contains benchmarks focusing exclusively on Timely and Differential Dataflow implementations. This package is useful for:
- Establishing baseline performance metrics without DFIR overhead
- Testing Timely/Differential implementations independently
- Easier maintenance of framework-specific code

## Note

This repository was created to separate benchmark dependencies (timely and differential-dataflow) from the main Hydro repository while maintaining the ability to run performance comparisons. The separation into two packages (`benches` and `timely-differential-benches`) provides flexibility in how benchmarks are organized and executed.

