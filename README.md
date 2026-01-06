# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that require external dataflow libraries (Timely Dataflow and Differential Dataflow).

## Purpose

These benchmarks were separated from the main bigweaver-agent-canary-hydro-zeta repository to:
- Avoid including timely and differential-dataflow dependencies in the main project
- Maintain the ability to run performance comparisons with these frameworks
- Keep the main repository lean while preserving benchmark capabilities

## Contents

- `benches/`: Performance benchmarks comparing Hydro with Timely and Differential Dataflow
  - `fan_out.rs`: Fan-out dataflow pattern benchmarks
  - `join.rs`: Join operation benchmarks
  - `reachability.rs`: Graph reachability algorithm benchmarks

## Running Benchmarks

See the [benches/README.md](benches/README.md) for detailed instructions on running the benchmarks.
