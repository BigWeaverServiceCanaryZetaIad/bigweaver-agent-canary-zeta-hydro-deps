# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner dependency structure.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks for Timely Dataflow and Differential Dataflow against Hydro (dfir_rs).

These benchmarks were moved from the main repository to isolate the `timely` and `differential-dataflow` dependencies while retaining the ability to run performance comparisons.

See [benches/README.md](benches/README.md) for more details on running the benchmarks.

## Purpose

The main `bigweaver-agent-canary-hydro-zeta` repository focuses on the core Hydro functionality without external dataflow framework dependencies. This repository serves as a home for:

1. **Performance Benchmarks** - Comparing Hydro against other dataflow frameworks
2. **Integration Tests** - Testing interoperability with external systems
3. **Legacy Dependencies** - Maintaining compatibility where needed

## Relationship to Main Repository

The benchmarks in this repository reference the main repository's `dfir_rs` crate as a git dependency, allowing for ongoing performance comparisons without polluting the main repository with unnecessary dependencies.