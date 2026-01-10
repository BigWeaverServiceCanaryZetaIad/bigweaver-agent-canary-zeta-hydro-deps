# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external packages like timely and differential-dataflow, which have been moved from the main bigweaver-agent-canary-hydro-zeta repository to keep the main codebase cleaner and prevent dependency bloat.

## Contents

### Benchmarks

The `benches` directory contains performance benchmarks that use timely and differential-dataflow:

- **arithmetic.rs**: Arithmetic operation benchmarks using timely
- **fan_in.rs**: Fan-in pattern benchmarks using timely
- **fan_out.rs**: Fan-out pattern benchmarks using timely
- **fork_join.rs**: Fork-join pattern benchmarks using timely
- **identity.rs**: Identity operation benchmarks using timely
- **join.rs**: Join operation benchmarks using timely
- **reachability.rs**: Reachability benchmarks using differential-dataflow
- **upcase.rs**: Uppercase transformation benchmarks using timely

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

The benchmarks depend on:
- `timely-master`: Timely dataflow system
- `differential-dataflow-master`: Differential dataflow computation framework
- `dfir_rs`: Core DFIR functionality (from main repository via git)
- `sinktools`: Sink utilities (from main repository via git)