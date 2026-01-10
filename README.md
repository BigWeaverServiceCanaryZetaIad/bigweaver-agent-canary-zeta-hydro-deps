# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that depend on external packages such as timely and differential-dataflow.

## Benchmarks

The benchmarks are located in the `benches` directory and include performance tests for:

- **Timely benchmarks**: arithmetic, identity
- **Differential-dataflow benchmarks**: reachability
- Additional Hydro microbenchmarks

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

See the [benches/README.md](benches/README.md) for more details.
