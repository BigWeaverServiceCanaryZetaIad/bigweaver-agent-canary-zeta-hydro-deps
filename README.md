# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare Hydro performance against Timely Dataflow and Differential Dataflow. These benchmarks were moved here from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the dependencies on `timely` and `differential-dataflow` packages.

## Benchmarks

The following benchmarks are included:

### Timely Dataflow Comparisons
- **arithmetic.rs** - Arithmetic operations benchmark
- **fan_in.rs** - Fan-in pattern benchmark
- **fan_out.rs** - Fan-out pattern benchmark
- **fork_join.rs** - Fork-join pattern benchmark
- **identity.rs** - Identity operation benchmark
- **join.rs** - Join operation benchmark
- **upcase.rs** - String uppercase benchmark

### Differential Dataflow Comparisons
- **reachability.rs** - Graph reachability benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
```

## Purpose

This separation ensures that the main Hydro codebase remains clean and doesn't carry unnecessary dependencies on competing dataflow frameworks. Developers who need to run performance comparisons can work with this repository independently.