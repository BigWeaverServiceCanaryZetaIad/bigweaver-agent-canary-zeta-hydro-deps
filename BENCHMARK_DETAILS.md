# Benchmark Details

This document provides detailed information about each benchmark in the repository, including purpose, implementation details, and performance characteristics.

## Overview

All benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework for statistical measurement and reporting. Each benchmark compares multiple implementations of the same operation to highlight performance differences between approaches.

## Benchmark Catalog

### 1. Arithmetic (`arithmetic.rs`)

**Purpose**: Measures the overhead of dataflow frameworks for simple arithmetic operations.

**Operation**: Chains 20 addition operations (incrementing by 1 each time) over 1,000,000 integers.

**Implementations**:
- `arithmetic/pipeline`: Standard Rust channels with thread-per-stage pipeline
- `arithmetic/raw`: Raw vector operations (theoretical minimum)
- `arithmetic/timely`: Timely-dataflow implementation
- `arithmetic/dfir_rs/interpreted`: Hydroflow interpreted mode
- `arithmetic/dfir_rs/compiled`: Hydroflow compiled mode
- `arithmetic/dfir_rs/compiled_no_cheating`: Hydroflow compiled with realistic data flow

**Key Metrics**:
- Throughput (operations/second)
- Latency per operation
- Framework overhead

**Typical Results**:
- Raw implementation: ~5-10ms (baseline)
- Pipeline: ~150-200ms
- Timely: ~200-300ms
- Hydroflow compiled: ~100-150ms

**Use Case**: Evaluating framework overhead for compute-intensive operations.

---

### 2. Fan-In (`fan_in.rs`)

**Purpose**: Tests the performance of merging multiple input streams into a single output stream.

**Operation**: Merges 2 streams of 1,000,000 integers each.

**Implementations**:
- `fan_in/timely`: Using timely's `Concatenate` operator
- `fan_in/dfir_rs`: Using hydroflow's union operation

**Key Metrics**:
- Stream merge throughput
- Memory usage during merge
- Scheduler efficiency

**Performance Factors**:
- Number of input streams
- Stream synchronization overhead
- Buffer management

**Use Case**: Understanding multi-source stream handling performance.

---

### 3. Fan-Out (`fan_out.rs`)

**Purpose**: Tests the performance of splitting a single input stream into multiple output streams.

**Operation**: Splits 1,000,000 integers into 2 output streams.

**Implementations**:
- `fan_out/timely`: Using timely's dataflow with multiple outputs
- `fan_out/dfir_rs`: Using hydroflow's tee operation

**Key Metrics**:
- Split throughput
- Memory duplication cost
- Broadcast efficiency

**Performance Factors**:
- Number of output streams
- Data copying overhead
- Cache efficiency

**Use Case**: Evaluating broadcast and multi-consumer patterns.

---

### 4. Fork-Join (`fork_join.rs`)

**Purpose**: Measures performance of fork-join patterns with filtering.

**Operation**: Repeatedly splits stream by even/odd, filters, and rejoins (20 levels deep).

**Implementations**:
- `fork_join/timely`: Using timely's filter and concatenate
- `fork_join/dfir_rs/interpreted`: Hydroflow interpreted mode
- `fork_join/dfir_rs/compiled`: Hydroflow compiled mode (generated from build.rs)

**Key Metrics**:
- Pattern complexity handling
- Operator composition overhead
- Branch prediction efficiency

**Special Features**:
- Uses code generation in `build.rs` for deep nesting
- Tests operator fusion optimizations

**Use Case**: Complex dataflow graph performance evaluation.

---

### 5. Identity (`identity.rs`)

**Purpose**: Baseline benchmark measuring minimum framework overhead.

**Operation**: Passes data through without transformation (identity function).

**Implementations**:
- `identity/raw`: Raw Rust implementation (baseline)
- `identity/pipeline`: Channel-based pipeline
- `identity/timely`: Timely-dataflow passthrough
- `identity/dfir_rs/interpreted`: Hydroflow interpreted
- `identity/dfir_rs/compiled`: Hydroflow compiled

**Key Metrics**:
- Minimum achievable latency
- Framework setup cost
- Data serialization overhead

**Typical Results**:
- Raw: ~1-2ms
- Pipeline: ~50-100ms
- Framework implementations: ~50-200ms

**Use Case**: Establishing baseline performance expectations.

---

### 6. Join (`join.rs`)

**Purpose**: Tests two-stream join operation performance.

**Operation**: Joins two streams of data based on a common key.

**Implementations**:
- `join/timely`: Using timely's custom join operator

**Key Metrics**:
- Join throughput
- Hash table performance
- Memory usage for buffering

**Performance Factors**:
- Key distribution
- Stream arrival order
- Buffer sizes

**Data Characteristics**:
- Configurable stream sizes
- Adjustable key overlap
- Variable arrival patterns

**Use Case**: Database-style join operation performance.

---

### 7. Upcase (`upcase.rs`)

**Purpose**: Simple string transformation benchmark.

**Operation**: Converts strings to uppercase.

**Implementations**:
- `upcase/timely`: Using timely's map operator

**Key Metrics**:
- String transformation throughput
- Memory allocation overhead
- Map operator efficiency

**Data**: Processes a configurable number of string transformations.

**Use Case**: String processing and transformation overhead.

---

### 8. Reachability (`reachability.rs`)

**Purpose**: Complex graph algorithm using differential dataflow.

**Operation**: Computes reachable nodes in a directed graph using iterative dataflow.

**Implementations**:
- `reachability/differential`: Using differential-dataflow's iterative operators
- `reachability/dfir_rs`: Hydroflow implementation

