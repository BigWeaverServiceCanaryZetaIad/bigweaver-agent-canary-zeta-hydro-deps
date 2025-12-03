# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external libraries like `timely` and `differential-dataflow`. These benchmarks have been separated from the main repository to maintain cleaner dependency management.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates, including comparisons with timely and differential-dataflow.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

Available benchmarks:
- `arithmetic` - Arithmetic operation benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Performance Comparison

These benchmarks allow for performance comparisons between:
- Hydro's DFIR implementation
- Timely dataflow
- Differential dataflow

This enables tracking performance improvements and ensuring that Hydro remains competitive with existing dataflow frameworks.

## Dependencies

This repository includes dependencies on:
- `timely` (timely-master) - For timely dataflow benchmarks
- `differential-dataflow` (differential-dataflow-master) - For differential dataflow benchmarks
- `dfir_rs` - Hydro's DFIR runtime
- `criterion` - For benchmark harness

## Repository Structure

```
.
├── benches/
│   ├── Cargo.toml       # Benchmark package configuration
│   ├── README.md        # Benchmark-specific documentation
│   ├── build.rs         # Build script
│   └── benches/         # Benchmark implementations
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── futures.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── micro_ops.rs
│       ├── reachability.rs
│       ├── symmetric_hash_join.rs
│       ├── upcase.rs
│       └── words_diamond.rs
└── Cargo.toml           # Workspace configuration
```

## Contributing

When adding new benchmarks:
1. Add the benchmark file to `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Ensure the benchmark compares performance across relevant implementations
4. Document any special requirements or dataset dependencies

## Migration Notes

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain better separation of concerns and cleaner dependency management. The benchmarks retain their full functionality and can still be used for performance comparisons.