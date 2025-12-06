# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow that were moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Purpose

The benchmarks in this repository help maintain performance comparison capabilities for timely and differential-dataflow workloads without adding unnecessary dependencies to the main repository.

## Structure

- `benches/` - Contains criterion-based benchmarks for various dataflow patterns:
  - `arithmetic.rs` - Arithmetic operations benchmarks
  - `fan_in.rs` - Fan-in pattern benchmarks
  - `fan_out.rs` - Fan-out pattern benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `futures.rs` - Futures-based benchmarks
  - `identity.rs` - Identity operation benchmarks
  - `join.rs` - Join operation benchmarks
  - `micro_ops.rs` - Micro-operation benchmarks
  - `reachability.rs` - Graph reachability benchmarks
  - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
  - `upcase.rs` - String uppercase benchmarks
  - `words_diamond.rs` - Diamond pattern with word processing benchmarks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench arithmetic
```

## Performance Comparisons

The benchmarks support comparing performance across different implementations and configurations. Results are generated in `target/criterion/` with HTML reports for analysis.