# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison code for Hydro/DFIR with timely-dataflow and differential-dataflow dependencies.

## Structure

- `benches/` - Microbenchmarks comparing Hydro/DFIR performance against timely-dataflow and differential-dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

## Available Benchmarks

The following benchmarks are available:

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Multiple inputs converging to single output
- **fan_out** - Single input splitting to multiple outputs
- **fork_join** - Fork-join parallelism patterns
- **futures** - Async futures benchmarks
- **identity** - Identity transformation benchmarks
- **join** - Join operation benchmarks
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability algorithms (comparing Hydro/DFIR vs timely vs differential-dataflow)
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **upcase** - String uppercase transformation benchmarks
- **words_diamond** - Word processing diamond pattern

## Dependencies

This repository depends on:
- `timely-master` (v0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository

## Performance Comparison

The benchmarks in this repository enable performance comparison between:
1. Hydro/DFIR implementations
2. Timely dataflow implementations
3. Differential dataflow implementations

This allows for empirical validation of Hydro/DFIR's performance characteristics relative to established dataflow frameworks.
