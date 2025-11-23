# Benchmark Suite Documentation

This document provides detailed information about the benchmarks in this repository, their purpose, methodology, and how to interpret results.

## Overview

The benchmarks in this repository compare the performance of Hydro/Hydroflow with the timely and differential-dataflow frameworks. They cover common dataflow patterns and operations to provide comprehensive performance insights.

## Benchmark Categories

### Data Transformation Benchmarks

#### 1. Arithmetic (`arithmetic.rs`)

**Purpose**: Measures the performance of basic arithmetic operations in a pipeline.

**Implementations**:
- **Pipeline**: Simple channel-based pipeline with arithmetic operations
- **Raw**: Baseline implementation with minimal overhead
- **Hydroflow**: Hydro implementation of arithmetic pipeline
- **Timely**: Timely dataflow implementation

**Configuration**:
- Number of operations: 20
- Number of integers: 1,000,000

**What it measures**: Throughput and latency of simple arithmetic transformations in a streaming context.

**Command**:
```bash
cargo bench --bench arithmetic
```

#### 2. Identity (`identity.rs`)

**Purpose**: Tests the overhead of passing data through the framework without transformation.

**Implementations**:
- **Pipeline**: Channel-based identity passthrough
- **Raw**: Direct data copying baseline
- **Hydroflow**: Hydro identity operation
- **Timely**: Timely identity operation

**Configuration**:
- Number of operations: 20
- Number of integers: 1,000,000

**What it measures**: Framework overhead with minimal computation.

**Command**:
```bash
cargo bench --bench identity
```

#### 3. Upcase (`upcase.rs`)

**Purpose**: Measures string transformation performance.

**Implementations**:
- **Hydroflow**: String uppercase transformation
- **Timely**: Timely string transformation

**Configuration**:
- Number of operations: 20
- Number of strings: 100,000

**What it measures**: String processing throughput and memory allocation patterns.

**Command**:
```bash
cargo bench --bench upcase
```

### Dataflow Pattern Benchmarks

#### 4. Fan-In (`fan_in.rs`)

**Purpose**: Tests the performance of merging multiple data streams.

**Pattern**:
```
Stream 1 ──┐
Stream 2 ──┤
   ...     ├──> Union ──> Output
Stream N ──┘
```

**Implementations**:
- **Hydroflow**: Multi-input union operation
- **Timely**: Timely dataflow concatenation

**Configuration**:
- Number of input streams: 20
- Elements per stream: 50,000

**What it measures**: Multi-source data aggregation performance and synchronization overhead.

**Command**:
```bash
cargo bench --bench fan_in
```

#### 5. Fan-Out (`fan_out.rs`)

**Purpose**: Tests the performance of distributing data to multiple downstream consumers.

**Pattern**:
```
           ┌──> Output 1
           ├──> Output 2
Input ──>  │       ...
           └──> Output N
```

**Implementations**:
- **Hydroflow**: Tee operation for broadcast
- **Timely**: Timely dataflow broadcast

**Configuration**:
- Number of output streams: 20
- Number of integers: 1,000,000

**What it measures**: Data distribution efficiency and memory management.

**Command**:
```bash
cargo bench --bench fan_out
```

#### 6. Fork-Join (`fork_join.rs`)

**Purpose**: Measures the performance of split-and-merge patterns.

**Pattern**:
```
           ┌──> Filter(even) ──┐
Input ──>  │                   ├──> Union ──> Output
           └──> Filter(odd) ───┘
```

**Implementations**:
- **Hydroflow**: Using tee, filter, and union operators
- **Timely**: Timely dataflow fork-join

**Configuration**:
- Number of fork-join stages: 20
- Number of integers: 1,000,000

**What it measures**: Complex dataflow patterns with branching and merging.

**Command**:
```bash
cargo bench --bench fork_join
```

### Relational Operation Benchmarks

#### 7. Join (`join.rs`)

**Purpose**: Tests join operation performance.

**Operation**: Combines two streams based on a key.

**Implementations**:
- **Hydroflow**: Native join operation
- **Timely**: Timely dataflow join

**Configuration**:
- Left stream size: Variable
- Right stream size: Variable
- Join cardinality: Configurable

**What it measures**: Join throughput, memory usage during join processing.

**Command**:
```bash
cargo bench --bench join
```

### Graph Algorithm Benchmarks

#### 8. Reachability (`reachability.rs`)

**Purpose**: Measures graph reachability computation performance using iterative dataflow.

**Algorithm**: Computes all nodes reachable from a set of root nodes in a directed graph.

**Implementations**:
- **Hydroflow**: Hydro implementation of reachability
- **Differential Dataflow**: Using iterate and join operations

**Test Data**:
- `reachability_edges.txt`: Graph edges (55,008 edges)
- `reachability_reachable.txt`: Expected reachable nodes (7,855 nodes)

**What it measures**: Iterative computation performance, convergence speed, and incremental update efficiency.

**Command**:
```bash
cargo bench --bench reachability
```

## Running Benchmarks

### Full Benchmark Suite

Run all benchmarks with full statistical sampling:

```bash
cargo bench
```

This will:
- Run each benchmark multiple times
- Perform statistical analysis
- Generate HTML reports in `target/criterion/`
- Compare with previous runs (if available)

### Quick Benchmarks

For faster iteration during development:

```bash
# Reduced sampling
cargo bench -- --quick

# Or set environment variable
CRITERION_QUICK=1 cargo bench

# Single benchmark with quick mode
cargo bench --bench arithmetic -- --quick
```

