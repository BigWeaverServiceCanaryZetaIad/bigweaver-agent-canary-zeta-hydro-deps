# Benchmark Descriptions

This document provides detailed descriptions of each benchmark in the suite, including their purpose, implementation details, and what they measure.

## Overview

All benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework for consistent, statistically rigorous performance measurements. Each benchmark typically includes multiple implementations to compare:

- **Raw/Baseline**: Pure Rust implementations with minimal overhead
- **Iter**: Rust iterator-based implementations
- **Pipeline**: Channel-based pipeline implementations
- **Hydroflow (dfir_rs)**: Hydroflow framework implementations (both compiled and surface syntax)
- **Timely**: Timely Dataflow framework implementations
- **Differential**: Differential Dataflow framework implementations

## Benchmark Suite

### arithmetic.rs

**Purpose**: Measures the overhead of dataflow frameworks for simple arithmetic operations.

**Description**: Creates a pipeline of 20 consecutive addition operations (+1) on a stream of 1,000,000 integers. This benchmark isolates the framework overhead from complex logic.

**Implementations**:
- `arithmetic/raw`: Vec-based implementation with minimal overhead
- `arithmetic/iter`: Pure iterator chain
- `arithmetic/iter-collect`: Iterator with intermediate collections
- `arithmetic/pipeline`: Channel-based multi-threaded pipeline
- `arithmetic/dfir_rs/compiled`: Hydroflow with compiled syntax
- `arithmetic/dfir_rs/compiled_no_cheating`: Hydroflow with explicit black_box calls
- `arithmetic/dfir_rs/surface`: Hydroflow with surface syntax
- `arithmetic/timely`: Timely Dataflow implementation

**Key Metrics**: Throughput for simple operations, framework overhead

---

### fan_in.rs

**Purpose**: Measures performance when multiple input streams merge into a single output.

**Description**: Tests the fan-in pattern where multiple parallel streams of data converge into one processing pipeline.

**Implementations**:
- Raw baseline implementation
- Hydroflow compiled syntax
- Hydroflow surface syntax
- Timely Dataflow implementation

**Key Metrics**: Merge overhead, synchronization costs

---

### fan_out.rs

**Purpose**: Measures performance when one input stream splits to multiple outputs.

**Description**: Tests the fan-out pattern where a single stream is distributed to multiple parallel processing paths.

**Implementations**:
- Raw baseline implementation
- Hydroflow compiled syntax
- Hydroflow surface syntax
- Timely Dataflow implementation

**Key Metrics**: Split overhead, data distribution costs

---

### fork_join.rs

**Purpose**: Measures fork-join parallelism patterns with conditional routing.

**Description**: Implements a fork-join pattern with 20 levels of splitting (even/odd filter) and joining. Uses build.rs to generate the Hydroflow code at compile time.

**Implementations**:
- Pipeline-based implementation
- Hydroflow compiled syntax (generated)
- Hydroflow surface syntax (generated)
- Timely Dataflow implementation

**Key Metrics**: Fork-join overhead, conditional routing performance

---

### identity.rs

**Purpose**: Baseline measurement of pure data pass-through with no transformations.

**Description**: Passes data through the framework without any modifications. This benchmark measures the absolute minimum overhead of each framework.

**Implementations**:
- Raw baseline (minimal overhead)
- Iterator-based
- Hydroflow compiled syntax
- Hydroflow surface syntax
- Timely Dataflow implementation

**Key Metrics**: Minimum framework overhead, data copying costs

---

### join.rs

**Purpose**: Measures join operation performance across different frameworks.

**Description**: Tests hash join operations on two input streams, comparing the join implementations in different dataflow frameworks.

**Implementations**:
- HashMap-based raw implementation
- Hydroflow compiled syntax
- Hydroflow surface syntax
- Timely Dataflow implementation

**Key Metrics**: Join algorithm efficiency, hash table performance

---

### reachability.rs

**Purpose**: Measures graph reachability algorithm performance.

**Description**: Implements iterative graph reachability on a real graph dataset (included as `reachability_edges.txt` and `reachability_reachable.txt`). This benchmark tests more complex, iterative algorithms.

**Implementations**:
- HashMap-based iterative implementation
- Hydroflow compiled syntax with iteration
- Hydroflow surface syntax with iteration
- Differential Dataflow iterative implementation

**Key Metrics**: Iterative algorithm performance, graph processing efficiency

