# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been separated from the main repository to reduce unnecessary dependencies.

## Contents

### Benchmarks

The `benches` crate contains benchmarks that depend on:
- **timely**: Timely dataflow system
- **differential-dataflow**: Differential dataflow computation framework

These benchmarks were moved here to avoid having timely and differential-dataflow as dependencies in the main Hydro repository, while still retaining the ability to run performance comparisons.

For more information, see [benches/README.md](benches/README.md).

## Usage

To run benchmarks:

```bash
cargo bench -p benches
```

## Relationship to Main Repository

This repository is a companion to [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) and contains components that were moved out to maintain a cleaner dependency structure in the main codebase.