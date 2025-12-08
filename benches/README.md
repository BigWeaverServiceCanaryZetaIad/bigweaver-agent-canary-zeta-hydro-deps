# Timely and Differential-Dataflow Benchmarks

Benchmarks for Hydro that depend on timely and differential-dataflow.

These benchmarks have been separated from the main Hydro repository to avoid having timely and differential-dataflow as dependencies in the main repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench upcase
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

## Benchmark List

### Timely Benchmarks
- **arithmetic**: Arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **upcase**: String uppercase benchmark
- **join**: Join operation benchmark

### Differential-Dataflow Benchmarks
- **reachability**: Graph reachability benchmark using differential-dataflow

## Migration from Main Repository

These benchmarks were originally part of the main bigweaver-agent-canary-hydro-zeta repository but were moved to this separate repository to:
1. Keep timely and differential-dataflow dependencies separate from the main codebase
2. Maintain the ability to run performance comparisons
3. Reduce unnecessary dependencies in the main repository

For other Hydro benchmarks (that do not depend on timely/differential-dataflow), see the main repository.
