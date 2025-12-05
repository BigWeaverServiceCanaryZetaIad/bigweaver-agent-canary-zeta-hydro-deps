# Hydro Benchmarks

This document provides detailed information about the benchmarks for comparing Hydro (DFIR) with timely-dataflow and differential-dataflow.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the timely-dataflow and differential-dataflow dependencies. This separation allows the main Hydro project to maintain a cleaner dependency structure while still providing performance comparison capabilities.

## Benchmark Categories

### Basic Operations

#### Identity (`identity.rs`)
Tests the overhead of basic stream processing with identity transformations. Useful for measuring the baseline performance of each framework.

#### Arithmetic (`arithmetic.rs`)
Benchmarks basic arithmetic operations on streams, comparing how each framework handles computational workloads.

#### Upcase (`upcase.rs`)
String transformation benchmark that converts text to uppercase. Tests string processing performance.

### Dataflow Patterns

#### Fan-In (`fan_in.rs`)
Benchmarks scenarios where multiple input streams merge into a single output stream.

#### Fan-Out (`fan_out.rs`)
Tests splitting a single input stream into multiple output streams.

#### Fork-Join (`fork_join.rs`)
Evaluates fork-join parallelism patterns where computation splits and then rejoins.

#### Diamond (`words_diamond.rs`)
Tests diamond-shaped dataflow patterns with text processing.

### Join Operations

#### Join (`join.rs`)
Standard join operations between two streams.

#### Symmetric Hash Join (`symmetric_hash_join.rs`)
Benchmarks symmetric hash join algorithms, a common pattern in stream processing.

### Advanced Patterns

#### Reachability (`reachability.rs`)
Graph reachability algorithms using dataflow operations. Tests iterative computations and fixed-point algorithms. Includes real graph data from:
- `reachability_edges.txt` - Edge list
- `reachability_reachable.txt` - Expected reachable nodes

#### Micro Operations (`micro_ops.rs`)
Fine-grained benchmarks of individual operations to measure specific operator performance.

#### Futures (`futures.rs`)
Async/await and futures-based operations.

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed:
```bash
rustc --version
cargo --version
```

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

```bash
# Run only reachability benchmarks
cargo bench -p benches --bench reachability

# Run only join benchmarks  
cargo bench -p benches --bench join

# Run only micro-operations benchmarks
cargo bench -p benches --bench micro_ops
```

### Viewing Results

Benchmark results are saved in `target/criterion/`. Open the HTML files in your browser:

```bash
# View all results
open target/criterion/report/index.html
```

## Understanding Results

Each benchmark compares implementations across:
- **DFIR** - Hydro's dataflow IR
- **Timely** - TimelySataflow implementation
- **Differential** - Differential-dataflow implementation (where applicable)

Results show:
- **Time** - Execution time (lower is better)
- **Throughput** - Operations per second (higher is better)
- **Comparison** - Relative performance between implementations

## Dependencies

The benchmarks depend on:
- `dfir_rs` - Hydro's DFIR implementation (from main repo)
- `timely` (timely-master) - TimelySataflow
- `differential-dataflow` (differential-dataflow-master) - Differential dataflow
- `criterion` - Benchmarking framework

## Contributing

When adding new benchmarks:
1. Add the benchmark file to `benches/benches/`
2. Register it in `benches/Cargo.toml` under `[[bench]]` sections
3. Follow the existing pattern of comparing DFIR, Timely, and Differential implementations
4. Update this documentation with benchmark details

## Data Files

Some benchmarks use external data files:
- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words
- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Performance Tips

For accurate results:
- Close unnecessary applications
- Run benchmarks multiple times
- Use release mode (Criterion does this automatically)
- Consider CPU frequency scaling and thermal throttling
- Run on a quiet system without heavy background tasks
