# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the BigWeaver Agent Canary Hydro Zeta project.

## Contents

- `benches/` - Benchmark suite for DFIR and related frameworks, including:
  - Performance benchmarks (arithmetic, fan_in, fan_out, fork_join, join, etc.)
  - Reachability benchmarks with test data files
  - Micro-operation benchmarks
  - Dependencies: timely and differential-dataflow

## Building

To build the benchmarks:

```bash
cargo build --release
```

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run specific benchmarks:

```bash
cargo bench -p benches -- <benchmark_name>
```