# Hydro Dependencies

This repository contains benchmark code and dependencies for the Hydro project that rely on external dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Purpose

The benchmarks in this repository provide performance comparisons between Hydro/DFIR and other dataflow frameworks. By separating these benchmarks from the main Hydro repository, we keep the main codebase free from dependencies on competing frameworks while still maintaining the ability to run performance comparisons.

## Contents

- `benches/` - Microbenchmarks comparing Hydro, Timely Dataflow, and Differential Dataflow performance

## Running Benchmarks

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed instructions on running benchmarks.

Quick start:
```bash
cargo bench -p benches
```

## Dependencies

This repository depends on the main Hydro repository ([bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta)) for core functionality:
- `dfir_rs` - The DFIR runtime
- `sinktools` - Utility tools

External framework dependencies:
- `timely` - Timely Dataflow framework
- `differential-dataflow` - Differential Dataflow framework

## License

Apache-2.0