# Hydro Benchmarks - Timely and Differential Dataflow

This repository contains performance benchmarks for Hydro that depend on `timely` and `differential-dataflow`. These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the core codebase free of these heavyweight dependencies.

## Purpose

The benchmarks in this repository enable:
- Performance comparisons between Hydro and timely/differential-dataflow implementations
- Regression testing for Hydro performance
- Validation that Hydro maintains competitive performance characteristics

## Prerequisites

To run these benchmarks, you need both repositories cloned in the same parent directory:

```bash
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Benchmarks

From this directory, run benchmarks using cargo:

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench arithmetic

# Run benchmarks with baseline comparison
cargo bench --bench arithmetic -- --save-baseline my-baseline
```

## Available Benchmarks

- **arithmetic**: Basic arithmetic operations and pipeline performance
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance  
- **fork_join**: Fork-join pattern performance
- **futures**: Async futures integration performance
- **identity**: Identity/passthrough performance
- **join**: Join operation performance
- **micro_ops**: Micro-operation performance
- **reachability**: Graph reachability algorithm performance
- **symmetric_hash_join**: Symmetric hash join performance
- **upcase**: String transformation performance
- **words_diamond**: Diamond pattern with word processing

## Dependencies

This repository depends on:
- `timely` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository

## Maintenance

When updating these benchmarks:
1. Ensure compatibility with the current Hydro API
2. Update timely/differential-dataflow versions as needed
3. Run benchmarks to verify no regressions
4. Document any significant performance changes