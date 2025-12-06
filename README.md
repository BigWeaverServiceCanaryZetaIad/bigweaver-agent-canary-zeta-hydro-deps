# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that require timely and differential-dataflow libraries. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a clean separation of concerns and avoid unnecessary dependencies in the main codebase.

## Contents

- **benches/**: Performance benchmarks comparing different dataflow implementations
  - Timely and differential-dataflow benchmarks
  - Performance comparison utilities

## Running Benchmarks

To run the benchmarks, ensure you have the bigweaver-agent-canary-hydro-zeta repository available as a sibling directory, then use:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in dataflow pattern benchmarks
- `fan_out` - Fan-out dataflow pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based async benchmarks
- `identity` - Identity transformation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String transformation benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

To run all benchmarks:
```bash
cargo bench
```

## Dependencies

This repository requires the following external dependencies from the main repository:
- `dfir_rs` - Core dataflow runtime
- `sinktools` - Sink utilities for benchmarking

These are referenced via relative paths to the `bigweaver-agent-canary-hydro-zeta` repository.

## Performance Comparisons

The benchmarks in this repository can be used to run performance comparisons between different implementations and measure the impact of changes to the main repository.