# bigweaver-agent-canary-zeta-hydro-deps

This repository contains isolated dependencies and benchmarks for the Hydro project that require external dataflow frameworks.

## Purpose

This repository serves as a dedicated location for:
- Performance comparison benchmarks between Timely Dataflow, Differential Dataflow, and Hydro
- Dependencies on timely and differential-dataflow packages that are isolated from the main Hydro project

By isolating these dependencies, the main bigweaver-agent-canary-hydro-zeta repository maintains a cleaner dependency tree and faster compilation times.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks comparing Hydro implementations against Timely and Differential Dataflow. See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Running Benchmarks

```bash
cargo bench -p hydro-deps-benches
```

For more detailed instructions, see the [benchmarks README](benches/README.md).

## Relationship to Main Repository

This repository is a companion to [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro). The benchmarks here allow performance comparisons while keeping the main repository free from timely and differential-dataflow dependencies.