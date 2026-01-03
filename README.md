# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison code for the Hydro project.

## Benchmarks

The `benches/` directory contains microbenchmarks comparing Hydro/DFIR with other dataflow frameworks including Timely Dataflow and Differential Dataflow.

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

The benchmarks include:
- **reachability**: Graph reachability algorithms comparing Hydro, Timely, and Differential implementations
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- **arithmetic**: Arithmetic operation benchmarks
- **fan_in** / **fan_out**: Fan-in and fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity operation benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks
- **upcase**: String uppercase benchmarks
- **futures**: Async futures benchmarks

### Dependencies

The benchmarks depend on:
- `dfir_rs`: The core DFIR implementation (from the main Hydro repository)
- `timely-master`: Timely Dataflow for performance comparison
- `differential-dataflow-master`: Differential Dataflow for performance comparison
- `criterion`: Statistics-driven benchmarking library

### Note on Path Dependencies

The benchmarks reference `dfir_rs` and `sinktools` via relative path dependencies pointing to the main Hydro repository. Ensure both repositories are available in your workspace for successful builds.