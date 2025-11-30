# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for comparing Hydro with timely-dataflow and differential-dataflow implementations.

## Purpose

The benchmarks in this repository enable performance comparisons between:
- Hydro (dfir_rs) implementations
- Timely Dataflow implementations
- Differential Dataflow implementations

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to:
1. Reduce the dependency footprint of the main repository
2. Keep timely and differential-dataflow dependencies separate
3. Maintain the ability to run performance comparisons when needed

## Structure

- `benches/` - Criterion-based benchmarks comparing different implementations

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench identity
```

## Available Benchmarks

The following benchmarks are available:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity/passthrough operations
- `join` - Join operations
- `reachability` - Graph reachability
- `micro_ops` - Micro-operation benchmarks
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercase transformations
- `words_diamond` - Diamond-shaped dataflow
- `futures` - Async futures patterns