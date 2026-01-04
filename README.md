# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on timely-dataflow and differential-dataflow packages. These benchmarks were moved from the main Hydro repository to maintain separation of concerns and reduce unnecessary dependencies in the main codebase.

## Benchmarks

The following benchmarks are included:

- **arithmetic.rs** - Timely dataflow arithmetic pipeline benchmarks
- **fan_in.rs** - Timely dataflow fan-in pattern benchmarks
- **fan_out.rs** - Timely dataflow fan-out pattern benchmarks
- **fork_join.rs** - Timely dataflow fork-join pattern benchmarks
- **identity.rs** - Timely dataflow identity operation benchmarks
- **join.rs** - Timely dataflow join operation benchmarks
- **reachability.rs** - Differential dataflow graph reachability benchmarks
- **upcase.rs** - Timely dataflow uppercase transformation benchmarks

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Dependencies

These benchmarks depend on:
- `timely-master` (timely-dataflow)
- `differential-dataflow-master` (differential-dataflow)
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository