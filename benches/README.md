# Timely and Differential-Dataflow Microbenchmarks

This repository contains benchmarks that compare Hydro/DFIR performance with Timely Dataflow and Differential Dataflow.

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on timely and differential-dataflow packages.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench identity
```

## Available Benchmarks

- **arithmetic** - Performance comparison of arithmetic operations across different frameworks
- **fan_in** - Fan-in dataflow pattern benchmarks
- **fan_out** - Fan-out dataflow pattern benchmarks
- **fork_join** - Fork-join dataflow pattern benchmarks
- **identity** - Identity operation benchmarks
- **join** - Join operation benchmarks
- **reachability** - Graph reachability algorithm benchmarks (uses differential-dataflow)
- **upcase** - String uppercase conversion benchmarks

## Performance Comparison

These benchmarks enable performance comparison between:
- Hydro/DFIR implementations
- Timely Dataflow implementations
- Differential Dataflow implementations
- Raw iterator implementations
- Other baseline implementations

Results help track performance characteristics and regressions across different dataflow systems.