### Specific Benchmarks

Run individual benchmarks:

```bash
# Single benchmark
cargo bench --bench arithmetic

# Multiple specific benchmarks
cargo bench --bench arithmetic --bench join --bench reachability
```

### Filtering Benchmark Cases

Run specific test cases within a benchmark:

```bash
# Run only hydroflow variants
cargo bench --bench arithmetic -- hydroflow

# Run only timely variants
cargo bench --bench arithmetic -- timely

# Run specific test by name
cargo bench --bench arithmetic -- "arithmetic/pipeline"
```

## Interpreting Results

### Understanding Criterion Output

Criterion provides detailed statistical analysis:

```
arithmetic/hydroflow  time:   [45.234 ms 45.678 ms 46.123 ms]
                      change: [-2.1234% -1.5678% -0.9876%] (p = 0.00 < 0.05)
                      Performance has improved.
```

**Key metrics**:
- **time**: Lower bound, estimate, upper bound (95% confidence interval)
- **change**: Percentage change from previous run
- **p-value**: Statistical significance (< 0.05 indicates significant change)

### HTML Reports

Open `target/criterion/report/index.html` in a browser for:
- Interactive charts
- Violin plots showing distribution
- Iteration time comparisons
- Historical trends

### Comparing Implementations

To compare different implementations:

1. Run full benchmark suite: `cargo bench`
2. Check HTML report for side-by-side comparisons
3. Look for:
   - Relative performance differences
   - Consistency across runs (narrower confidence intervals are better)
   - Scaling characteristics with different input sizes

## Performance Expectations

### General Guidelines

- **Identity/Arithmetic**: Should have minimal overhead, close to raw performance
- **Fan-in/Fan-out**: Overhead proportional to number of branches
- **Fork-join**: Higher overhead due to synchronization
- **Join**: Performance depends on join cardinality and data distribution
- **Reachability**: Convergence speed is key metric

### Framework Characteristics

**Hydroflow**:
- Generally lower latency for simple pipelines
- Efficient memory usage
- Good for acyclic dataflows

**Timely**:
- Excellent for complex dataflows
- Strong timestamp coordination
- Efficient for cyclic dataflows

**Differential Dataflow**:
- Optimized for incremental updates
- Best for iterative algorithms
- Efficient change propagation

## Best Practices

### Running Benchmarks

1. **Consistent Environment**:
   - Close unnecessary applications
   - Disable CPU frequency scaling if possible
   - Run on same hardware for comparisons

2. **Multiple Runs**:
   - Run benchmarks multiple times
   - Look for consistency across runs
   - Investigate outliers

3. **Baseline Establishment**:
   - Establish baseline before making changes
   - Save baseline results
   - Compare against saved baselines

### Adding New Benchmarks

When adding new benchmarks:

1. Follow existing naming conventions
2. Include multiple implementations for comparison
3. Document purpose, configuration, and expectations
4. Add appropriate test data if needed
5. Update this documentation

### Troubleshooting Poor Performance

If benchmarks show unexpected results:

1. **Check System Load**: Ensure no background processes interfering
2. **Verify Data Sizes**: Confirm configuration matches expectations
3. **Profile the Code**: Use profiling tools to identify bottlenecks
4. **Compare Baselines**: Check against historical data
5. **Review Implementation**: Verify correct algorithm implementation

## Configuration

### Adjusting Benchmark Parameters

Most benchmarks have configurable parameters:

```rust
const NUM_OPS: usize = 20;        // Number of operations
const NUM_INTS: usize = 1_000_000; // Data size
```

Modify these constants to test different scenarios.

### Criterion Configuration

Criterion configuration can be adjusted in each benchmark file:

```rust
criterion_group! {
    name = benches;
    config = Criterion::default()
        .sample_size(100)           // Number of samples
        .measurement_time(Duration::from_secs(10))  // Time per benchmark
        .warm_up_time(Duration::from_secs(3));      // Warm-up time
    targets = benchmark_arithmetic, ...
}
```

## Test Data

### Reachability Data

The reachability benchmark uses real graph data:

- **Source**: Generated from real-world graphs
- **Size**: 55,008 edges, 7,855 reachable nodes
- **Format**: Text files with node pairs

To regenerate or use different data:

1. Create edge list in `reachability_edges.txt` (format: `node1 node2` per line)
2. Compute expected reachable nodes
3. Save results in `reachability_reachable.txt` (format: one node per line)

## Performance Comparison Methodology

### Fair Comparisons

To ensure fair comparisons between frameworks:

1. **Equivalent Algorithms**: Use same algorithm across implementations
2. **Similar Data Structures**: Use comparable data types
3. **Same Input Data**: Use identical test data
4. **Consistent Configuration**: Match parameters across implementations
5. **Warm-up Phases**: Allow JIT compilation to stabilize

### Metrics to Compare

- **Throughput**: Elements processed per second
- **Latency**: Time per element or per operation
- **Memory Usage**: Peak memory consumption
- **Scalability**: Performance with increasing data sizes
- **Consistency**: Variance across runs

## Additional Resources

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow Documentation](https://hydro-project.github.io/hydro/)

## Contributing

To contribute new benchmarks or improvements:

1. Ensure benchmarks are fair and well-documented
2. Include multiple implementations where appropriate
3. Add configuration options for different scenarios
4. Update this documentation
5. Provide baseline results

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.
