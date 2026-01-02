# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for Hydro that require external frameworks like Timely Dataflow and Differential Dataflow. These are kept separate from the main repository to maintain clean dependency management.

## Benchmarks

The `benches` directory contains performance benchmarks comparing Hydro/DFIR with other dataflow frameworks.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Benchmark Files

- `arithmetic.rs` - Arithmetic operations benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Futures-based operations benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operations benchmarks
- `micro_ops.rs` - Micro-operations benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- `reachability.rs` - Graph reachability algorithm benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase operation benchmarks
- `words_diamond.rs` - Word processing diamond pattern benchmarks

These benchmarks allow for performance comparisons between Hydro/DFIR and established dataflow frameworks.