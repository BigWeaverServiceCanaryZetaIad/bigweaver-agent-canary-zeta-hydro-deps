# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependencies and benchmarks for the bigweaver-agent-canary-hydro-zeta project.

## Benchmarks

The `benches` directory contains performance benchmarks for comparing various dataflow implementations:

### Timely and Differential Dataflow Benchmarks

The following benchmarks use timely and differential-dataflow dependencies:

- **fan_in.rs**: Benchmark comparing fan-in operations across dfir_rs, timely, iterators, and raw loops
- **fork_join.rs**: Benchmark comparing fork-join patterns across dfir_rs, timely, and raw implementations
- **reachability.rs**: Graph reachability benchmark using differential-dataflow operators

### Running Benchmarks

To run the benchmarks:

```bash
cd benches
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench fan_in
cargo bench --bench fork_join
cargo bench --bench reachability
```

### Performance Comparison

These benchmarks enable performance comparisons between:
- dfir_rs (Hydro's dataflow system)
- Timely Dataflow
- Differential Dataflow
- Raw Rust implementations

The benchmarks use the Criterion benchmarking framework with async tokio support and HTML report generation.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta): Main project repository