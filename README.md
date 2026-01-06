# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks with timely and differential-dataflow dependencies that were migrated from bigweaver-agent-canary-hydro-zeta to prevent benchmark-specific dependencies from cluttering the main codebase.

## Benchmarks

The `benches` directory contains performance benchmarks for testing various operations and data structures. The benchmarks use the Criterion framework and include specialized dependencies like `timely` and `differential-dataflow`.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
# Run reachability benchmark (uses differential-dataflow)
cargo bench -p benches --bench reachability

# Run join benchmark (uses timely)
cargo bench -p benches --bench join

# Run other benchmarks
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench futures
cargo bench -p benches --bench identity
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench upcase
cargo bench -p benches --bench words_diamond
```

### Benchmark Categories

- **Timely Benchmarks**: `join.rs` - Tests using timely dataflow
- **Differential Dataflow Benchmarks**: `reachability.rs` - Tests using differential-dataflow for iterative computations
- **General Benchmarks**: Various other benchmarks for performance testing of core operations

### Performance Comparison

The benchmarks retain their ability to run performance comparisons. Criterion automatically generates HTML reports with performance comparisons across runs. After running benchmarks, view the reports at:
```
target/criterion/report/index.html
```

### Dependencies

The benchmarks use specialized dependencies including:
- `timely-master` - For timely dataflow operations
- `differential-dataflow-master` - For differential dataflow computations
- `criterion` - For benchmarking framework with async support and HTML reports
- `dfir_rs` - Core Hydro functionality

See `benches/Cargo.toml` for the complete list of dependencies.