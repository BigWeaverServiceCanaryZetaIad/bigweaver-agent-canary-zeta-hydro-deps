# Timely and Differential-Dataflow Benchmarks

Performance benchmarks comparing DFIR/Hydroflow implementations with timely-dataflow and differential-dataflow.

## Overview

This directory contains comprehensive benchmarks for comparing the performance of Hydro's DFIR and Hydroflow implementations against timely-dataflow and differential-dataflow. These benchmarks help measure performance characteristics across different dataflow patterns and operations.

## Available Benchmarks

### Basic Operations
- **arithmetic**: Basic arithmetic operations
- **identity**: Identity/pass-through operations
- **upcase**: String uppercase transformations
- **micro_ops**: Micro-level operation performance

### Dataflow Patterns
- **fan_in**: Fan-in pattern (multiple inputs, single output)
- **fan_out**: Fan-out pattern (single input, multiple outputs)
- **fork_join**: Fork-join parallelism patterns

### Join Operations
- **join**: Basic join operations
- **symmetric_hash_join**: Symmetric hash join benchmarks

### Complex Algorithms
- **reachability**: Graph reachability algorithms (includes test data files)
- **words_diamond**: Diamond pattern with word processing

### Async Operations
- **futures**: Futures and async operation benchmarks

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench reachability
```

### Run with Specific Options
```bash
# Run with quick mode (fewer samples)
cargo bench -p benches --bench identity -- --quick

# Run specific test within a benchmark
cargo bench -p benches --bench join -- "join/dfir_rs"
```

## Benchmark Data Files

- **words_alpha.txt** (3.7MB): English word list from https://github.com/dwyl/english-words
- **reachability_edges.txt** (521KB): Graph edges for reachability testing
- **reachability_reachable.txt** (38KB): Reachable nodes data

## Performance Comparison

Each benchmark typically includes implementations for:
- **dfir_rs**: DFIR implementation
- **hydroflow**: Hydroflow implementation  
- **timely**: Timely-dataflow implementation
- **differential**: Differential-dataflow implementation

This allows direct performance comparisons across different frameworks.

## Understanding Results

Benchmark results are generated using Criterion and include:
- Mean execution time
- Standard deviation
- Throughput measurements
- HTML reports (in `target/criterion/`)

## Local Development

For local development with the main Hydro repository, update `Cargo.toml` to use path dependencies:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## More Information

See the repository root README.md for:
- Setup instructions
- Quick start guide
- Detailed testing procedures
- Troubleshooting tips
