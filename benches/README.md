# Hydro Benchmarks with Timely/Differential-Dataflow Dependencies

This repository contains performance benchmarks that compare Hydro implementations with Timely Dataflow and Differential Dataflow.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the `timely` and `differential-dataflow` dependencies. This separation:

- Reduces build dependencies and improves build times for the main repository
- Maintains the ability to run performance comparisons between Hydro and Timely/Differential implementations
- Keeps all performance comparison functionality accessible in a dedicated repository

## Benchmarks Included

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks  
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Reachability computation benchmarks
- **upcase**: String case conversion benchmarks

## Running Benchmarks

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run a specific benchmark:
```bash
cd benches
cargo bench --bench reachability
```

Run benchmarks with specific configurations:
```bash
cd benches
cargo bench --bench arithmetic -- --verbose
```

## Dependencies

These benchmarks depend on:
- `timely-master`: For Timely Dataflow comparisons
- `differential-dataflow-master`: For Differential Dataflow comparisons
- `dfir_rs`: Referenced from the main Hydro repository for Hydro implementations
- `sinktools`: Referenced from the main Hydro repository for utilities

## Notes

- Wordlist for string benchmarks is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Reachability test data is included in the `benches/` directory
