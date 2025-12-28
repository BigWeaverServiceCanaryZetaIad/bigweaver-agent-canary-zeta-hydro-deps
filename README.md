# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that depend on external dataflow frameworks like Timely Dataflow and Differential Dataflow.

## Benchmarks

The `benches/` directory contains performance benchmarks comparing Hydro/DFIR with other dataflow frameworks.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench fork_join
```

### Available Benchmarks

- **arithmetic** - Arithmetic operations benchmarks
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **futures** - Async futures benchmarks
- **identity** - Identity/passthrough operation benchmarks
- **join** - Join operation benchmarks
- **micro_ops** - Micro-operation benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- **reachability** - Graph reachability benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **upcase** - String uppercase transformation benchmarks
- **words_diamond** - Diamond pattern with word processing benchmarks

### Dependencies

These benchmarks depend on:
- **timely-master** - Timely Dataflow framework
- **differential-dataflow-master** - Differential Dataflow framework
- **dfir_rs** - DFIR runtime (from main Hydro repository)
- **sinktools** - Sink utilities (from main Hydro repository)

Note: The benchmarks reference `dfir_rs` and `sinktools` from the main bigweaver-agent-canary-hydro-zeta repository via path dependencies.
