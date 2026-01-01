# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require timely and differential-dataflow dependencies.

## Benchmarks

The `benches` directory contains microbenchmarks for DFIR and other dataflow frameworks, including comparisons with Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench fork_join
```

See the [benches/README.md](benches/README.md) for more details.