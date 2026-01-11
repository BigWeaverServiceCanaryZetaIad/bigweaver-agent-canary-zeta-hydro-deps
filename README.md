# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project, including timely and differential-dataflow performance tests. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid introducing heavy external dependencies into the core codebase.

## Structure

- `benches/` - Contains all benchmark code and test data

## Prerequisites

To run these benchmarks, you need to have the main `bigweaver-agent-canary-hydro-zeta` repository checked out in a sibling directory:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

The benchmarks reference `dfir_rs` and `sinktools` from the main repository via relative paths.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
```

## Benchmarks Included

### Timely Dataflow Benchmarks
- `fan_out.rs` - Tests fan-out patterns
- `identity.rs` - Tests identity operations
- `fan_in.rs` - Tests fan-in patterns
- `arithmetic.rs` - Tests arithmetic operations
- `fork_join.rs` - Tests fork-join patterns
- `join.rs` - Tests join operations
- `symmetric_hash_join.rs` - Tests symmetric hash join
- `words_diamond.rs` - Tests diamond patterns with word data
- `upcase.rs` - Tests uppercase transformations
- `micro_ops.rs` - Tests micro-operations
- `futures.rs` - Tests futures integration

### Differential Dataflow Benchmarks
- `reachability.rs` - Tests graph reachability algorithms

## Dependencies

The benchmarks use the following external dependencies:
- `timely` (timely-master) - Timely dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential dataflow framework
- `criterion` - Benchmarking framework
- Other supporting libraries (futures, rand, tokio, etc.)

These dependencies are isolated to this repository to keep the main codebase lightweight.