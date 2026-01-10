# Benchmark Migration Guide

This document explains the migration of timely and differential-dataflow benchmarks from the main hydro repository to this dedicated repository.

## Background

The benchmarks were moved to this separate repository to:
1. Avoid heavy dependencies (timely and differential-dataflow) in the main codebase
2. Keep the main repository focused on core functionality
3. Maintain clean dependency management
4. Allow independent development and testing of benchmarks

## What Was Moved

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta`:

- **arithmetic.rs**: Pipeline operations with arithmetic computations
- **fan_in.rs**: Fan-in patterns with multiple inputs
- **fan_out.rs**: Fan-out patterns with multiple outputs
- **fork_join.rs**: Fork-join patterns
- **futures.rs**: Async futures-based operations
- **identity.rs**: Identity transformation benchmarks
- **join.rs**: Join operation benchmarks
- **micro_ops.rs**: Micro-operation benchmarks
- **reachability.rs**: Graph reachability using differential-dataflow
- **symmetric_hash_join.rs**: Symmetric hash join benchmarks
- **upcase.rs**: String uppercase transformation
- **words_diamond.rs**: Diamond pattern with word processing

Supporting files:
- **reachability_edges.txt**: Graph data for reachability benchmark
- **reachability_reachable.txt**: Expected results for reachability benchmark
- **words_alpha.txt**: Word list for word processing benchmarks
- **build.rs**: Build script for generating benchmark code
- **Cargo.toml**: Benchmark dependencies and configuration

## Dependencies

The benchmarks depend on:
- **timely-master** (0.13.0-dev.1): For timely dataflow comparisons
- **differential-dataflow-master** (0.13.0-dev.1): For differential dataflow comparisons
- **dfir_rs**: Referenced from the main hydro repository via git
- **sinktools**: Referenced from the main hydro repository via git
- **criterion**: For benchmark harness

## Usage in New Repository

### Running Benchmarks

From the root of this repository:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic
```

### Cross-Repository Development

If you're working on both repositories:

1. The benchmarks reference `dfir_rs` and `sinktools` from the main repository via git dependency
2. Changes to the main repository's API may require updates to benchmarks here
3. Always ensure compatibility when making breaking changes to `dfir_rs` or `sinktools`

## Performance Comparison Capability

All benchmarks are designed to compare performance across different implementations:
- Raw implementations (baseline)
- Timely dataflow implementations
- Hydro/dfir_rs implementations

This allows us to track performance regressions and improvements over time.

## Related Repositories

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)
- This repository: [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/hydro-project/hydro-deps)

## Migration History

The benchmarks were removed from the main repository in commit: `chore(benches): remove timely/differential-dataflow dependencies and benchmarks`

They were recovered from git history and added to this repository to preserve the performance comparison functionality.
