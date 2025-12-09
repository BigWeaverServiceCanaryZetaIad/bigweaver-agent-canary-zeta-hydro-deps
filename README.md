# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that require external dependencies such as timely and differential-dataflow.

## Structure

- `benches/` - Microbenchmarks comparing Hydro with timely and differential-dataflow

## Benchmarks

The benchmarks in this repository allow performance comparisons between Hydro and other dataflow systems. These have been separated from the main repository to avoid cluttering the main codebase with external dependencies.

See [benches/README.md](benches/README.md) for more information on running the benchmarks.

## Relationship to Main Repository

This repository depends on the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository for core functionality. The benchmarks use Git dependencies to reference specific versions of `dfir_rs` and `sinktools` from the main repository.