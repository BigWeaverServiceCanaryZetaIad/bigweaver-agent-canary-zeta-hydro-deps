# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow dependencies that were moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Benchmarks

The following benchmarks are included:

- **reachability** - Benchmarks for graph reachability algorithms using both timely and differential-dataflow
- **fork_join** - Benchmarks for fork-join patterns using timely

And additional benchmarks that compare hydroflow implementations with timely:

- **arithmetic** - Arithmetic operations benchmarks
- **fan_in** - Fan-in pattern benchmarks  
- **fan_out** - Fan-out pattern benchmarks
- **identity** - Identity operation benchmarks
- **join** - Join operation benchmarks
- **micro_ops** - Micro-operation benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **upcase** - String uppercase benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks
- **futures** - Async futures benchmarks

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench reachability
cargo bench --bench fork_join
```

## Dependencies

These benchmarks depend on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` and `sinktools` from the main hydro repository