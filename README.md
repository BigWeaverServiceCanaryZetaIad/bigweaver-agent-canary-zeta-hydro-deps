# bigweaver-agent-canary-zeta-hydro-deps

This repository contains Hydro ecosystem functionality that has dependencies on external dataflow frameworks, specifically Timely Dataflow and Differential Dataflow.

## Contents

### Benchmarks

Performance benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow implementations.

See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Purpose

This repository was created to separate code that depends on `timely` and `differential-dataflow` packages from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`). This separation:

- Keeps the main repository focused on core Hydro functionality
- Avoids unnecessary dependencies in the main codebase
- Maintains the ability to run performance comparisons with other dataflow frameworks
- Provides a dedicated space for benchmark code and results