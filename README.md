# Hydro Dependencies Repository

This repository contains benchmarks and other code that depends on external dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Purpose

This repository was created to separate benchmarks that compare Hydro's performance with other dataflow systems from the main Hydro repository. This allows the main repository to remain focused on Hydro's core implementation without needing to maintain dependencies on external dataflow frameworks.

## Contents

- **benches/** - Benchmark suite comparing Hydro with Timely and Differential Dataflow

## Running Benchmarks

See [benches/README.md](benches/README.md) for detailed instructions on running the benchmarks.

## Relationship to Main Repository

These benchmarks reference the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) via Git dependencies to access `dfir_rs` and other core functionality.