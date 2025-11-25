# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for timely-dataflow and differential-dataflow libraries.
These benchmarks were moved from the `bigweaver-agent-canary-hydro-zeta` repository to 
keep dependency-related benchmarks separate from the main codebase.

## Overview

The benchmarks compare performance of various dataflow patterns using timely-dataflow
and differential-dataflow libraries against baseline implementations.

## Available Benchmarks

### Arithmetic (`arithmetic.rs`)
Tests arithmetic operations through a pipeline of map operations.
- **Patterns tested**: Pipeline, raw copy, iterator variants, timely dataflow
- **Operations**: 20 addition operations on 1,000,000 integers

### Fan In (`fan_in.rs`)
Tests merging multiple data streams into one.
- **Patterns tested**: Timely dataflow, iterators, for loops
- **Operations**: 20 streams merged into one, each with 1,000,000 integers

### Fan Out (`fan_out.rs`)
Tests splitting one data stream into multiple outputs.
- **Patterns tested**: Timely dataflow, simple loop solution
- **Operations**: 1 stream split into 20 outputs, 1,000,000 integers

### Fork Join (`fork_join.rs`)
Tests alternating split and merge operations.
- **Patterns tested**: Timely dataflow, raw data operations
- **Operations**: 20 fork-join cycles on 100,000 integers

### Identity (`identity.rs`)
Tests passing data through a chain of operations without modification.
- **Patterns tested**: Pipeline, raw copy, iterators, timely dataflow
- **Operations**: 20 identity operations on 1,000,000 integers

### Join (`join.rs`)
Tests joining two data streams on a common key.
- **Patterns tested**: Timely dataflow with custom hash join, simple loop solution
- **Value types tested**: usize, String
- **Operations**: Join on 100,000 key-value pairs

### Reachability (`reachability.rs`)
Tests graph reachability computation (fixed-point iteration).
- **Patterns tested**: Timely dataflow, differential-dataflow
- **Data**: Uses `reachability_edges.txt` and validates against `reachability_reachable.txt`
- **Operations**: Computes all nodes reachable from node 1

### Upcase (`upcase.rs`)
Tests string transformation operations.
- **Patterns tested**: Raw operations, iterators, timely dataflow
- **Operations**: 20 string operations on 100,000 strings
- **Variants**: In-place uppercase, allocating uppercase, concatenation

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-benchmarks
```

Run a specific benchmark:
```bash
cargo bench -p timely-benchmarks --bench reachability
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p timely-benchmarks --bench join
```

Run benchmarks matching a pattern:
```bash
cargo bench -p timely-benchmarks -- timely
cargo bench -p timely-benchmarks -- differential
```

## Benchmark Data Files

- `reachability_edges.txt` - Edge list for the reachability graph
- `reachability_reachable.txt` - Expected reachable nodes from node 1
- `words_alpha.txt` - Word list from https://github.com/dwyl/english-words

## Performance Comparison

These benchmarks enable performance comparison between:
1. **Timely Dataflow** - Low-level dataflow framework
2. **Differential Dataflow** - Incremental computation framework (reachability benchmark)
3. **Baseline implementations** - Raw Rust, iterators, channels

## Migration Information

**Original Location**: `bigweaver-agent-canary-hydro-zeta/benches/`
**New Location**: `bigweaver-agent-canary-zeta-hydro-deps/timely-benchmarks/`
**Migration Date**: 2024-11-25

### Changes from Original

The benchmarks have been extracted to remove dependencies on the main repository:
- Removed all `dfir_rs` (Hydroflow) benchmarks
- Kept only `timely` and `differential-dataflow` benchmarks
- Removed dependencies on `dfir_rs`, `sinktools` crates
- Maintained all data files and baseline comparison benchmarks

### Retained Functionality

✅ All timely-dataflow benchmarks functional
✅ All differential-dataflow benchmarks functional  
✅ Performance comparison capabilities retained
✅ All data files included
✅ Baseline benchmarks included for comparison

## Dependencies

Key dependencies (see `Cargo.toml` for full list):
- `timely = "0.13.0-dev.1"` (as `timely-master`)
- `differential-dataflow = "0.13.0-dev.1"` (as `differential-dataflow-master`)
- `criterion = "0.5.0"` (with async_tokio and html_reports features)

## Notes

- All benchmarks use `criterion` for statistical analysis
- HTML reports are generated in `target/criterion/`
- Benchmarks are configured with `harness = false` to use criterion's built-in runner
