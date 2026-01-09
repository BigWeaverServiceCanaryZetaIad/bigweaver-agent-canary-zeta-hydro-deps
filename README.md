# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark implementations that depend on `timely` and `differential-dataflow` packages. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate these dependencies and keep the main codebase lean.

## Benchmarks

This repository includes the following benchmarks:

- **fan_in.rs**: Benchmark for fan-in dataflow patterns using Timely
- **join.rs**: Benchmark for join operations using Timely  
- **reachability.rs**: Benchmark for graph reachability using both Timely and Differential Dataflow
- **upcase.rs**: Benchmark for string uppercasing operations using Timely

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench fan_in
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

## Dependencies

- `timely-master`: v0.13.0-dev.1
- `differential-dataflow-master`: v0.13.0-dev.1
- `criterion`: v0.5.0 (for benchmarking framework)

## Performance Comparisons

These benchmarks can be used to compare performance characteristics of Timely and Differential Dataflow against other dataflow implementations. The benchmarks use the Criterion framework for statistical analysis and HTML report generation.