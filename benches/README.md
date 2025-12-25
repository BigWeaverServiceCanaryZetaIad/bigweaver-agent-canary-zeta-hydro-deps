# Microbenchmarks

Performance benchmarks for Hydro (DFIR) and other dataflow systems.

## Overview

These benchmarks compare the performance of different dataflow computation frameworks:
- **Hydro/DFIR** (dfir_rs) - The main framework being tested
- **Timely Dataflow** - A low-level dataflow system
- **Differential Dataflow** - An incremental computation framework built on Timely
- **Standard Rust** - Raw implementations for baseline comparison (iterators, channels, etc.)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
```

Run benchmarks with filters:
```bash
# Run only the "dfir_rs" variants within a benchmark
cargo bench -p benches --bench identity dfir_rs

# Run only the "timely" variants
cargo bench -p benches --bench identity timely
```

## Benchmark Descriptions

### Core Operations
- **identity** - Tests passthrough/identity operations with no transformation. Compares pipelines, raw copying, iterators, Timely, and Hydro.
- **arithmetic** - Basic arithmetic computations across different frameworks.
- **micro_ops** - Tests individual micro-operations to measure overhead.

### Data Flow Patterns
- **fan_in** - Multiple inputs converging to a single output.
- **fan_out** - Single input splitting to multiple outputs.
- **fork_join** - Forking dataflow and then joining results back together.
- **join** - Join operations between two data streams.
- **symmetric_hash_join** - Symmetric hash join implementation performance.

### Real-World Workloads
- **reachability** - Graph reachability algorithm on a real graph dataset.
- **upcase** - String transformation (uppercasing) operations.
- **words_diamond** - Diamond-shaped dataflow pattern with word processing from a dictionary file.

### Async Performance
- **futures** - Tests asynchronous/futures-based execution performance.

## Viewing Results

Benchmark results are saved to `target/criterion/` with:
- HTML reports viewable in a browser
- Statistical analysis of performance
- Comparison charts when benchmarks are run multiple times

Open the HTML reports:
```bash
# On macOS
open target/criterion/report/index.html

# On Linux
xdg-open target/criterion/report/index.html

# Or just navigate to target/criterion/report/index.html in your browser
```

## Data Files

Some benchmarks use external data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)

## Dependencies

Key dependencies configured in `Cargo.toml`:
- `criterion` - Benchmarking framework with statistical analysis
- `dfir_rs` - Hydro dataflow framework (from sibling repository)
- `timely` (timely-master) - Timely dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential dataflow framework
- `tokio` - Async runtime for futures benchmarks
- `sinktools` - Utility tools from Hydro project

## Build Process

The `build.rs` script generates some benchmark code at build time, particularly for the `fork_join` benchmark which creates complex dataflow graphs with configurable sizes.
