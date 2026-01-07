# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the BigWeaver Hydro project.

## Benchmarks

The `benches/` directory contains performance benchmarks for timely and differential-dataflow operations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench reachability
```

### Benchmark Files

- **Timely benchmarks**: `join.rs`, `fan_in.rs`, `fan_out.rs`, `fork_join.rs`, `identity.rs`, `upcase.rs`, `micro_ops.rs`, `symmetric_hash_join.rs`, `words_diamond.rs`, `arithmetic.rs`, `futures.rs`
- **Differential-dataflow benchmarks**: `reachability.rs`

For more details, see [benches/README.md](benches/README.md).