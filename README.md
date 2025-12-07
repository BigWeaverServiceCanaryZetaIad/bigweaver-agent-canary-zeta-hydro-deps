# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow dependencies that were previously part of the bigweaver-agent-canary-hydro-zeta repository.

## Purpose

This repository maintains the ability to run performance comparisons between different implementations, including:
- Hydro implementations
- Timely dataflow implementations
- Differential dataflow implementations
- Raw/baseline implementations

## Structure

- `benches/` - Benchmark suite with timely and differential-dataflow dependencies

## Dependencies

The benchmarks use the following key dependencies:
- `timely-master` (0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` - Hydro's DFIR (DataFlow Intermediate Representation) runtime
- `criterion` - Benchmarking framework

## Usage

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

See `benches/README.md` for more details on the benchmark suite.