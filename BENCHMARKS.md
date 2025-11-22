# Benchmark Documentation

This document provides detailed information about each benchmark in the hydro-deps repository, including what they test, how to run them, and how to interpret results.

## Table of Contents

- [Overview](#overview)
- [Running Benchmarks](#running-benchmarks)
- [Benchmark Descriptions](#benchmark-descriptions)
  - [Arithmetic](#arithmetic)
  - [Fan In](#fan-in)
  - [Fan Out](#fan-out)
  - [Fork Join](#fork-join)
  - [Identity](#identity)
  - [Join](#join)
  - [Reachability](#reachability)
  - [Upcase](#upcase)
- [Understanding Results](#understanding-results)
- [Performance Analysis](#performance-analysis)

## Overview

These benchmarks compare performance characteristics of different dataflow frameworks:

- **Timely Dataflow** - Low-level dataflow framework
- **Differential Dataflow** - Incremental computation framework built on timely
- **Hydroflow/DFIR** - Modern dataflow framework (when available)
- **Baseline implementations** - Raw Rust implementations for comparison

Each benchmark measures throughput, latency, and overhead characteristics to understand the performance trade-offs of each framework.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p hydro-deps-benchmarks
```

### Run Specific Benchmark

```bash
# Single benchmark
cargo bench -p hydro-deps-benchmarks --bench arithmetic

# Multiple benchmarks
cargo bench -p hydro-deps-benchmarks --bench arithmetic --bench identity
```

### Quick Benchmark (Reduced Sample Size)

For faster iteration during development:

```bash
cargo bench -p hydro-deps-benchmarks -- --quick
```

### Save Baseline for Comparison

```bash
# Save current results as baseline
cargo bench -p hydro-deps-benchmarks -- --save-baseline before-optimization

# Run after changes
cargo bench -p hydro-deps-benchmarks -- --baseline before-optimization
```

## Benchmark Descriptions

### Arithmetic

**File:** `benchmarks/benches/arithmetic.rs`

**Purpose:** Measures the overhead of pipeline arithmetic operations across frameworks.

**What it tests:**
- Pipeline of map operations performing arithmetic (addition)
- Framework overhead vs. raw computation cost
- Operator chaining efficiency

**Implementations:**
- `babyflow` - Early prototype implementation
- `pipeline` - Multi-threaded channel-based pipeline
- `raw copy` - Vector-based minimal overhead baseline
- `iter` - Iterator-based pipeline
- `timely` - Timely dataflow implementation

**Configuration:**
- Number of operations: 20 chained map operations
- Data size: 1,000,000 integers

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench arithmetic
```

**Interpreting results:**
- Compare `raw copy` baseline to understand minimum possible overhead
- `timely` results show dataflow framework overhead
- Pipeline results demonstrate multi-threading costs

---

### Fan In

**File:** `benchmarks/benches/fan_in.rs`

**Purpose:** Tests multiple input streams merging into a single output stream.

**What it tests:**
- Merging multiple independent data sources
- Synchronization overhead across input streams
- Framework's ability to handle multiple inputs efficiently

**Implementations:**
- `timely` - Using timely's concat/merge operators
- `babyflow` - Early prototype merge implementation

**Configuration:**
- Number of input streams: Varies by test
- Data distribution: Even across inputs

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench fan_in
```

**Use cases:**
- Aggregating data from multiple sensors
- Combining results from parallel computations
- Multi-source data ingestion

---

### Fan Out

**File:** `benchmarks/benches/fan_out.rs`

**Purpose:** Tests broadcasting a single stream to multiple outputs.

**What it tests:**
- Data duplication overhead
- Parallel consumer handling
- Framework's broadcast efficiency

**Implementations:**
- `timely` - Using timely's broadcast operators
- `babyflow` - Early prototype broadcast

**Configuration:**
- Number of output streams: Varies by test
- Broadcast strategy: Framework-dependent

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench fan_out
```

**Use cases:**
- Distributing data to multiple consumers
- Parallel analytics pipelines
- Multi-sink data flows

---

### Fork Join

**File:** `benchmarks/benches/fork_join.rs`

**Purpose:** Measures fork/join parallel processing patterns.

**What it tests:**
- Splitting work across parallel branches
- Synchronization after parallel processing
- Load balancing and coordination overhead

**Implementations:**
- `timely` - Fork/join using timely operators
- `babyflow` - Early prototype implementation
- Baseline - Raw threading comparison

**Configuration:**
- Parallelism level: Varies by test
- Work distribution: Even across branches

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench fork_join
```

**Use cases:**
- MapReduce-style computations
- Parallel data processing
- Work distribution patterns

---

### Identity

**File:** `benchmarks/benches/identity.rs`

**Purpose:** Measures minimal framework overhead with passthrough operations.

**What it tests:**
- Base framework overhead without computation
- Data copying/transfer costs
- Operator invocation overhead

**Implementations:**
- `babyflow` - Prototype passthrough
- `pipeline` - Channel-based passthrough
- `raw copy` - Vector copy baseline
- `timely` - Timely identity operator

**Configuration:**
- Operation: Pure identity (no transformation)
- Data size: 1,000,000 elements

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench identity
```

**Interpreting results:**
- This benchmark establishes the "tax" of using each framework
- Compare all implementations to `raw copy` baseline
- Lower is better - represents framework efficiency

---

### Join

**File:** `benchmarks/benches/join.rs`

**Purpose:** Tests join operations between two data streams.

**What it tests:**
- Hash join implementation efficiency
- Memory usage patterns
- Synchronization between joined streams

**Implementations:**
- `timely` - Using timely's join operators

**Configuration:**
- Join type: Inner join
- Data size: Varies by test
- Key distribution: Configurable

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench join
```

**Use cases:**
- Database-style join operations
- Stream correlation
- Multi-stream aggregation

---

### Reachability

**File:** `benchmarks/benches/reachability.rs`

**Purpose:** Graph reachability using iterative computation.

**What it tests:**
- Iterative/recursive dataflow patterns
- Join and filter efficiency in loops
- State management across iterations

**Implementations:**
- `timely` - Using feedback loops and iterative operators
- `hydroflow` - Using Hydroflow's graph operators (if available)

**Data:**
- Input: `benchmarks/benches/data/reachability_edges.txt` - Graph edges
- Expected: `benchmarks/benches/data/reachability_reachable.txt` - Ground truth

**Configuration:**
- Graph structure: Pre-defined test graph
- Starting node: Node 1
- Algorithm: Iterative reachability expansion

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench reachability
```

**Use cases:**
- Graph algorithms
- Network analysis
- Dependency resolution
- Social network analysis

**Notes:**
- This is one of the most complex benchmarks
- Tests framework's ability to handle iterative computation
- Results are validated against ground truth

---

### Upcase

**File:** `benchmarks/benches/upcase.rs`

**Purpose:** String transformation operations.

**What it tests:**
- String processing overhead
- Memory allocation patterns
- Transformation operator efficiency

**Implementations:**
- `timely` - Using timely's map operator
- `babyflow` - Prototype string transformation
- Baseline - Raw iterator transformation

**Configuration:**
- Operation: Convert strings to uppercase
- Data: Various string lengths and counts

**How to run:**
```bash
cargo bench -p hydro-deps-benchmarks --bench upcase
```

**Use cases:**
- Text processing pipelines
- Data normalization
- String manipulation workloads

---

## Understanding Results

### Criterion Output

Criterion provides detailed statistical analysis:

```
arithmetic/timely       time:   [45.231 ms 45.789 ms 46.421 ms]
                        thrpt:  [21.549 Melem/s 21.851 Melem/s 22.120 Melem/s]
```

**Key metrics:**
- **time:** Time to complete benchmark (lower is better)
  - First value: Lower bound (fastest observed)
  - Second value: Best estimate (statistical mean)
  - Third value: Upper bound (slowest observed)
- **thrpt:** Throughput in elements per second (higher is better)

### HTML Reports

Detailed HTML reports are generated in `target/criterion/`:

```bash
# View in browser
open target/criterion/report/index.html
```

Reports include:
- Violin plots showing distribution
- Line plots showing trends over time
- Statistical analysis (mean, median, std dev)
- Comparison with previous runs

### Interpreting Performance

**Comparing frameworks:**
1. Look at the best estimate (middle value)
2. Consider the confidence intervals (outer values)
3. Check throughput metrics for easier comparison
4. Review HTML reports for visual comparison

**What's fast enough?**
- Depends on your use case and data volume
- Consider total pipeline throughput, not just single operator
- Factor in development complexity vs. performance needs

## Performance Analysis

### Baseline Comparisons

Each benchmark should be evaluated against baseline implementations:

**Raw baseline** → Minimum possible overhead (theoretical limit)
**Iterator baseline** → Idiomatic Rust without frameworks
**Framework implementations** → Overhead of abstraction

### Framework Trade-offs

**Timely Dataflow:**
- ✅ Low-level control and optimization potential
- ✅ Excellent for complex dataflow graphs
- ⚠️ More verbose code
- ⚠️ Steeper learning curve

**Differential Dataflow:**
- ✅ Incremental computation benefits
- ✅ Automatic change propagation
- ⚠️ Higher baseline overhead
- ⚠️ Best for incremental workloads

**Hydroflow/DFIR:**
- ✅ Higher-level abstractions
- ✅ More ergonomic API
- ⚠️ Newer, less optimized (improving)

### Optimization Tips

**If benchmarks show unexpected slowness:**

1. **Check data sizes** - Too small data may not show realistic performance
2. **Profile with flamegraph** - Identify actual bottlenecks
3. **Review operator choice** - Some operators have better alternatives
4. **Consider batch sizes** - Larger batches often more efficient
5. **Check for unnecessary clones** - Data copying can dominate

**Profiling example:**
```bash
cargo bench -p hydro-deps-benchmarks --bench arithmetic --profile-time 10
```

## Adding New Benchmarks

When adding new benchmarks:

1. **Create benchmark file** in `benchmarks/benches/`
2. **Add `[[bench]]` entry** in `benchmarks/Cargo.toml`
3. **Include multiple implementations** for comparison
4. **Add data files** to `benchmarks/benches/data/` if needed
5. **Document here** with similar structure
6. **Update README.md** with benchmark name

## Continuous Benchmarking

For tracking performance over time:

```bash
# Save baseline
cargo bench -p hydro-deps-benchmarks -- --save-baseline main

# After changes
cargo bench -p hydro-deps-benchmarks -- --baseline main
```

Results show relative performance changes, making regressions easy to spot.

## Troubleshooting

**Benchmark fails to compile:**
- Check that all dependencies are available
- Ensure correct Rust version (1.70+)
- Verify timely/differential-dataflow versions

**Benchmark times out:**
- Reduce data size for quick tests
- Use `--quick` flag for faster iteration
- Check for infinite loops in implementations

**Results are inconsistent:**
- Close other applications to reduce noise
- Run on dedicated benchmark machine if possible
- Increase sample size with `--sample-size N`

**Need faster benchmarks during development:**
```bash
# Reduce measurement time
cargo bench -p hydro-deps-benchmarks -- --quick
```

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow Documentation](https://hydro.run/)
