# Microbenchmarks

Benchmarks that depend on `timely` and `differential-dataflow` packages, moved from bigweaver-agent-canary-hydro-zeta.

## Included Benchmarks

These benchmarks compare performance of Hydro/DFIR operations against timely dataflow and differential-dataflow:

- **arithmetic.rs** - Arithmetic operations using timely dataflow
- **fan_in.rs** - Fan-in pattern with timely dataflow
- **fan_out.rs** - Fan-out pattern with timely dataflow
- **fork_join.rs** - Fork-join pattern with timely dataflow
- **identity.rs** - Identity operations with timely dataflow
- **join.rs** - Hash join operations using timely dataflow (pure timely, no DFIR comparison)
- **reachability.rs** - Graph reachability using differential-dataflow
- **upcase.rs** - String transformation using timely dataflow (pure timely, no DFIR comparison)

## Running Benchmarks

Run all benchmarks:
```
cargo bench
```

Run specific benchmarks:
```
cargo bench --bench reachability
cargo bench --bench join
```

## Dependencies

These benchmarks depend on:
- `timely-master` (v0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` (git dependency) - For comparison benchmarks
- `sinktools` (git dependency) - For compiled benchmarks

The `dfir_rs` and `sinktools` dependencies are sourced from the bigweaver-agent-canary-hydro-zeta repository via git.