**Data Files**:
- `reachability_edges.txt`: Graph edges (source -> destination pairs)
- `reachability_reachable.txt`: Expected reachable nodes for verification

---

### upcase.rs

**Purpose**: Measures string transformation performance.

**Description**: Converts a large corpus of words to uppercase, testing string processing capabilities. Uses the words_alpha.txt dataset.

**Implementations**:
- Iterator-based string transformation
- Hydroflow compiled syntax
- Hydroflow surface syntax
- Timely Dataflow implementation
- Differential Dataflow implementation

**Key Metrics**: String processing throughput, memory allocation overhead

**Data Files**:
- `words_alpha.txt`: English words dataset (~370K words)

---

### futures.rs

**Purpose**: Measures async future handling and polling overhead.

**Description**: Tests Hydroflow's ability to handle async futures, including immediately available futures and delayed futures that require waking.

**Implementations**:
- `futures/immediately_available`: Futures that resolve immediately
- `futures/delayed/initial`: Initial polling of pending futures
- `futures/delayed/waiting`: Polling when futures remain pending
- `futures/delayed/ready`: Polling when futures become ready
- `futures/delayed/done`: Polling after futures complete

**Key Metrics**: Future polling overhead, waker management, async runtime efficiency

---

### micro_ops.rs

**Purpose**: Micro-benchmarks for individual Hydroflow operations.

**Description**: Isolated benchmarks for specific Hydroflow operators to identify per-operation costs.

**Key Metrics**: Individual operator overhead

---

### symmetric_hash_join.rs

**Purpose**: Measures symmetric hash join performance.

**Description**: Tests symmetric hash join implementation where both inputs are treated symmetrically.

**Key Metrics**: Join performance, memory usage for hash tables

---

### words_diamond.rs

**Purpose**: Measures diamond-shaped dataflow patterns.

**Description**: Tests a diamond pattern where data splits, processes through parallel paths, and merges. Uses the words dataset.

**Implementations**:
- Hydroflow implementations
- Baseline comparisons

**Key Metrics**: Split-merge pattern overhead, parallel processing efficiency

**Data Files**:
- `words_alpha.txt`: Shared with upcase benchmark

---

## Data Files

### reachability_edges.txt
Graph edges for reachability benchmark. Format: `source destination` (one per line).

### reachability_reachable.txt
Expected reachable nodes for verification. Format: one node ID per line.

### words_alpha.txt
English words dataset from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt). Contains ~370,000 words for string processing benchmarks.

---

## Running Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p benches --bench arithmetic

# Run benchmarks matching a pattern
cargo bench -p benches -- timely

# Run with specific filter
cargo bench -p benches --bench reachability -- differential
```

## Interpreting Results

Criterion provides:
- **Mean execution time**: Average time per iteration
- **Standard deviation**: Variability in measurements
- **Median**: Middle value, less affected by outliers
- **Throughput**: Elements processed per second (when applicable)
- **Change detection**: Automatic detection of performance regressions

Results are saved to `target/criterion/` and include:
- HTML reports for visual analysis
- Statistical analysis
- Comparison with previous runs

## Adding New Benchmarks

When adding a new benchmark:

1. **Create the benchmark file** in `benches/benches/your_benchmark.rs`
2. **Implement multiple versions** (raw, Hydroflow, Timely, etc.)
3. **Register in Cargo.toml**:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
4. **Include data files** if needed (in the same directory)
5. **Document the benchmark** in this file
6. **Verify correctness** before measuring performance

## Performance Considerations

### Framework Overhead
Each framework has different overhead characteristics:
- **Raw implementations**: Minimal overhead, baseline for comparison
- **Iterators**: Compiler optimization potential, minimal allocation
- **Hydroflow**: Optimized for streaming, compilation overhead
- **Timely**: Excellent for distributed scenarios, higher local overhead
- **Differential**: Optimized for incremental computation

### Measurement Best Practices
- Run benchmarks on a quiet system
- Use consistent hardware across comparisons
- Warm up JIT/compilation before measurement
- Consider memory allocations, not just CPU time
- Account for setup/teardown time separately

## Continuous Performance Monitoring

These benchmarks can be integrated into CI/CD pipelines to:
1. **Detect regressions**: Automatically catch performance degradations
2. **Track improvements**: Validate optimization efforts
3. **Compare implementations**: Make informed architectural decisions
4. **Maintain baselines**: Keep historical performance data