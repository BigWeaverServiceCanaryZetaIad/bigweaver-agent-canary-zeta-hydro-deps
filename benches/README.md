# Microbenchmarks

Performance benchmarks for Hydro, Timely, and Differential Dataflow.

## Quick Start

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Available Benchmarks

### Dataflow Pattern Benchmarks
- **`arithmetic`** - Arithmetic operations across different dataflow systems
- **`fan_in`** - Multiple inputs converging to single output pattern
- **`fan_out`** - Single input distributing to multiple outputs pattern
- **`fork_join`** - Parallel execution with convergence pattern
- **`words_diamond`** - Diamond-shaped dataflow with word processing

### Operation Benchmarks
- **`identity`** - Pass-through operation performance
- **`join`** - Join operation performance comparison
- **`symmetric_hash_join`** - Symmetric hash join implementation
- **`micro_ops`** - Micro-operation performance testing
- **`upcase`** - String transformation benchmarks

### Application Benchmarks
- **`reachability`** - Graph reachability algorithms with real graph data
- **`futures`** - Async/futures performance testing

## Benchmark Results

Benchmark results are saved to `target/criterion/` with HTML reports. View them with:
```bash
open target/criterion/report/index.html
```

## Performance Comparison

Each benchmark compares multiple implementations:
- **Hydro/DFIR** - Native Hydro dataflow implementation
- **Timely** - Timely dataflow system
- **Differential** - Differential dataflow (for applicable benchmarks)

This allows direct performance comparison across different dataflow frameworks.

## Test Data

### Word Lists
- **`words_alpha.txt`** - English word list from https://github.com/dwyl/english-words

### Graph Data
- **`reachability_edges.txt`** - Edge list for graph reachability benchmarks
- **`reachability_reachable.txt`** - Expected reachable nodes for verification

## Build System

The `build.rs` script generates benchmark code at compile time. It currently generates fork-join pattern benchmarks with configurable operation counts.

## Tips

### Running Specific Variants
To run only certain benchmark variants within a benchmark file:
```bash
cargo bench -p benches --bench identity -- 'Hydro'
cargo bench -p benches --bench identity -- 'Timely'
```

### Saving Baseline
To save current results as a baseline for comparison:
```bash
cargo bench -p benches -- --save-baseline my-baseline
```

### Comparing Against Baseline
```bash
cargo bench -p benches -- --baseline my-baseline
```

### Quick Benchmarks (reduced sample size)
```bash
cargo bench -p benches -- --quick
```
