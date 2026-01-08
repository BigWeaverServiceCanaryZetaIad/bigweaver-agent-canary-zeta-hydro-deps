# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on timely-dataflow and differential-dataflow packages. These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to isolate these dependencies and improve build times for the main codebase.

## Purpose

These benchmarks provide performance comparisons between:
- Timely/Differential-Dataflow implementations
- Baseline Rust implementations (channels, iterators, raw loops)

## Available Benchmarks

### arithmetic.rs
Benchmarks arithmetic operations across different execution models:
- Pipeline-based (mpsc channels)
- Raw vector operations
- Iterator chains
- Timely dataflow

### fan_in.rs
Tests fan-in patterns where multiple streams merge:
- Timely concatenation
- Rust iterators (flat_map)
- For loops

### fan_out.rs
Tests fan-out patterns where a single stream splits:
- Timely dataflow
- Simple for loops

### fork_join.rs
Tests fork-join patterns with repeated splitting and merging:
- Timely dataflow with filters and concatenation
- Raw Rust vector operations

### identity.rs
Benchmarks identity transformation (no-op) overhead:
- Pipeline-based (mpsc channels)
- Raw vector operations
- Iterator chains
- Timely dataflow

### join.rs
Tests join operations with hash-based matching:
- Timely dataflow custom operator
- Baseline HashMap implementation
- Supports both usize and String types

### reachability.rs
Graph reachability using iterative dataflow:
- Timely dataflow with feedback loops
- Differential-Dataflow with iteration
- Uses external test data files (reachability_edges.txt, reachability_reachable.txt)

### upcase.rs
String transformation benchmarks:
- In-place uppercase conversion
- Allocating uppercase conversion
- String concatenation
- Timely dataflow, raw vectors, and iterators

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

To run specific test within a benchmark:
```bash
cargo bench -p benches --bench arithmetic -- timely
```

## Dependencies

- **criterion**: Benchmarking framework with statistical analysis
- **timely-master**: Timely dataflow framework (version 0.13.0-dev.1)
- **differential-dataflow-master**: Differential dataflow framework (version 0.13.0-dev.1)
- **tokio**: Async runtime
- Supporting libraries: futures, rand, seq-macro, static_assertions

## Build Script

The `build.rs` script generates code for the fork_join benchmark at build time, creating operator chains programmatically.

## Notes

- These benchmarks are separate from the Hydro-native benchmarks in the main repository
- Results can be compared with the main repository benchmarks to evaluate performance characteristics
- The `.gitignore` file excludes generated fork_join_*.hf files from version control
