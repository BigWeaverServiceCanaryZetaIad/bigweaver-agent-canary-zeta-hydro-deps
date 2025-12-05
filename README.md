# Hydro Timely/Differential-Dataflow Benchmarks

This repository contains performance comparison benchmarks for Hydro (dfir_rs) against timely-dataflow and differential-dataflow. These benchmarks were moved from the main Hydro repository to avoid including timely and differential-dataflow as dependencies in the main codebase.

## Purpose

These benchmarks allow us to:
- Compare Hydro's performance against timely and differential-dataflow
- Track performance regressions over time
- Validate optimization improvements in Hydro

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench identity
```

## Available Benchmarks

- **arithmetic**: Chain of arithmetic operations
- **fan_in**: Multiple inputs merging into one stream
- **fan_out**: One stream splitting into multiple outputs
- **fork_join**: Fork-join pattern with multiple parallel operations
- **futures**: Async futures-based operations
- **identity**: Simple identity/passthrough operations
- **join**: Stream join operations
- **micro_ops**: Microbenchmarks of various operators
- **reachability**: Graph reachability computation
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String uppercase transformation
- **words_diamond**: Diamond-shaped dataflow pattern with word processing

## Data Sources

- Wordlist is from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- Graph data for reachability benchmarks is included in this repository

## Dependencies

This repository depends on:
- `dfir_rs` and `sinktools` from the main [Hydro repository](https://github.com/hydro-project/hydro)
- `timely-dataflow` and `differential-dataflow` for comparison benchmarks
- `criterion` for benchmark harness

## Contributing

For changes to these benchmarks, please follow the contribution guidelines in the main Hydro repository.
