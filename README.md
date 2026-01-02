# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely and differential-dataflow packages.

## Benchmarks

This repository includes performance comparison benchmarks for:
- Timely Dataflow
- Differential Dataflow
- DFIR/Hydro implementations

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench arithmetic
```

### Benchmark List

The following benchmarks are included:
- **reachability** - Graph reachability algorithms (uses timely and differential_dataflow)
- **fan_out** - Fan-out dataflow patterns (uses timely)
- **arithmetic** - Arithmetic operations (uses timely)
- **fan_in** - Fan-in dataflow patterns (uses timely)
- **fork_join** - Fork-join patterns (uses timely)
- **identity** - Identity operations (uses timely)
- **join** - Join operations (uses timely)
- **upcase** - String uppercase operations (uses timely)

## Dependencies

This repository maintains dependencies on:
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `dfir_rs` (from bigweaver-agent-canary-hydro-zeta repository)
- `sinktools` (from bigweaver-agent-canary-hydro-zeta repository)