**Key Metrics**:
- Iteration convergence time
- Memory usage for incremental state
- Update propagation efficiency

**Data**:
- **reachability_edges.txt**: 532KB of graph edge data
- **reachability_reachable.txt**: 38KB of expected reachable nodes

**Algorithm**:
1. Load graph edges
2. Iteratively compute reachability using join and union
3. Converge when no new reachable nodes found

**Performance Factors**:
- Graph structure (connectivity, cycles)
- Number of iterations to convergence
- Differential update efficiency

**Use Case**: Iterative graph algorithms and incremental computation.

---

## Performance Comparison Matrix

| Benchmark    | Data Size    | Operations | Typical Time | Memory  | Complexity |
|--------------|--------------|------------|--------------|---------|------------|
| arithmetic   | 1M integers  | 20 ops     | 100-300ms    | Low     | Low        |
| fan_in       | 2M integers  | 1 merge    | 50-150ms     | Medium  | Low        |
| fan_out      | 1M integers  | 1 split    | 50-150ms     | Medium  | Low        |
| fork_join    | 1M integers  | 40 ops     | 200-500ms    | Medium  | High       |
| identity     | 1M integers  | 0 ops      | 1-100ms      | Low     | Minimal    |
| join         | Variable     | 1 join     | 100-500ms    | High    | Medium     |
| upcase       | Variable     | 1 map      | 50-200ms     | Low     | Low        |
| reachability | 532KB edges  | Iterative  | 500-2000ms   | High    | High       |

## Benchmark Categories

### Throughput Benchmarks
- **arithmetic**: Compute throughput
- **fan_in**: Merge throughput
- **fan_out**: Split throughput
- **upcase**: Map throughput

### Pattern Benchmarks
- **fork_join**: Complex pattern composition
- **join**: Two-stream coordination
- **fan_in/fan_out**: Stream routing

### Algorithm Benchmarks
- **reachability**: Iterative graph algorithm

### Baseline Benchmarks
- **identity**: Framework overhead baseline

## Implementation Comparison

### Raw Implementations
Pure Rust without dataflow frameworks - establishes theoretical minimum performance.

### Pipeline Implementations
Standard library channels with thread-per-stage - represents traditional concurrent programming.

### Timely-Dataflow Implementations
Structured dataflow with timely-dataflow library - low-level dataflow control.

### Differential-Dataflow Implementations
Incremental computation with differential-dataflow - efficient iterative algorithms.

### Hydroflow Implementations
- **Interpreted**: Dynamic dataflow graph interpretation
- **Compiled**: Static compilation with optimizations

## Running Specific Tests

### Run single implementation:
```bash
cargo bench -p hydro-deps-benches --bench arithmetic -- pipeline
cargo bench -p hydro-deps-benches --bench reachability -- differential
```

### Compare implementations:
```bash
# Run all arithmetic implementations
cargo bench -p hydro-deps-benches --bench arithmetic

# Compare against baseline
cargo bench -p hydro-deps-benches -- --baseline previous
```

### Generate detailed reports:
```bash
cargo bench -p hydro-deps-benches -- --verbose
```

## Interpreting Results

### Understanding Criterion Output

```
arithmetic/timely       time:   [152.34 ms 153.21 ms 154.15 ms]
                        change: [-2.1234% -1.5678% -0.9876%] (p = 0.00 < 0.05)
```

- **time**: [lower bound, estimate, upper bound] at 95% confidence
- **change**: Performance change vs. previous run
- **p-value**: Statistical significance (< 0.05 indicates significant change)

### Performance Indicators

- **Green "Performance has improved"**: Faster than previous run
- **Red "Performance has regressed"**: Slower than previous run
- **Yellow "No significant change"**: Within measurement noise

### What to Look For

1. **Relative Performance**: How do different implementations compare?
2. **Scalability**: Does performance scale with data size?
3. **Variance**: How stable are the measurements?
4. **Outliers**: Are there unusual performance spikes?

## Customizing Benchmarks

### Adjusting Parameters

Most benchmarks have constants at the top of the file:

```rust
const NUM_INTS: usize = 1_000_000;  // Data size
const NUM_OPS: usize = 20;          // Operation count
```

Modify these to test different scenarios.

### Adding New Implementations

To add a new implementation to a benchmark:

1. Add the implementation function
2. Register it with Criterion:
   ```rust
   c.bench_function("benchmark_name/variant", |b| {
       b.iter(|| your_implementation());
   });
   ```

## Best Practices

### For Accurate Measurements

1. **Close other applications** to reduce noise
2. **Run multiple times** to establish stable baseline
3. **Use release builds**: `cargo bench` automatically uses release mode
4. **Disable CPU frequency scaling** for consistency
5. **Keep system load low** during benchmarking

### For Meaningful Comparisons

1. **Use same hardware** for all comparison runs
2. **Establish baseline** before making changes
3. **Document system configuration** in benchmark reports
4. **Compare similar data sizes** across implementations
5. **Account for warmup effects** (Criterion handles this automatically)

## Performance Testing Workflow

1. **Establish baseline**: Run benchmarks before changes
2. **Make changes**: Implement optimizations or features
3. **Run benchmarks**: Measure performance after changes
4. **Compare results**: Use Criterion's comparison features
5. **Analyze differences**: Investigate significant changes
6. **Document findings**: Record results and insights
7. **Iterate**: Refine based on results

## Resources

- **Criterion Documentation**: https://bheisler.github.io/criterion.rs/book/
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Hydro Project**: https://github.com/hydro-project/hydro

---

**Note**: Actual performance numbers depend on hardware, system load, and Rust compiler version. The numbers provided are representative examples from typical development machines.
