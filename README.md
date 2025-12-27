# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for comparing DFIR/Hydro with other dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Benchmarks

The benchmarks in this repository compare the performance of DFIR/Hydro operations against equivalent implementations in Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity operation benchmarks
- **upcase**: String uppercasing benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability algorithm benchmarks
- **micro_ops**: Micro-operations benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks
- **futures**: Future-based operations benchmarks

## Dependencies

This repository depends on:
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)
- `dfir_rs` from the bigweaver-agent-canary-hydro-zeta repository
- `sinktools` from the bigweaver-agent-canary-hydro-zeta repository

These dependencies are isolated in this repository to prevent dependency bloat in the main service codebase.
