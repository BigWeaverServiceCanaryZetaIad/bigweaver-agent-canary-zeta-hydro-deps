# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner codebase.

## Contents

- **benches/**: Performance benchmarks comparing Hydro with timely/differential-dataflow
- **sinktools/**: Utilities for sink operations
- **variadics/**: Variadic type and macro support

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
```

## Benchmark List

The benchmarks include:
- `arithmetic.rs` - Arithmetic operations comparison
- `join.rs` - Join operations comparison
- `reachability.rs` - Graph reachability algorithms
- `fan_in.rs` - Fan-in patterns
- `fan_out.rs` - Fan-out patterns
- `fork_join.rs` - Fork-join patterns
- `futures.rs` - Async futures benchmarks
- `identity.rs` - Identity operations
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join
- `upcase.rs` - String uppercase operations
- `words_diamond.rs` - Diamond pattern with word processing

## Dependencies

This repository includes:
- `timely` (package = "timely-master", version = "0.13.0-dev.1")
- `differential-dataflow` (package = "differential-dataflow-master", version = "0.13.0-dev.1")