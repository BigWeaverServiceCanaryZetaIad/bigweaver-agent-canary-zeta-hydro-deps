# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro/DFIR project.

## Benchmarks

The `/benches` directory contains microbenchmarks for DFIR and other dataflow frameworks (Timely Dataflow, Differential Dataflow). These benchmarks are used for performance comparisons.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
```

### Available Benchmarks

- `arithmetic.rs` - Arithmetic operations benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Async futures benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operations (map, flat_map, union, tee, fold, sort) benchmarks
- `reachability.rs` - Graph reachability algorithm benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase operation benchmarks
- `words_diamond.rs` - Word processing diamond pattern benchmarks

### Dependencies

The benchmarks depend on the main `bigweaver-agent-canary-hydro-zeta` repository for the `dfir_rs` and `sinktools` libraries. Ensure both repositories are in the same parent directory for the path references to work correctly.