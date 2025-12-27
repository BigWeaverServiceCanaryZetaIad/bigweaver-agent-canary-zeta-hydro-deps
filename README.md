# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydroflow with Timely Dataflow and Differential Dataflow frameworks.

## Purpose

This repository was created to isolate the `timely` and `differential-dataflow` dependencies from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for:

- Cleaner dependency management in the main Hydroflow repository
- Focused performance comparison benchmarks
- Independent maintenance of framework comparison tools

## Structure

- `/benches`: Benchmarks comparing Hydroflow with Timely and Differential Dataflow

## Usage

See the [benches README](./benches/README.md) for information on running the benchmarks.

## Requirements

The benchmarks in this repository depend on the main `bigweaver-agent-canary-hydro-zeta` repository being checked out as a sibling directory.