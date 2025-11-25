# Benchmark Details

This document provides detailed information about each benchmark in the repository.

## Overview

All benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework for statistical analysis and HTML report generation. Each benchmark compares timely/differential-dataflow implementations against Hydro (dfir_rs) implementations.

## Benchmark Configuration

### Common Parameters

- **NUM_OPS**: Number of operations (typically 20)
- **NUM_INTS**: Number of integers processed (typically 1,000,000)
- **Criterion Features**: async_tokio, html_reports

## Individual Benchmarks

### 1. Arithmetic (`arithmetic.rs`)

**Purpose**: Benchmarks arithmetic operations through dataflow pipelines.

**Patterns Tested**:
- Raw copy operations (baseline)
- Iterator-based processing
- Pipeline-based processing (threading)
- Timely dataflow implementation
- Hydro/dfir_rs implementation (compiled and interpreted)

**Key Operations**:
- Performs 20 consecutive add operations (+1) on 1 million integers
- Tests both compiled and interpreted Hydro variants

**Metrics**:
- Throughput (operations per second)
- Latency (time per operation)

**Timely Implementation**:
Uses `timely::dataflow::operators::{Inspect, Map, ToStream}` for dataflow construction.

---

### 2. Fan-In (`fan_in.rs`)

**Purpose**: Tests fan-in patterns where multiple input streams merge into a single output.

**Patterns Tested**:
- Raw copy operations
- Iterator-based merging
- Timely dataflow with Concatenate operator
- Hydro/dfir_rs union operations

**Key Operations**:
- Creates 20 parallel streams
- Merges all streams using union/concatenate
- Processes 1 million integers total

**Timely Implementation**:
Uses `timely::dataflow::operators::{Concatenate, Inspect, ToStream}`.

---

### 3. Fan-Out (`fan_out.rs`)

**Purpose**: Tests fan-out patterns where a single input splits into multiple outputs.

**Patterns Tested**:
- Raw copy with multiple destinations
- Iterator-based broadcasting
- Timely dataflow with multiple map branches
- Hydro/dfir_rs tee operations

**Key Operations**:
- Splits input stream into 20 parallel branches
- Each branch performs independent mapping
- Collects results from all branches

**Timely Implementation**:
Uses `timely::dataflow::operators::{Map, ToStream}`.

---

### 4. Fork-Join (`fork_join.rs`)

**Purpose**: Tests fork-join patterns with filtering and merging.

**Patterns Tested**:
- Raw iterator chains with filtering
- Timely dataflow with Filter and Concatenate
- Hydro/dfir_rs with filter and union operations

**Key Operations**:
- Repeatedly forks stream based on even/odd filtering
- Creates 20 levels of fork-join hierarchy
- Merges results back together

**Build-Time Code Generation**:
Uses `build.rs` to generate optimized Hydro code at compile time:
```rust
// Generates fork_join_20.hf with the complete pipeline
```

**Timely Implementation**:
Uses `timely::dataflow::operators::{Concatenate, Filter, Inspect, ToStream}`.

---

### 5. Identity (`identity.rs`)

**Purpose**: Tests simple pass-through operations (baseline for dataflow overhead).

**Patterns Tested**:
- Raw copy (minimal overhead)
- Direct iterator pass-through
- Timely dataflow with identity map
- Hydro/dfir_rs identity operations

**Key Operations**:
- Passes 1 million integers through 20 identity operations
- Measures pure dataflow overhead without computation

**Timely Implementation**:
Uses `timely::dataflow::operators::{Inspect, Map, ToStream}` with identity function.

---

### 6. Join (`join.rs`)

**Purpose**: Tests join operations between two streams.

**Patterns Tested**:
- Manual hash-based join
- Timely dataflow custom operator join
- Hydro/dfir_rs join operations

**Key Operations**:
- Creates two input streams (left and right)
- Joins based on key matching
- Processes joined tuples

**Data Distribution**:
- Uses random number generation for keys
- Configurable join selectivity

**Timely Implementation**:
Uses custom `Operator` with `timely::dataflow::channels::pact::Pipeline`.

---

### 7. Upcase (`upcase.rs`)

**Purpose**: Tests string transformation operations.

**Patterns Tested**:
- Raw string processing
- Iterator-based transformation
- Timely dataflow with map operations
- Hydro/dfir_rs string operations

**Key Operations**:
- Transforms strings to uppercase
- Processes word list through pipeline

**Data Source**:
Uses embedded word list (words_alpha.txt) with 370,000+ English words.

**Timely Implementation**:
Uses `timely::dataflow::operators::{Inspect, Map, ToStream}` for string operations.

---

### 8. Reachability (`reachability.rs`)

**Purpose**: Tests graph reachability using differential dataflow.

**Patterns Tested**:
- Manual iterative reachability (Rust collections)
- Differential dataflow with iteration
- Hydro/dfir_rs graph operations

**Key Operations**:
- Computes transitive closure of a graph
- Uses fixed-point iteration
- Validates results against known reachable set

**Data Files**:
- `reachability_edges.txt`: Graph edges (521 KB)
- `reachability_reachable.txt`: Expected reachable nodes (38 KB)

**Differential Dataflow Implementation**:
```rust
use differential_dataflow::input::Input;
use differential_dataflow::operators::{Iterate, Join, Threshold};
```

**Algorithm**:
1. Start with initial edges
2. Iteratively compute: `reachable = edges.join(reachable).threshold()`
3. Continue until fixed point
4. Validate against expected results

---

## Performance Characteristics

### Expected Performance Ordering (Fastest to Slowest)

For most benchmarks:
1. **Raw copy**: Minimal overhead, baseline performance
2. **Iterator**: Good performance, some iterator overhead
3. **Hydro compiled**: Optimized compiled dataflow
4. **Timely**: Full dataflow with coordination overhead
5. **Hydro interpreted**: Flexibility with runtime overhead

### Factors Affecting Performance

- **Data volume**: Number of elements processed
- **Operation complexity**: Computational cost per element
- **Dataflow overhead**: Coordination and message passing
- **Memory allocation**: Buffer management and copying

## Interpreting Results

### Criterion Output

Criterion provides:
- **Mean**: Average execution time
- **Std. Dev**: Standard deviation of measurements
- **Confidence Intervals**: 95% confidence bounds
- **Outliers**: Anomalous measurements
- **Change**: Comparison to previous runs

### HTML Reports

View detailed results in `target/criterion/report/index.html`:
- Time series plots
- Distribution histograms
- Performance comparisons
- Statistical analysis

## Extending Benchmarks

### Adding a New Benchmark

1. Create benchmark file in `benches/benches/`:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   
   fn benchmark_name(c: &mut Criterion) {
       c.bench_function("category/name", |b| {
           b.iter(|| {
               // Benchmark code
           });
       });
   }
   
   criterion_group!(benches, benchmark_name);
   criterion_main!(benches);
   ```

2. Add entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "benchmark_name"
   harness = false
   ```

3. Run the new benchmark:
   ```bash
   cargo bench -p timely-differential-benchmarks --bench benchmark_name
   ```

## Troubleshooting

### Benchmark Fails to Build

- Check dependency versions in `Cargo.toml`
- Ensure rust-toolchain.toml specifies correct version
- Run `cargo clean && cargo build`

### Inconsistent Results

- Ensure system is not under heavy load
- Run benchmarks multiple times
- Check for background processes affecting CPU
- Use `--warm-up-time` and `--measurement-time` flags

### Out of Memory

- Reduce NUM_INTS or NUM_OPS constants
- Run benchmarks individually
- Increase system memory limits

## References

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/hydro-project/hydro)
