# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project, specifically for comparing performance between Hydro's dfir_rs implementation and other dataflow systems like Timely and Differential Dataflow.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro with Timely and Differential Dataflow implementations. These benchmarks test various operations including:

- Arithmetic operations
- Fan-in and fan-out patterns
- Fork-join patterns
- Graph algorithms (reachability)
- Stream operations (identity, join, etc.)
- Micro operations

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

See the [benches/README.md](benches/README.md) for more details.