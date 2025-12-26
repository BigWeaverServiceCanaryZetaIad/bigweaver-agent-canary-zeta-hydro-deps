# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow libraries, extracted from the main bigweaver-agent-canary-hydro-zeta repository.

## Purpose

The main Hydro repository (bigweaver-agent-canary-hydro-zeta) focuses on the core Hydro framework. This separate repository isolates dependencies on timely and differential-dataflow, which are primarily used for performance comparisons.

## Structure

- **benches/**: Performance benchmarks comparing Hydro (dfir_rs) with timely and differential-dataflow implementations

## Usage

This repository is designed to work alongside the main bigweaver-agent-canary-hydro-zeta repository. The benchmarks reference dfir_rs and sinktools from the parent repository via path dependencies.

To run benchmarks:
```bash
cd benches
cargo bench
```

For more details, see [benches/README.md](benches/README.md).