# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro performance with other dataflow frameworks (Timely and Differential Dataflow).

## Benchmarks

The benchmarks include comprehensive performance comparisons between:
- Hydro implementations (dfir_rs)
- Timely Dataflow
- Differential Dataflow
- Raw Rust implementations (where applicable)

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench upcase
```

## Benchmark Files

The benchmarks are located in the `benches/benches/` directory and include:
- `reachability.rs` - Graph reachability algorithms
- `fork_join.rs` - Fork-join dataflow patterns
- `fan_out.rs` - Fan-out patterns
- `fan_in.rs` - Fan-in patterns
- `upcase.rs` - String transformation benchmarks
- `join.rs` - Join operations
- `micro_ops.rs` - Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- `arithmetic.rs` - Arithmetic operations
- `identity.rs` - Identity transformations
- `symmetric_hash_join.rs` - Symmetric hash join operations
- `words_diamond.rs` - Word processing diamond patterns
- `futures.rs` - Futures-based operations

Each benchmark preserves complete implementations including all comparison functions.
