# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for Hydro, comparing implementations using dfir_rs, timely-dataflow, and differential-dataflow.

## Purpose

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to:
- Isolate timely and differential-dataflow dependencies
- Allow independent performance testing
- Reduce the dependency footprint of the main repository

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

## Available Benchmarks

- **arithmetic**: Compares arithmetic operations across different frameworks
- **identity**: Tests identity operations
- **reachability**: Graph reachability algorithm comparisons using differential-dataflow
- **join**: Join operations
- **symmetric_hash_join**: Symmetric hash join comparisons
- **fan_in**: Fan-in operation benchmarks
- **fan_out**: Fan-out operation benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **micro_ops**: Micro-operation benchmarks
- **upcase**: String transformation benchmarks
- **words_diamond**: Diamond pattern benchmarks
- **futures**: Async futures benchmarks

## Contents

This repository includes:
- `benches/`: Benchmark suite with criterion-based benchmarks
- Supporting Hydro crates: `dfir_rs`, `dfir_lang`, `dfir_macro`, `sinktools`, `lattices`, `variadics`

## Benchmark Interpretation

The benchmarks provide performance comparisons between:
- **dfir_rs**: Hydro's dataflow implementation
- **timely**: TimelyDataflow implementation
- **differential**: Differential-dataflow implementation

Results help identify performance characteristics and optimization opportunities for Hydro.
