# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require timely and differential-dataflow packages.

## Purpose

This repository was created to separate timely and differential-dataflow dependencies from the main [hydro repository](https://github.com/hydro-project/hydro). This separation helps:

- Reduce dependency complexity in the main repository
- Isolate benchmarks that require these specific dependencies
- Maintain ability to run performance comparisons
- Improve build times for the main project

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro (dfir_rs) implementations with timely and differential-dataflow implementations. See [`benches/README.md`](benches/README.md) for details on running benchmarks.

#### Timely Dataflow Benchmarks
- Arithmetic operations
- Fan-in and fan-out patterns
- Fork-join patterns
- Identity operations
- Join operations
- String transformations

#### Differential Dataflow Benchmarks
- Graph reachability computations

## Quick Start

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cd benches
cargo bench

# Run specific benchmark
cargo bench --bench reachability
```

## Related Repositories

- [hydro](https://github.com/hydro-project/hydro) - Main Hydro project repository
- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Source repository for these benchmarks

## Migration Notes

These benchmarks were migrated from the main hydro repository. For migration details, see [`MIGRATION_NOTES.md`](MIGRATION_NOTES.md).