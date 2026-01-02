# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Hydro that require external frameworks (Timely Dataflow and Differential Dataflow).

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks comparing Hydro (DFIR) with other dataflow frameworks:

- **join.rs** - Timely Dataflow join benchmark
- **fork_join.rs** - Timely fork-join benchmark  
- **reachability.rs** - Differential Dataflow reachability benchmark
- **micro_ops.rs** - Micro-operation benchmarks
- Other benchmark files for various operations

These benchmarks help validate Hydro's performance characteristics against established frameworks.

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

The benchmarks depend on:
- **timely-master** (Timely Dataflow)
- **differential-dataflow-master** (Differential Dataflow)
- **dfir_rs** from the main Hydro repository
- **sinktools** from the main Hydro repository

These dependencies are referenced via relative paths to the `bigweaver-agent-canary-hydro-zeta` repository.