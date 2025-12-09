# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external frameworks like Timely Dataflow and Differential Dataflow. These have been separated from the main Hydro repository to avoid including these dependencies in the core codebase.

## Contents

### Benchmarks

Performance comparison benchmarks between Hydro (dfir_rs) and other dataflow frameworks (Timely Dataflow and Differential Dataflow). The benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

- Reduce the dependency footprint of the main repository
- Separate performance comparison code from core functionality
- Maintain a cleaner project structure
- Avoid transitive dependencies on external frameworks in the main codebase

## Available Benchmarks

The following benchmarks are available in this repository:

- **arithmetic** - Arithmetic operation chains with various implementations (pipeline, timely, dfir_rs)
- **fan_in** - Multiple input streams merging into one
- **fan_out** - Single input stream splitting to multiple outputs
- **fork_join** - Parallel processing with join operations
- **futures** - Async/await based dataflow patterns
- **identity** - Simple passthrough operations
- **join** - Join operations on two streams
- **micro_ops** - Microbenchmarks for individual operations
- **reachability** - Graph reachability using differential dataflow and dfir_rs
- **symmetric_hash_join** - Hash-based join implementations
- **upcase** - String transformation operations
- **words_diamond** - Diamond-shaped dataflow patterns with word processing

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

To run a specific benchmark function:
```bash
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
```

## Dependencies

The benchmarks use the following key dependencies:

- **timely-master** (v0.13.0-dev.1) - Timely Dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential Dataflow framework
- **dfir_rs** (v0.14.0) - Hydro's dataflow IR
- **criterion** (v0.5.0) - Benchmarking framework
- **sinktools** (v0.0.1) - Utilities for dataflow sinks

## Directory Structure

```
benches/
├── Cargo.toml          # Benchmark package configuration
├── build.rs            # Build script for data file handling
├── README.md           # Benchmark-specific documentation
└── benches/
    ├── *.rs            # Benchmark source files
    ├── .gitignore      # Git ignore file for benchmark outputs
    ├── reachability_edges.txt      # Graph data for reachability benchmarks
    ├── reachability_reachable.txt  # Expected reachability results
    └── words_alpha.txt             # Word list for text processing benchmarks
```

## Purpose

This repository maintains the ability to run performance comparisons between Hydro and other dataflow frameworks while keeping the main Hydro repository focused on core functionality without transitive dependencies on external frameworks. This separation allows for independent execution and performance analysis without affecting the main codebase.