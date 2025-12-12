# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare Hydro with timely and differential-dataflow.

## Purpose

To avoid having timely and differential-dataflow as dependencies in the main 
[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) 
repository, these benchmarks have been moved to this separate repository.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro's performance with 
timely and differential-dataflow implementations:

- **arithmetic**: Arithmetic operations performance
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance
- **fork_join**: Fork-join pattern performance
- **futures**: Futures handling performance
- **identity**: Identity operations performance
- **join**: Join operations performance
- **micro_ops**: Micro-operations performance
- **reachability**: Reachability algorithm performance
- **symmetric_hash_join**: Symmetric hash join performance
- **upcase**: String upper-casing performance
- **words_diamond**: Diamond pattern with word processing

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability

# Run all benchmarks in the benches package
cargo bench -p benches
```

## Cross-Repository Comparison

For instructions on comparing performance between this repository and the main 
bigweaver-agent-canary-hydro-zeta repository, see the benchmark documentation 
in the main repository.