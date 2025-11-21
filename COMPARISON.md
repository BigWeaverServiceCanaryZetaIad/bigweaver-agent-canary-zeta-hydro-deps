# Performance Comparison Guide

This guide explains how to use the benchmarks for performance comparisons between timely and differential-dataflow, and tracking performance over time.

## Comparing Timely vs Differential Dataflow

### Conceptual Differences

**Timely Dataflow:**
- Low-level dataflow framework
- Provides streaming operators
- Manual state management
- Lower overhead for simple operations
- More control over execution

**Differential Dataflow:**
- Built on top of Timely
- Incremental computation model
- Automatic state management for updates
- Higher initial cost, better for incremental updates
- Easier to reason about correctness

### When to Use Each

| Use Case | Recommended Framework | Reason |
|----------|----------------------|--------|
| One-time batch processing | Timely | Lower overhead |
| Streaming with infrequent updates | Timely | Simpler model sufficient |
| Incremental computation | Differential | Built for updates |
| Complex multi-way joins | Differential | Better indexing |
| Low-latency requirements | Timely | Less computational overhead |
| Maintaining query results | Differential | Automatic update propagation |

## Running Comparisons

### Side-by-Side Benchmark

```bash
# Run both benchmarks
./run-benchmarks.sh --timely-only
./run-benchmarks.sh --differential-only

# Results will be in target/criterion/
```

### Specific Operation Comparison

Compare similar operations across frameworks:

```bash
# Timely map operation
cargo bench --package timely-benchmarks --bench unary_operators -- map

# Differential map operation (via consolidate/distinct)
cargo bench --package differential-benchmarks --bench consolidate
```

## Analyzing Results

### Throughput Comparison

Example analysis for processing 100K elements:

```
Timely Dataflow:
- Map: 1.2ms (83K ops/sec)
- Filter: 1.5ms (66K ops/sec)

Differential Dataflow:
- Arrange: 5.0ms (20K ops/sec) - includes indexing
- Update: 0.5ms (200K ops/sec) - incremental
```

**Interpretation:**
- Initial computation: Timely is faster
- Subsequent updates: Differential excels

### Memory Comparison

Differential maintains indices, using more memory:

```bash
# Run with memory profiling
/usr/bin/time -v cargo bench --package timely-benchmarks
/usr/bin/time -v cargo bench --package differential-benchmarks
```

Look for "Maximum resident set size" in output.

## Benchmark Scenarios

### Scenario 1: One-Shot Computation

**Setup:**
- Load data once
- Compute result
- Discard state

**Results:**
```
Timely: Better performance (no indexing overhead)
Differential: Higher initial cost
```

### Scenario 2: Multiple Query Pattern

**Setup:**
- Load data
- Run query multiple times with small changes

**Results:**
```
Timely: Recomputes everything each time
Differential: Incremental updates are much faster
```

### Scenario 3: Streaming with Updates

**Setup:**
- Continuous data stream
- Updates to existing data
- Maintain running results

**Results:**
```
Timely: Must track state manually
Differential: Automatic state management, faster updates
```

## Example Comparison: Join Operations

### Timely Approach (Conceptual)

```rust
// Must manually manage join state
dataflow.join(
    |data1, data2| {
        // Manual state tracking
        // Must handle all data each time
    }
);
```

Performance: 
- First execution: Fast
- Updates: Must reprocess affected data manually

### Differential Approach

```rust
// Automatic state management
collection1.join(&collection2);
```

Performance:
- First execution: Slower (creates indices)
- Updates: Very fast (only affected tuples)

### Benchmark Data

For 10K elements with 100 unique keys:

| Framework | Initial | Update (10 elements) | Update (1000 elements) |
|-----------|---------|---------------------|------------------------|
| Timely | 2.5ms | 2.5ms | 2.5ms |
| Differential | 8.0ms | 0.1ms | 1.2ms |

**Breakeven Point:** ~4 updates

## Historical Performance Tracking

### Setting Up Baselines

```bash
# Save current performance
./run-benchmarks.sh --save-baseline v1.0.0

# After changes
./run-benchmarks.sh --baseline v1.0.0
```

### Tracking Over Time

Create a script to track performance across versions:

