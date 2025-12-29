# Contributing to Hydro Dependencies Repository

This repository contains benchmarks and code that depend on external dataflow frameworks like Timely Dataflow and Differential Dataflow.

## Repository Structure

* `benches/` - Performance comparison benchmarks between DFIR and other frameworks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

The following benchmarks compare DFIR performance with Timely Dataflow and Differential Dataflow:

- **arithmetic.rs** - Arithmetic operations comparison
- **fan_in.rs** - Fan-in pattern comparison
- **fan_out.rs** - Fan-out pattern comparison
- **fork_join.rs** - Fork-join pattern comparison
- **identity.rs** - Identity operation comparison
- **join.rs** - Join operation comparison
- **reachability.rs** - Graph reachability algorithm comparison
- **upcase.rs** - String uppercase transformation comparison

## Rust Version

This repository uses Rust 1.91.1 as specified in `rust-toolchain.toml`.

## Dependencies

The benchmarks depend on:
- `dfir_rs` - from the main Hydro repository
- `sinktools` - from the main Hydro repository  
- `timely` (timely-master) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential Dataflow framework
- `criterion` - for benchmarking
- Various supporting libraries (futures, rand, tokio, etc.)

## Purpose

This repository was created to isolate heavyweight dependencies (Timely Dataflow and Differential Dataflow) from the main Hydro repository. This keeps the core Hydro codebase clean and focused while still maintaining the ability to run performance comparisons.

## Relationship to Main Hydro Repository

The benchmarks in this repository reference `dfir_rs` and `sinktools` from the main Hydro repository via git dependencies. Changes to the main repository may affect these benchmarks.
