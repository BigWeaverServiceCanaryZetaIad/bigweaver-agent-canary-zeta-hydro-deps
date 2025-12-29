# Hydro Dependencies Repository

This repository contains benchmarks and other code that depend on external dataflow frameworks like Timely Dataflow and Differential Dataflow.

## Contents

- `benches/` - Performance comparison benchmarks between DFIR and other dataflow frameworks (Timely, Differential)

## Purpose

This repository was created to isolate heavyweight dependencies from the main Hydro repository, keeping the core codebase clean and focused while still maintaining the ability to run performance comparisons.

## Running Benchmarks

See [benches/README.md](benches/README.md) for details on running the benchmarks.