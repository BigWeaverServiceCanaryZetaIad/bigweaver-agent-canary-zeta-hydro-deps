# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro/DFIR with external dataflow frameworks, specifically Timely Dataflow and Differential Dataflow.

## Purpose

This repository houses performance comparison benchmarks that depend on external frameworks (timely-master and differential-dataflow-master). By separating these benchmarks from the main Hydro repository, we:

- Keep the main repository's dependency tree cleaner
- Enable independent benchmarking of different framework versions
- Facilitate performance comparisons between Hydro and other dataflow systems

## Structure

- `benches/`: Benchmark implementations comparing Hydro/DFIR with Timely and Differential Dataflow

## Running Benchmarks

See the [benches README](benches/README.md) for detailed instructions on running the benchmarks.
