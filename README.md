# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks comparing Hydro/dfir_rs with Timely Dataflow and 
Differential Dataflow implementations.

## Purpose

These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Isolate Dependencies**: Remove timely and differential-dataflow dependencies from the main 
   Hydro repository while preserving the ability to perform performance comparisons.

2. **Maintain Comparisons**: Allow comprehensive performance benchmarking between Hydro and 
   alternative dataflow systems without coupling the main codebase to those dependencies.

3. **Modular Testing**: Enable independent performance testing and validation across different
   dataflow frameworks.

## Structure

- `benches/` - Contains all benchmark implementations with timely/differential-dataflow comparisons

## Usage

See the [benches README](benches/README.md) for detailed instructions on running the benchmarks.

## Dependencies

These benchmarks depend on:
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework  
- `dfir_rs` - From the main Hydro repository (via git dependency)
- `sinktools` - From the main Hydro repository (via git dependency)

## Related Repositories

- Main Hydro repository: `bigweaver-agent-canary-hydro-zeta`