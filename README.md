# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the DFIR/Hydro project that require external dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Purpose

The benchmarks in this repository are separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Isolate dependencies on external dataflow frameworks (timely, differential-dataflow)
- Enable independent versioning of benchmarks
- Maintain performance comparison capabilities without affecting the main codebase

## Repository Structure

- `benches/` - Benchmark suite comparing DFIR/Hydro with Timely and Differential Dataflow
  - `arithmetic.rs` - Arithmetic pipeline benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `reachability.rs` - Graph reachability algorithm benchmarks

## Usage

To run the benchmarks:

```bash
cd benches
cargo bench
```

For more details, see the [benches/README.md](benches/README.md).

## Dependencies

This repository depends on:
- `timely` (Timely Dataflow framework)
- `differential-dataflow` (Differential Dataflow framework)
- `dfir_rs` (from the main hydro repository)

## Maintenance

These benchmarks should be kept in sync with the main repository to ensure accurate performance comparisons. When updating benchmark code, ensure that the corresponding functionality exists in the main repository.