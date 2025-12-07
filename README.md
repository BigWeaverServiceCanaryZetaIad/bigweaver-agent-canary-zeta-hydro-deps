# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` packages.

These components were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the main repository free of these dependencies while retaining the ability to run performance comparisons.

## Contents

- **benches/**: Microbenchmarks that use timely and differential-dataflow packages

## Running Benchmarks

See the [benches/README.md](benches/README.md) for details on running the benchmarks.

## Relationship to Main Repository

This repository is a companion to `bigweaver-agent-canary-hydro-zeta`. The benchmarks here can be used to compare performance with benchmarks in the main repository that don't depend on timely/differential-dataflow.