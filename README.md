# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare Hydro (dfir_rs) performance with Timely and 
Differential Dataflow implementations. These benchmarks were moved from the main Hydro repository
(bigweaver-agent-canary-hydro-zeta) to isolate the dependencies on timely and differential-dataflow 
packages while retaining performance comparison functionality.

## Structure

- `benches/` - Performance comparison benchmarks

## Purpose

By isolating these benchmarks in a separate repository, we can:
- Keep the main Hydro repository free from timely/differential-dataflow dependencies
- Maintain the ability to compare Hydro performance against these established frameworks
- Simplify dependency management in the main repository

## Running Benchmarks

See the [benches README](benches/README.md) for details on running the benchmarks.