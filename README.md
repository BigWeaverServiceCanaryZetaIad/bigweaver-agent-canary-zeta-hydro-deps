# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro with Timely Dataflow and Differential Dataflow.

## Purpose

This repository isolates comparison benchmarks with external dataflow frameworks, preventing the main Hydro repository from needing direct dependencies on:
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)

## Benchmarks

See [benches/README.md](benches/README.md) for details on running performance comparison benchmarks.

## Benefits

- **Clean Dependency Separation**: Main Hydro repository remains free of comparison framework dependencies
- **Retained Performance Comparison**: Full ability to run performance comparisons maintained
- **Technical Debt Reduction**: Prevents accumulation of comparison-specific code in the main codebase
