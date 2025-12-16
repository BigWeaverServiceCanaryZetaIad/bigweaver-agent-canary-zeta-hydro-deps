# Hydro Benchmarks

This repository contains performance benchmarks for Hydro, including comparisons with timely-dataflow and differential-dataflow.

## Overview

This repository was created to separate benchmark dependencies (timely and differential-dataflow) from the main Hydro repository, allowing for cleaner dependency management and focused performance testing.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
```

Run with specific criterion options:
```bash
cargo bench -- --verbose
```

## Available Benchmarks

- **reachability**: Graph reachability benchmark comparing Hydro with differential-dataflow
- **arithmetic**: Basic arithmetic operations
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operation benchmark
- **micro_ops**: Micro-operation benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmark
- **upcase**: String uppercase operation benchmark
- **words_diamond**: Diamond pattern word processing benchmark
- **futures**: Futures-based operations benchmark

## Dependencies

The benchmarks depend on:
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository
- `timely-dataflow` for performance comparisons
- `differential-dataflow` for performance comparisons

## Notes

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
