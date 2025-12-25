# Timely and Differential-Dataflow Benchmarks

This package contains performance benchmarks for timely dataflow and differential-dataflow systems, including comparative benchmarks against dfir_rs implementations.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated dependencies repository to:
- Reduce dependency complexity in the main repository
- Improve compilation times by isolating heavy dependencies
- Maintain clean separation between core functionality and benchmark-specific dependencies
- Enable dedicated performance testing and comparison

## Available Benchmarks

The following benchmarks are available:

### 1. **arithmetic** (`arithmetic.rs`)
Compares different implementations of arithmetic pipeline operations:
- `pipeline`: Standard thread-based pipeline
- `timely`: Timely dataflow implementation
- `dfir_rs/compiled`: Compiled dfir_rs implementation
- `dfir_rs/compiled_no_cheating`: Compiled dfir_rs without optimizations
- `dfir_rs/surface`: Surface syntax dfir_rs implementation

### 2. **fan_in** (`fan_in.rs`)
Tests fan-in patterns where multiple streams converge:
- `dfir_rs/surface`: dfir_rs surface syntax implementation
- `timely`: Timely dataflow implementation

### 3. **fan_out** (`fan_out.rs`)
Tests fan-out patterns where streams are split:
- `dfir_rs/surface`: dfir_rs surface syntax implementation
- `timely`: Timely dataflow implementation

### 4. **fork_join** (`fork_join.rs`)
Tests fork-join patterns with multiple splits and joins:
- `dfir_rs`: Low-level dfir_rs implementation
- `dfir_rs/surface`: Surface syntax dfir_rs implementation
- `timely`: Timely dataflow implementation

### 5. **identity** (`identity.rs`)
Basic identity operation benchmarks:
- `pipeline`: Standard thread-based pipeline
- `timely`: Timely dataflow implementation
- `dfir_rs/compiled`: Compiled dfir_rs implementation
- `dfir_rs`: Low-level dfir_rs implementation
- `dfir_rs/surface`: Surface syntax dfir_rs implementation

### 6. **join** (`join.rs`)
Join operation benchmarks:
- `timely`: Timely dataflow join implementation
- `differential`: Differential-dataflow join implementation

### 7. **reachability** (`reachability.rs`)
Graph reachability algorithm benchmarks using real-world graph data:
- `timely`: Timely dataflow implementation
- `differential`: Differential-dataflow implementation
- `dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `dfir_rs`: Low-level dfir_rs implementation
- `dfir_rs/surface_cheating`: Optimized surface syntax version
- `dfir_rs/surface`: Standard surface syntax version

**Data Files:**
- `reachability_edges.txt`: Graph edge data (55k edges)
- `reachability_reachable.txt`: Expected reachable nodes

### 8. **upcase** (`upcase.rs`)
String processing benchmarks:
- `timely`: Timely dataflow implementation
- `dfir_rs/surface`: Surface syntax dfir_rs implementation

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p timely-benchmarks
```

### Run Specific Benchmark
```bash
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p timely-benchmarks --bench reachability
cargo bench -p timely-benchmarks --bench identity
```

### Run Specific Test Within a Benchmark
```bash
cargo bench -p timely-benchmarks --bench arithmetic -- "pipeline"
cargo bench -p timely-benchmarks --bench arithmetic -- "dfir_rs"
```

### Quick Check (Compile Without Running)
```bash
cargo bench -p timely-benchmarks --no-run
```

## Performance Comparison

These benchmarks allow comparing performance across different implementations:

1. **Timely Dataflow**: Distributed dataflow computation framework
2. **Differential Dataflow**: Incremental computation on top of timely
3. **dfir_rs**: Hydro project's dataflow implementation with multiple execution strategies

The benchmarks demonstrate:
- Raw performance differences
- Compilation vs. interpretation tradeoffs
- Surface syntax ergonomics vs. performance
- Different optimization strategies

## Dependencies

This package depends on:
- `timely-master` (v0.13.0-dev.1): Timely dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1): Differential dataflow framework
- `dfir_rs`: From the main hydro repository (for comparison benchmarks)
- `sinktools`: Utility tools from the main hydro repository
- `criterion`: Benchmarking framework

## Build System

The package includes a custom `build.rs` script that generates code for the fork-join benchmarks, creating test files with configurable operation counts.

## Notes

### Cross-Repository Dependencies

This package references `dfir_rs` and `sinktools` from the main `bigweaver-agent-canary-hydro-zeta` repository using relative paths. This allows:
- Direct performance comparisons between implementations
- Ensuring benchmarks stay synchronized with the latest code
- Avoiding code duplication

### Benchmark Characteristics

- **NUM_INTS**: Most benchmarks use 1,000,000 integers for testing
- **NUM_OPS**: Chain operations typically use 20 operations
- **Criterion**: All benchmarks use the criterion framework for statistical analysis
- **Harness**: All benchmarks disable the default test harness (`harness = false`)

## Migration History

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches` to this repository as part of a dependency cleanup effort. See the main repository's `TIMELY_REMOVAL_SUMMARY.md` for details about the migration.

## Related Documentation

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Original location: `bigweaver-agent-canary-hydro-zeta/benches`
- Migration documentation: `TIMELY_REMOVAL_SUMMARY.md` in main repository
