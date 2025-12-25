# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on external dataflow libraries (`timely` and `differential-dataflow`). These benchmarks were moved from the `bigweaver-agent-canary-hydro-zeta` repository to separate concerns and dependencies.

## Contents

- **benches/** - Performance benchmarks comparing Hydro/DFIR against timely dataflow and differential-dataflow

## Purpose

The benchmarks in this repository are used to:
1. Compare Hydro/DFIR performance against industry-standard dataflow frameworks
2. Validate that Hydro maintains competitive performance
3. Track performance regressions over time

## Running Benchmarks

See the [benches/README.md](benches/README.md) for detailed instructions on running the benchmarks.

Quick start:
```bash
cd benches
cargo bench
```