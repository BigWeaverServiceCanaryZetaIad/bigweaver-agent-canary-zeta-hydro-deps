# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark and dependency testing infrastructure for the Hydro project.

## Benches

The `benches` directory contains microbenchmarks for Hydro and other frameworks, including benchmarks that depend on timely and differential-dataflow packages.

### Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- `arithmetic.rs` - Arithmetic operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Futures-based operation benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Reachability algorithm benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String transformation benchmarks
- `words_diamond.rs` - Word processing benchmarks

For more details on individual benchmarks, see the [benches/README.md](benches/README.md) file.