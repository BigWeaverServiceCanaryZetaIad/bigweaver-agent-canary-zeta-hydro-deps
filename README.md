# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and other dependencies for the Hydro project that require heavy dependencies like `timely` and `differential-dataflow`.

## Benchmarks

The `benches/` directory contains microbenchmarks for DFIR and other frameworks, including benchmarks that use timely and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

For more details, see the [benches/README.md](benches/README.md).
