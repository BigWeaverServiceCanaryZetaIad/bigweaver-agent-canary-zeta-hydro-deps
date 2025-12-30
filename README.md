# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely and differential-dataflow packages.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other crates.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

See [benches/README.md](benches/README.md) for more details.