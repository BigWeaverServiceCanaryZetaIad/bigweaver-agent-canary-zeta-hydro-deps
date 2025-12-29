# Hydro Dependencies - Benchmarks Repository

This repository contains benchmarks that compare Hydro/DFIR performance with Timely Dataflow and Differential Dataflow frameworks.

## Purpose

This repository was created to separate heavy dependencies (timely and differential-dataflow) from the main Hydro repository, allowing:
- Cleaner separation of concerns
- Independent execution of comparison benchmarks
- Reduced dependency weight in the main Hydro codebase

## Contents

- **benches/** - Benchmark suite comparing Hydro with Timely and Differential Dataflow

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run specific benchmark suites:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench arithmetic
```

For more information, see the [benchmarks README](benches/README.md).

## Dependencies

This repository depends on:
- **dfir_rs** - Hydro dataflow library (via git)
- **timely-master** - Timely Dataflow framework
- **differential-dataflow-master** - Differential Dataflow framework
- **sinktools** - Hydro utilities (via git)

## Performance Comparison

The benchmarks provide statistical performance comparisons using the Criterion framework, helping to:
- Track Hydro performance improvements over time
- Validate competitive performance against established dataflow systems
- Identify optimization opportunities