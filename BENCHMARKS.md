# Benchmarks Documentation

## Overview

This document provides detailed information about the benchmark suite in the bigweaver-agent-canary-zeta-hydro-deps repository. These benchmarks are designed to compare dfir_rs performance with timely and differential-dataflow implementations.

## Table of Contents

1. [Benchmark Suite Overview](#benchmark-suite-overview)
2. [Detailed Benchmark Descriptions](#detailed-benchmark-descriptions)
3. [Running Benchmarks](#running-benchmarks)
4. [Performance Comparison Methodology](#performance-comparison-methodology)
5. [Test Data](#test-data)
6. [Interpreting Results](#interpreting-results)
7. [Best Practices](#best-practices)

## Benchmark Suite Overview

The repository contains 8 benchmark suites that test various dataflow patterns and operations:

| Benchmark | File | Dependencies | Data Files | Purpose |
|-----------|------|--------------|------------|---------|
| Arithmetic | `arithmetic.rs` | timely | None | Compare arithmetic operation implementations |
| Fan-In | `fan_in.rs` | timely | None | Test fan-in dataflow patterns |
| Fan-Out | `fan_out.rs` | timely | None | Test fan-out dataflow patterns |
| Fork-Join | `fork_join.rs` | timely | None | Test fork-join concurrency patterns |
| Identity | `identity.rs` | timely | None | Test identity transformation performance |
| Join | `join.rs` | timely | None | Test join operations |
| Reachability | `reachability.rs` | timely, differential | edges.txt, reachable.txt | Test graph algorithms |
| Upcase | `upcase.rs` | timely | words_alpha.txt | Test string transformations |

## Detailed Benchmark Descriptions

### 1. Arithmetic Benchmarks (`arithmetic.rs`)

**Purpose**: Compare different approaches to performing arithmetic operations in a streaming/dataflow context.

**Implementations Tested**:
- **Pipeline**: Traditional multi-threaded pipeline using channels
- **Raw Copy**: Direct memory copying approach
- **Iterator**: Rust iterator-based processing
- **Timely**: Timely dataflow implementation

**Operations**: 
- 20 consecutive arithmetic operations
- Processing 1,000,000 integers per test

**Key Metrics**:
- Throughput (operations/second)
- Latency per operation
- Memory allocation patterns

**Use Cases**:
- Understanding overhead of different dataflow approaches
- Comparing streaming vs. batch processing
- Evaluating runtime abstraction costs

**Example Run**:
```bash
cargo bench --bench arithmetic
```

**Expected Output**:
```
arithmetic/pipeline        time: [45.2 ms 45.8 ms 46.4 ms]
arithmetic/raw_copy        time: [12.3 ms 12.5 ms 12.7 ms]
arithmetic/iterator        time: [8.1 ms 8.3 ms 8.5 ms]
arithmetic/timely          time: [52.7 ms 53.2 ms 53.7 ms]
```

### 2. Fan-In Benchmarks (`fan_in.rs`)

**Purpose**: Test performance of fan-in patterns where multiple data streams merge into one.

**Timely Operators Used**:
- `ToStream` - Convert data to streams
- `Concat` - Merge multiple streams
- `Inspect` - Observe stream elements

**Patterns Tested**:
- 2-way fan-in
- 4-way fan-in
- 8-way fan-in
- 16-way fan-in

**Key Metrics**:
- Throughput as number of inputs increases
- Synchronization overhead
- Memory pressure during merging

**Use Cases**:
- Multi-source data aggregation
- Parallel processing result collection
- Event stream merging

**Example Run**:
```bash
cargo bench --bench fan_in
```

### 3. Fan-Out Benchmarks (`fan_out.rs`)

**Purpose**: Test performance of fan-out patterns where one data stream splits into multiple.

**Timely Operators Used**:
- `ToStream` - Create data streams
- `Broadcast` - Duplicate streams
- `Inspect` - Verify stream elements

**Patterns Tested**:
- 2-way fan-out
- 4-way fan-out
- 8-way fan-out
- 16-way fan-out

**Key Metrics**:
- Throughput as number of outputs increases
- Data duplication overhead
- Memory amplification

**Use Cases**:
- Broadcasting events to multiple consumers
- Parallel pipeline branches
- Multi-stage processing

**Example Run**:
```bash
cargo bench --bench fan_out
```

### 4. Fork-Join Benchmarks (`fork_join.rs`)

**Purpose**: Test fork-join concurrency patterns using timely dataflow.

**Pattern Description**:
1. Fork: Split input stream into parallel branches
2. Process: Each branch performs independent computation
3. Join: Merge results back together

**Timely Operators Used**:
- `ToStream` - Create input streams
- `Map` - Transform elements
- `Concat` - Join results
- `Inspect` - Verify correctness

**Variants Tested**:
- Balanced workload
- Unbalanced workload
- Variable branch count

**Key Metrics**:
- End-to-end latency
- Resource utilization
- Load balancing effectiveness

**Use Cases**:
- Parallel algorithm implementations
- Map-reduce style processing
- Independent computation aggregation

**Example Run**:
```bash
cargo bench --bench fork_join
```

### 5. Identity Benchmarks (`identity.rs`)

**Purpose**: Measure baseline overhead of dataflow operations by testing identity transformations (input = output).

**Timely Operators Used**:
- `ToStream` - Create streams
- `Map(|x| x)` - Identity transformation
- `Inspect` - Consume results

**What It Measures**:
- Minimum overhead of the dataflow runtime
- Stream processing baseline cost
- Framework abstraction overhead

**Importance**:
- Baseline for other benchmarks
- Understanding framework overhead
- Identifying optimization opportunities

**Key Metrics**:
- Minimum achievable latency
- Throughput ceiling
- Memory allocation per element

**Example Run**:
```bash
cargo bench --bench identity
```

### 6. Join Benchmarks (`join.rs`)

**Purpose**: Test join operation performance across different implementations.

**Join Types Tested**:
- Inner join
- Symmetric hash join
- Timely dataflow join

**Test Scenarios**:
- Small datasets (100-1000 elements)
- Medium datasets (10k-100k elements)
- Large datasets (1M+ elements)
- Skewed distributions
- Even distributions

**Timely Operators Used**:
- `ToStream` - Create input streams
- `Join` - Perform join operations
- `Inspect` - Verify results

**Key Metrics**:
- Join throughput
- Memory usage during join
- Performance with different data distributions

**Use Cases**:
- Database-style query operations
- Stream correlation
- Data enrichment

**Example Run**:
```bash
cargo bench --bench join
```

### 7. Reachability Benchmarks (`reachability.rs`)

**Purpose**: Test graph reachability algorithms using differential dataflow for incremental computation.

**Algorithm**: Compute all nodes reachable from a starting node in a directed graph.

**Data Files**:
- `reachability_edges.txt` (524KB) - Graph edge list
- `reachability_reachable.txt` (40KB) - Expected reachable nodes

**Implementations Compared**:
- dfir_rs iterative approach
- Differential dataflow incremental approach
- Batch computation baseline

**Differential Dataflow Features**:
- Incremental updates
- Change propagation
- Efficient recomputation

**Key Metrics**:
- Initial computation time
- Incremental update time
- Memory usage
- Accuracy verification

**Use Cases**:
- Social network analysis
- Dependency resolution
- Network topology analysis

**Example Run**:
```bash
cargo bench --bench reachability
```

**Understanding Results**:
- **Batch time**: Full recomputation from scratch
- **Incremental time**: Adding/removing edges
- **Memory overhead**: Differential dataflow state

### 8. Upcase Benchmarks (`upcase.rs`)

**Purpose**: Test string transformation performance in streaming context.

**Operation**: Convert strings to uppercase

**Data File**: `words_alpha.txt` (3.7MB) - English word list

**Implementations Tested**:
- Direct string processing
- Iterator-based transformation
- Timely dataflow streaming

**Timely Operators Used**:
- `ToStream` - Stream words from file
- `Map` - Transform to uppercase
- `Inspect` - Verify results

**Key Metrics**:
- Throughput (words/second)
- Memory efficiency
- I/O overhead

**Use Cases**:
- Text processing pipelines
- String transformation workloads
- I/O-bound streaming operations

**Example Run**:
```bash
cargo bench --bench upcase
```

## Running Benchmarks

### Basic Commands

```bash
# Run all benchmarks
cd benches
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Run with filters
cargo bench --bench arithmetic -- pipeline

# Run quickly (fewer samples)
cargo bench --bench identity -- --quick
```

### Advanced Options

```bash
# Save baseline for comparison
cargo bench --bench arithmetic -- --save-baseline before

# Compare with baseline
cargo bench --bench arithmetic -- --baseline before

# Generate detailed output
cargo bench --bench arithmetic -- --verbose

# Warm up before measuring
cargo bench --bench arithmetic -- --warm-up-time 3
```

### Environment Configuration

```bash
# Set CPU affinity for consistency
taskset -c 0-3 cargo bench

# Disable CPU frequency scaling
sudo cpupower frequency-set --governor performance

# Increase sample size
CRITERION_SAMPLE_SIZE=200 cargo bench
```

## Performance Comparison Methodology

### Comparing with dfir_rs

1. **Run dfir_rs benchmarks** (from main repository):
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta/benches
   cargo bench -- --save-baseline dfir_rs
   ```

2. **Run comparison benchmarks** (from this repository):
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench -- --save-baseline external
   ```

3. **Analyze results**:
   - Compare similar operations (e.g., join implementations)
   - Note memory usage differences
   - Consider scalability characteristics

### Fair Comparison Guidelines

1. **Use same hardware** - Run on same machine
2. **Consistent environment** - Close other applications
3. **Warm-up runs** - Let JIT and caches stabilize
4. **Multiple runs** - Average across several executions
5. **Similar data sizes** - Use comparable input sizes
6. **Document conditions** - Note CPU, memory, load

### Metrics to Compare

| Metric | Description | Importance |
|--------|-------------|------------|
| Throughput | Items processed per second | High |
| Latency | Time per operation | High |
| Memory | Heap allocations | Medium |
| Scalability | Performance vs. data size | High |
| CPU Usage | Resource efficiency | Medium |
| Consistency | Result variance | Medium |

## Test Data

### Reachability Graph Data

**File**: `reachability_edges.txt`
- **Size**: 524KB
- **Format**: Space-separated edge pairs
- **Structure**: `source_node destination_node`
- **Nodes**: Integer IDs
- **Edges**: Directed graph edges

**Example**:
```
1 2
1 3
2 4
3 4
```

**File**: `reachability_reachable.txt`
- **Size**: 40KB
- **Format**: One node per line
- **Purpose**: Expected reachability results for verification

### Word List Data

**File**: `words_alpha.txt`
- **Size**: 3.7MB
- **Format**: One word per line
- **Content**: English alphabetic words
- **Count**: ~370,000 words
- **Purpose**: Text processing benchmark input

## Interpreting Results

### Criterion Output

Criterion generates several types of output:

1. **Console Output**:
   ```
   benchmark_name         time: [lower_bound estimate upper_bound]
                          change: [lower_change estimate upper_change]
   ```

2. **HTML Reports**: `target/criterion/report/index.html`
   - Detailed charts
   - Statistical analysis
   - Historical comparisons

3. **Data Files**: `target/criterion/<benchmark>/`
   - Raw measurements
   - Statistical summaries
   - Comparison data

### Understanding Statistics

- **Estimate**: Best estimate of true performance
- **Confidence Interval**: Range of likely true values (95% confidence)
- **R² value**: How well the model fits data (closer to 1.0 is better)
- **Standard Deviation**: Measurement consistency
- **Outliers**: Anomalous measurements (identified and filtered)

### Performance Indicators

**Good Performance**:
- ✅ Narrow confidence intervals
- ✅ High R² values (> 0.95)
- ✅ Few outliers
- ✅ Consistent across runs

**Poor Performance or Issues**:
- ❌ Wide confidence intervals
- ❌ Low R² values (< 0.80)
- ❌ Many outliers
- ❌ High variance across runs

### Comparing Results

When comparing implementations:

1. **Focus on relative performance**: "2x faster" more meaningful than absolute times
2. **Consider context**: Some operations naturally cost more
3. **Check scalability**: How does performance change with data size?
4. **Verify correctness**: Fast but wrong is useless

## Best Practices

### Running Benchmarks

1. **Consistent Environment**:
   - Close unnecessary applications
   - Disable background processes
   - Use same hardware configuration

2. **Sufficient Samples**:
   - Let Criterion determine sample size
   - Or set explicitly: `--sample-size 100`

3. **Baseline Comparisons**:
   - Save baselines before changes
   - Compare against baselines after changes

4. **Document Setup**:
   - Record hardware specifications
   - Note software versions
   - Document any configuration changes

### Writing New Benchmarks

1. **Use Criterion Properly**:
   ```rust
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // Code to benchmark
               black_box(expensive_operation())
           });
       });
   }
   ```

2. **Avoid Common Pitfalls**:
   - Use `black_box()` to prevent optimization
   - Don't include setup in measured code
   - Ensure sufficient work per iteration

3. **Benchmark Multiple Scenarios**:
   - Different data sizes
   - Different distributions
   - Edge cases

4. **Verify Correctness**:
   - Include assertions
   - Compare with known results
   - Test edge cases

### Analyzing Results

1. **Look for Patterns**:
   - How does performance scale?
   - Where are the bottlenecks?
   - What's the overhead?

2. **Compare Fairly**:
   - Same input sizes
   - Same operations
   - Same verification

3. **Document Findings**:
   - Record observations
   - Note unexpected results
   - Explain differences

4. **Iterate**:
   - Optimize based on findings
   - Re-run benchmarks
   - Verify improvements

## Troubleshooting

### Build Issues

**Problem**: Can't find dfir_rs or sinktools
**Solution**: Ensure main repository is cloned at correct relative path

**Problem**: Timely/differential version conflicts
**Solution**: Check versions match in Cargo.toml

### Runtime Issues

**Problem**: Benchmarks crash or hang
**Solution**: Check test data files are present and not corrupted

**Problem**: Inconsistent results
**Solution**: Close background apps, check system load

### Performance Issues

**Problem**: Benchmarks run very slowly
**Solution**: Ensure release mode is used (cargo bench uses it by default)

**Problem**: High variance in results
**Solution**: Increase sample size or warm-up time

## Additional Resources

- **Criterion Documentation**: https://bheisler.github.io/criterion.rs/book/
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Performance Tips**: See main repository documentation

## Contributing

When adding benchmarks:
1. Follow existing patterns
2. Include documentation
3. Provide meaningful test data
4. Verify correctness
5. Document methodology

## Version History

- **v0.1.0** - Initial benchmark suite
  - 8 benchmark categories
  - Full test data included
  - Documentation complete
