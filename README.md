# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow.

## Benchmarks

The benchmarks in this repository specifically compare performance between Hydro and Timely/Differential frameworks:

- `arithmetic.rs` - Arithmetic operations benchmark using Timely
- `fan_in.rs` - Fan-in pattern benchmark using Timely
- `fan_out.rs` - Fan-out pattern benchmark using Timely
- `fork_join.rs` - Fork-join pattern benchmark using Timely
- `identity.rs` - Identity operation benchmark using Timely
- `join.rs` - Join operations benchmark using Timely
- `reachability.rs` - Graph reachability benchmark using Timely and Differential Dataflow
- `upcase.rs` - String uppercase benchmark using Timely

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

These benchmarks depend on:
- `dfir_rs` from the main bigweaver-agent-canary-hydro-zeta repository
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework
