# Hydro Dependencies Benchmarks

This repository contains benchmarks that depend on timely and differential-dataflow packages.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid including timely and differential-dataflow as direct dependencies in the main repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench join
```

## Benchmarks Included

- **arithmetic.rs** - Arithmetic operations benchmark using timely
- **fan_in.rs** - Fan-in pattern benchmark using timely
- **fan_out.rs** - Fan-out pattern benchmark using timely
- **fork_join.rs** - Fork-join pattern benchmark using timely
- **identity.rs** - Identity operation benchmark using timely
- **join.rs** - Join operation benchmark using timely
- **reachability.rs** - Graph reachability benchmark using differential-dataflow
- **upcase.rs** - Upcase operation benchmark using timely
