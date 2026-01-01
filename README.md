# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been separated from the main repository to avoid including certain dependencies there.

## Benchmarks

The `benches` directory contains microbenchmarks for DFIR and other dataflow frameworks including Timely Dataflow and Differential Dataflow.

### Running Benchmarks

From the parent directory containing both repositories, run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench join
```

### Available Benchmarks

- **reachability**: Graph reachability algorithms
- **join**: Join operations with different data types
- **fan_in**: Fan-in operations
- **fan_out**: Fan-out operations
- **fork_join**: Fork-join patterns
- **micro_ops**: Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- **symmetric_hash_join**: Symmetric hash join operations
- **words_diamond**: Diamond pattern word processing
- **arithmetic**: Arithmetic operations
- **identity**: Identity operations
- **upcase**: Uppercase transformations
- **futures**: Async futures benchmarks

See `benches/README.md` for more details.
