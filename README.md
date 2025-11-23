# bigweaver-agent-canary-zeta-hydro-deps

This repository contains timely and differential-dataflow benchmarks that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate these dependencies and reduce the dependency footprint in the main codebase.

## Contents

- **benches/**: Performance benchmarks comparing Hydro with timely and differential-dataflow frameworks
- **sinktools/**: Utility crate for benchmark support

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Available Benchmarks

The following benchmarks are available for performance comparison:

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in dataflow patterns
- **fan_out**: Fan-out dataflow patterns
- **fork_join**: Fork-join computation patterns
- **futures**: Async futures processing
- **identity**: Identity transformation operations
- **join**: Stream join operations
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability computations
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String transformation operations
- **words_diamond**: Diamond-shaped dataflow patterns

Each benchmark compares implementations across different frameworks (Hydro, timely, differential-dataflow) to measure performance characteristics.

## Dependencies

This repository depends on:
- `dfir_rs` from the main hydro repository (via git dependency)
- `timely` and `differential-dataflow` for framework comparisons
- `criterion` for benchmark harness

## Migration Notes

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` to maintain clean separation between core functionality and framework comparison dependencies. This isolation helps:

- Reduce compilation times for the main repository
- Keep the main repository's dependency tree clean
- Provide a dedicated space for performance comparisons with external frameworks
- Maintain the ability to run performance comparisons when needed