# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro (DFIR) performance with other dataflow systems, specifically Timely Dataflow and Differential Dataflow.

## Benchmarks

The `benches` directory contains performance comparison benchmarks. See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Purpose

This repository is separated from the main Hydro repository to:
- Keep the main repository free of timely and differential-dataflow dependencies
- Maintain benchmark functionality for performance comparisons
- Improve dependency graph cleanliness and reduce build complexity
