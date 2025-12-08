# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on timely and differential-dataflow packages, which were moved out of the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce the dependency footprint.

## Contents

### Benchmarks

The `benches` directory contains performance benchmarks comparing Hydro with timely and differential-dataflow implementations. These benchmarks help measure and compare the performance characteristics of different dataflow implementations.

See [benches/README.md](benches/README.md) for more information on running benchmarks.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Purpose

This separation allows the main Hydro repository to avoid transitive dependencies on timely and differential-dataflow while still retaining the ability to run performance comparisons when needed.