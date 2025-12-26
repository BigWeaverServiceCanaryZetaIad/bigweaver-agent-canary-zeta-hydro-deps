# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that compare Hydro with Timely Dataflow and Differential Dataflow frameworks.

## Purpose

These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency boundaries. The main repository should not have direct dependencies on timely and differential-dataflow packages, but we need to retain the ability to run performance comparisons.

## Structure

- `benches/` - Contains performance benchmarks comparing Hydro implementations with Timely and Differential Dataflow

## Running Benchmarks

To run the benchmarks:

```bash
cd benches
cargo bench
```

For more details, see the [benches/README.md](benches/README.md) file.