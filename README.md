# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks with timely and differential-dataflow dependencies for performance comparison with Hydro implementations.

## Structure

- **benches/** - Benchmark suite comparing Hydro with timely and differential-dataflow implementations

## Purpose

This repository isolates benchmarks that require timely and differential-dataflow dependencies, keeping the main Hydro repository free from these dependencies while maintaining performance comparison capabilities.

## Running Benchmarks

```bash
cd benches
cargo bench
```

For more information, see the [benches README](benches/README.md).