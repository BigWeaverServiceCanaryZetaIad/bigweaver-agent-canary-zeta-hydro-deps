# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow, separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository serves to:
- Isolate timely and differential-dataflow dependencies from the main codebase
- Reduce build times for core development
- Maintain performance comparison capabilities with alternative implementations
- Provide reference implementations for benchmarking

## Structure

- **benches/** - Benchmarks that use timely/differential-dataflow for performance comparison

## Getting Started

To run benchmarks:
```bash
cd benches
cargo bench
```

See the [benches/README.md](benches/README.md) for more details on available benchmarks and usage.

## Relationship to Main Repository

This repository complements the main bigweaver-agent-canary-hydro-zeta repository by maintaining functionality that requires external dependencies while keeping the main repository lean and focused on Hydro-native implementations.