# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Timely Dataflow and Differential Dataflow that have been extracted from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Purpose

This repository isolates the `timely` and `differential-dataflow` dependencies to maintain a cleaner dependency structure in the main Hydro repository while preserving the ability to run performance comparisons between Hydro and these systems.

## Quick Start

```bash
# Run all benchmarks
cargo bench -p timely-differential-benches

# Run specific benchmark
cargo bench --bench arithmetic

# View results
open target/criterion/report/index.html
```

For more details, see [QUICK_START.md](QUICK_START.md).

## Contents

- **benches/**: Performance comparison benchmarks for Hydro vs. Timely and Differential Dataflow

## Documentation

- **[QUICK_START.md](QUICK_START.md)** - Quick reference for running benchmarks
- **[TESTING.md](TESTING.md)** - Comprehensive testing guide
- **[MIGRATION_NOTES.md](MIGRATION_NOTES.md)** - Detailed migration documentation
- **[CHANGES.md](CHANGES.md)** - Changelog and technical details
- **[benches/README.md](benches/README.md)** - Benchmark-specific documentation

## Available Benchmarks

- **arithmetic** - Arithmetic operations comparison
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **identity** - Identity transformation benchmarks
- **join** - Join operation benchmarks
- **reachability** - Graph reachability benchmarks
- **upcase** - String uppercase transformation benchmarks

## Migration Information

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta` to this repository to:
- Reduce dependency complexity in the main repository
- Isolate timely and differential-dataflow dependencies
- Maintain performance comparison capabilities independently

For more details, see [MIGRATION_NOTES.md](MIGRATION_NOTES.md).