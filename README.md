# bigweaver-agent-canary-zeta-hydro-deps

This repository contains timely and differential-dataflow dependencies and benchmarks that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Purpose

This repository was created to:
- Isolate timely and differential-dataflow dependencies from the main Hydro repository
- Reduce build overhead and security surface area in the main repository
- Maintain the ability to run performance comparisons between Hydro/DFIR and timely/differential-dataflow

## Structure

- `benches/` - Comparative benchmarks between Hydro/DFIR and timely/differential-dataflow implementations

## Running Benchmarks

To run the benchmarks:

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
```

See `benches/README.md` for more details on available benchmarks.

## Relationship to Main Repository

The main `bigweaver-agent-canary-hydro-zeta` repository contains the core Hydro framework without timely/differential-dataflow dependencies. For performance comparison purposes, this repository maintains those dependencies and benchmarks that require them.