# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the bigweaver-agent-canary-hydro-zeta project.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other crates, including benchmarks that depend on `timely-master` and `differential-dataflow-master`.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_out
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity operations benchmark
- `upcase` - String uppercase benchmark
- `join` - Join operations benchmark
- `reachability` - Graph reachability benchmark
- `micro_ops` - Micro-operations benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `words_diamond` - Words diamond pattern benchmark
- `futures` - Async futures benchmark

For more details, see the [benches README](benches/README.md).