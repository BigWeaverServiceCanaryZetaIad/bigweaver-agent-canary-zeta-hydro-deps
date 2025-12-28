# Timely and Differential-Dataflow Benchmarks

This directory contains performance benchmarks comparing Hydro (DFIR) against `timely-dataflow` and `differential-dataflow` frameworks.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on external dataflow frameworks. This separation keeps the main service repository lean while preserving comprehensive performance testing capabilities.

## Benchmark Descriptions

### arithmetic
Compares arithmetic operations across different dataflow implementations:
- Timely dataflow
- Hydroflow (DFIR) compiled and surface syntax
- Raw pipeline implementation
- Iterator-based approaches

**Operations:** 20 sequential map operations adding 1 to each element  
**Input:** 1,000,000 integers

### fan_in
Tests multiple input streams merging into a single output stream.

**Pattern:** Multiple sources concatenating into one stream  
**Frameworks:** Timely, Hydroflow

### fan_out
Tests single stream splitting into multiple output streams.

**Pattern:** One source splitting into multiple sinks  
**Frameworks:** Timely, Hydroflow

### fork_join
Benchmarks fork-join patterns with filtering operations.

**Pattern:** Split stream, filter even/odd, rejoin  
**Operations:** 20 levels of fork-join with filtering  
**Frameworks:** Timely, Hydroflow

### identity
Identity transformation (no-op) benchmarks to measure framework overhead.

**Operations:** Various no-op transformations  
**Frameworks:** Timely, Hydroflow, raw implementations

### join
Hash join operations with different value types.

**Join Types:**
- `usize`/`usize` joins
- `String`/`String` joins
- Mixed type joins

**Input:** 100,000 key-value pairs per side  
**Frameworks:** Timely, Hydroflow

### reachability
Graph reachability using iterative dataflow operators.

**Algorithm:** Transitive closure on directed graph  
**Data:** Real graph data from included files  
**Frameworks:** Differential-dataflow, Hydroflow

**Data Files:**
- `reachability_edges.txt` - Graph edge list
- `reachability_reachable.txt` - Expected reachable nodes

### upcase
String uppercase transformation with different strategies.

**Input:** Word list from `words_alpha.txt`  
**Strategies:**
- Direct string manipulation
- Dataflow operators

**Frameworks:** Timely, Hydroflow

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p hydro-timely-differential-benches
```

### Run Specific Benchmark
```bash
cargo bench -p hydro-timely-differential-benches --bench reachability
cargo bench -p hydro-timely-differential-benches --bench arithmetic
cargo bench -p hydro-timely-differential-benches --bench join
```

### Run Specific Benchmark Function
```bash
cargo bench -p hydro-timely-differential-benches --bench arithmetic -- "timely"
cargo bench -p hydro-timely-differential-benches --bench join -- "usize/usize"
```

### Generate HTML Reports
```bash
cargo bench -p hydro-timely-differential-benches -- --noplot
```

HTML reports are generated in `../../target/criterion/` (relative to repository root).

### Performance Profiling
```bash
# Build with profiling information
cargo bench -p hydro-timely-differential-benches --profile profile -- --profile-time=5
```

## Repository Structure

```
benches/
├── Cargo.toml           # Package configuration with dependencies
├── build.rs             # Build script for generating benchmark code
├── README.md            # This file
└── benches/
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── upcase.rs
    ├── reachability_edges.txt
    ├── reachability_reachable.txt
    └── words_alpha.txt
```

## Dependencies

### External Framework Dependencies
- `timely-master` (v0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential dataflow framework

### Hydro Dependencies (Path Dependencies)
- `dfir_rs` - Hydro's DFIR runtime and API
- `sinktools` - Sink utilities for streaming operations

### Testing and Utilities
- `criterion` (v0.5.0) - Benchmarking framework with async and HTML report support
- `futures` (v0.3) - Async runtime utilities
- `tokio` (v1.29.0) - Async runtime for Hydroflow benchmarks
- `rand`, `rand_distr` - Random data generation
- `seq-macro` - Macro utilities for benchmark generation
- `nameof`, `static_assertions` - Development utilities

## Cross-Repository Setup

These benchmarks require the main Hydro repository to be in a sibling directory:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/    # Main Hydro repository
│   ├── dfir_rs/
│   └── sinktools/
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
    └── benches/
```

The path dependencies in `Cargo.toml` reference:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

## Build Script

The `build.rs` script generates benchmark code at compile time. Currently it generates:
- `fork_join_20.hf` - Hydroflow syntax for fork-join benchmark with 20 operations

## Understanding Benchmark Results

Criterion provides detailed statistical analysis including:
- **Mean execution time** - Average time per iteration
- **Standard deviation** - Variability in measurements
- **Throughput** - Items processed per second (when applicable)
- **Comparison** - Change from previous runs (if available)

### Interpreting Results

Lower execution times indicate better performance. When comparing frameworks:
- **Overhead** - Identity/no-op benchmarks show framework overhead
- **Scalability** - Arithmetic benchmarks show how frameworks handle operator chains
- **Join performance** - Critical for relational operations
- **Iterative computation** - Reachability shows differential dataflow capabilities

## Data Files

### reachability_edges.txt
Graph edges in format: `source_node target_node`  
Size: ~520 KB

### reachability_reachable.txt
Expected reachable nodes (one per line)  
Size: ~38 KB

### words_alpha.txt
English word list from https://github.com/dwyl/english-words  
Size: ~3.7 MB  
Used by: `upcase` benchmark

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `Cargo.toml`
3. Follow the existing pattern using Criterion
4. Include comparisons across frameworks when possible
5. Document the benchmark in this README
6. Ensure benchmarks are reproducible

## Troubleshooting

### Compilation Errors

**Path dependency not found:**
```
error: failed to load manifest for dependency `dfir_rs`
```
Solution: Ensure `bigweaver-agent-canary-hydro-zeta` repository exists in the sibling directory.

**Missing data files:**
```
error: couldn't read benches/reachability_edges.txt
```
Solution: Data files must be in `benches/benches/` directory alongside benchmark source files.

### Performance Issues

**Benchmarks take too long:**
- Reduce iteration count in the benchmark code
- Run specific benchmarks instead of all at once
- Use `--sample-size` flag to reduce samples

**Inconsistent results:**
- Close other applications
- Run on a consistent system state
- Use `--warm-up-time` and `--measurement-time` flags

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://hydro.run/)
