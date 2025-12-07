# Hydro Benchmarks with Timely/Differential-Dataflow Dependencies

This directory contains benchmarks that compare Hydro's performance with Timely Dataflow and Differential Dataflow. These benchmarks have been moved to this separate repository to prevent timely and differential-dataflow dependencies from being pulled into the main Hydro repository.

## Benchmarks Included

This repository contains the following benchmarks:

- **arithmetic.rs** - Arithmetic operations comparison
- **fan_in.rs** - Fan-in pattern comparison with Timely
- **fan_out.rs** - Fan-out pattern comparison with Timely
- **fork_join.rs** - Fork-join pattern comparison
- **identity.rs** - Identity/passthrough operation comparison
- **join.rs** - Join operations comparison with Timely
- **reachability.rs** - Graph reachability comparison with Timely and Differential
- **upcase.rs** - String uppercase transformation comparison with Timely

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench reachability
```

## Performance Comparison

These benchmarks allow direct performance comparisons between:
- Hydro (dfir_rs)
- Timely Dataflow
- Differential Dataflow

Results are generated using the Criterion benchmarking framework and include detailed HTML reports in `target/criterion/`.

## Integration with Main Repository

While these benchmarks are maintained separately, they can still be used for performance testing and comparison during Hydro development. To use these benchmarks:

1. Clone both repositories side-by-side
2. Run benchmarks from this repository
3. Compare results with pure Hydro benchmarks in the main repository

## Dependencies

This package intentionally depends on:
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)
- `dfir_rs` from the main Hydro repository (via git dependency)
- `sinktools` from the main Hydro repository (via git dependency)

These dependencies are kept separate to maintain a clean dependency tree in the main Hydro project.