```bash
#!/bin/bash
# track-performance.sh

VERSIONS=("v1.0.0" "v1.1.0" "v1.2.0")

for version in "${VERSIONS[@]}"; do
    git checkout $version
    cargo bench --all -- --save-baseline $version
done

# Generate comparison report
for i in "${!VERSIONS[@]}"; do
    if [ $i -gt 0 ]; then
        prev=${VERSIONS[$((i-1))]}
        curr=${VERSIONS[$i]}
        echo "Comparing $prev to $curr:"
        cargo bench --all -- --baseline $prev --load-baseline $curr
    fi
done
```

### Regression Detection

```bash
# Run benchmarks and check for regressions
./run-benchmarks.sh --baseline main 2>&1 | tee results.txt

# Parse results
if grep -q "Performance has regressed" results.txt; then
    echo "❌ Performance regression detected!"
    grep "regressed" results.txt
    exit 1
else
    echo "✅ No performance regressions"
fi
```

## Visualization

### Using Criterion Reports

Open `target/criterion/report/index.html` to view:
- Line plots for parameter sweeps
- Violin plots showing distributions
- Comparison charts against baselines

### Custom Analysis

Export data for custom analysis:

```bash
# Extract timing data
find target/criterion -name "estimates.json" -exec cat {} \;

# Process with jq
find target/criterion -name "estimates.json" | \
    xargs -I {} jq '.mean.point_estimate' {}
```

## Multi-Worker Comparisons

### Scalability Testing

```bash
# Test with different worker counts
for workers in 1 2 4 8; do
    TIMELY_WORKER_THREADS=$workers ./run-benchmarks.sh \
        --save-baseline "workers-$workers"
done
```

### Parallel Efficiency

Calculate parallel efficiency:

```
Parallel Efficiency = (T1 / (Tn * n)) * 100%

Where:
- T1 = Time with 1 worker
- Tn = Time with n workers
- n = Number of workers
```

Example:
```
1 worker:  10.0ms
2 workers: 5.5ms   → Efficiency: 91%
4 workers: 3.0ms   → Efficiency: 83%
8 workers: 2.0ms   → Efficiency: 62%
```

## Advanced Comparisons

### Cache Effects

Test with varying data sizes to understand cache behavior:

```bash
# Small data (fits in L1 cache)
cargo bench -- 1000

# Medium data (fits in L3 cache)
cargo bench -- 100000

# Large data (exceeds cache)
cargo bench -- 10000000
```

### Network Effects (Multi-Node)

For distributed deployments:

```bash
# Set up multi-node configuration
TIMELY_WORKER_THREADS=4 \
TIMELY_PROCESS_COUNT=2 \
TIMELY_PROCESS_ID=0 \
    cargo bench
```

## Reporting Template

When comparing performance, include:

### 1. Environment
```
CPU: [model]
RAM: [amount]
OS: [version]
Rust: [version]
```

### 2. Configuration
```
Workers: [count]
Data size: [elements]
Key cardinality: [unique keys]
```

### 3. Results
```
| Operation | Timely | Differential | Winner |
|-----------|--------|--------------|--------|
| Join      | 2.5ms  | 8.0ms        | Timely |
| Update    | 2.5ms  | 0.1ms        | Diff   |
```

### 4. Analysis
- Which framework is better for this use case?
- What's the breakeven point?
- Memory trade-offs?
- Scalability characteristics?

## Common Pitfalls

### ❌ Comparing Different Operations
Don't compare timely's `map` to differential's `join` directly.

### ❌ Ignoring Warm-Up
First run may be slower due to JIT compilation.

### ❌ Not Considering Memory
Differential uses more memory for indices.

### ❌ Testing Only Initial Computation
Differential's strength is in incremental updates.

### ✅ Best Practices
- Compare equivalent operations
- Run multiple iterations
- Consider full workload (initial + updates)
- Account for memory usage
- Test at realistic scale

## Further Reading

- [Naiad Paper](https://dl.acm.org/doi/10.1145/2517349.2522738) - Timely dataflow foundations
- [Differential Dataflow Paper](https://github.com/TimelyDataflow/differential-dataflow/blob/master/differentialdataflow.pdf)
- [Performance Tuning Guide](BENCHMARKING.md)
