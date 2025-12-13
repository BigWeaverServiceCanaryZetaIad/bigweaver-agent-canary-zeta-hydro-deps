# Timely and Differential-Dataflow Benchmarks

This directory contains performance benchmarks comparing DFIR (from the bigweaver-agent-canary-hydro-zeta repository) with timely-dataflow and differential-dataflow.

## Purpose

These benchmarks have been moved to this separate repository to avoid including timely and differential-dataflow dependencies in the main bigweaver-agent-canary-hydro-zeta repository, while still maintaining the ability to perform performance comparisons.

## Benchmarks

The following benchmarks are available:

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Multiple input streams merging into one
- **fan_out**: Single stream splitting into multiple outputs
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity/passthrough operation benchmarks
- **upcase**: String transformation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks
- **micro_ops**: Micro-benchmarks for basic operations
- **symmetric_hash_join**: Symmetric hash join benchmarks

## Prerequisites

This repository should be cloned alongside the main bigweaver-agent-canary-hydro-zeta repository:

```
/projects/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
      └── benches/
```

The benchmarks reference DFIR from the main repository via a relative path.

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench fan_in
```

To run with specific filters:

```bash
cargo bench fan_in/hydroflow
cargo bench fan_in/timely
```

## Performance Comparison

Each benchmark typically includes implementations for:
- **DFIR**: The main implementation from bigweaver-agent-canary-hydro-zeta
- **Timely**: Timely-dataflow implementation for comparison
- **Differential-dataflow**: Differential-dataflow implementation (where applicable)
- **Baseline**: Pure Rust iterators or loops for reference

## Results

Benchmark results are saved in `target/criterion/` and can be viewed as HTML reports in your browser.

## Maintenance

When updating these benchmarks:
1. Ensure the main repository path in `Cargo.toml` is correct
2. Keep benchmark implementations in sync with API changes in the main repository
3. Document any significant performance differences or findings
