# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and other crates, including benchmarks that use timely and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench fan_in
```

### Available Benchmarks

- **timely benchmarks**: `fork_join.rs`, `fan_in.rs`
- **differential-dataflow benchmarks**: `reachability.rs`
- **Other benchmarks**: `arithmetic.rs`, `fan_out.rs`, `futures.rs`, `identity.rs`, `join.rs`, `micro_ops.rs`, `symmetric_hash_join.rs`, `upcase.rs`, `words_diamond.rs`

For more details, see [benches/README.md](benches/README.md).