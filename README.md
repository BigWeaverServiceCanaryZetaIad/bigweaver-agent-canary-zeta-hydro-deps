# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro with Timely and Differential Dataflow frameworks.

## Structure

- `benches/`: Benchmark suite comparing Hydro (dfir_rs) with Timely and Differential Dataflow

## Purpose

This repository was created to isolate benchmarks that depend on Timely and Differential Dataflow frameworks. By separating these benchmarks from the main Hydro repository, we:

1. Avoid adding timely and differential-dataflow as direct dependencies in the main repository
2. Retain the ability to run performance comparisons between frameworks
3. Keep the main repository focused on core Hydro functionality

## Prerequisites

The benchmarks in this repository require the main `bigweaver-agent-canary-hydro-zeta` repository to be available at `../bigweaver-agent-canary-hydro-zeta` (as a sibling directory) since they depend on `dfir_rs` and `sinktools` from the main repository.

## Running Benchmarks

See the [benches/README.md](benches/README.md) for detailed instructions on running benchmarks.