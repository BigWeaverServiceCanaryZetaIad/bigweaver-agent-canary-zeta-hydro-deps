# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare Hydro performance against [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow).

## Purpose

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the timely and differential-dataflow dependencies. This separation:
- Reduces dependency overhead in the main repository
- Maintains performance comparison capabilities
- Keeps benchmark functionality intact

## Contents

- **benches/**: Microbenchmarks comparing Hydro against Timely and Differential Dataflow
  - `arithmetic.rs`: Basic arithmetic operations
  - `fan_in.rs`: Fan-in dataflow patterns
  - `fan_out.rs`: Fan-out dataflow patterns
  - `fork_join.rs`: Fork-join patterns
  - `identity.rs`: Identity transformations
  - `join.rs`: Join operations with different data types
  - `reachability.rs`: Graph reachability algorithms
  - `upcase.rs`: String transformation operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository depends on:
- **timely-master**: For Timely Dataflow benchmarks
- **differential-dataflow-master**: For Differential Dataflow benchmarks
- **dfir_rs**: Referenced from the main repository for Hydro benchmarks