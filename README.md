# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` packages, separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner dependency structure.

## Contents

### Benches
Microbenchmarks for Hydro and related crates that use `timely` and `differential-dataflow` as dependencies.

See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Purpose

This repository was created to:
- Separate benchmarks that depend on `timely` and `differential-dataflow` from the main repository
- Maintain the ability to run performance comparisons
- Keep the main repository's dependency tree cleaner
- Preserve the directory structure and file organization of benchmark code

## Dependencies

The benchmarks in this repository depend on packages from the main `bigweaver-agent-canary-hydro-zeta` repository via git dependencies, ensuring they can still access the necessary code while remaining in a separate repository.