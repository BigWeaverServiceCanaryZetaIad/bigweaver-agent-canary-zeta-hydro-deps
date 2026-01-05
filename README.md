# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the BigWeaver Agent Canary Hydro Zeta project that require external dataflow processing libraries (timely-dataflow and differential-dataflow).

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other crates, including:

- Identity, arithmetic, and other basic operation benchmarks using timely-dataflow
- Reachability benchmarks using differential-dataflow
- Various dataflow pattern benchmarks (fan-in, fan-out, join, etc.)

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
```

## Dependencies

This repository maintains dependencies on:
- `timely-master` (timely-dataflow)
- `differential-dataflow-master`
- Related benchmark infrastructure

These dependencies are isolated here to keep the main hydro repository lean and focused on core functionality.
