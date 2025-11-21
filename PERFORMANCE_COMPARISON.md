# Performance Comparison Capabilities

## Overview

This repository provides comprehensive benchmarking capabilities for comparing Hydro (DFIR) performance with Timely Dataflow and Differential Dataflow implementations. The benchmarks are designed to measure and compare identical algorithms implemented in different frameworks.

## Comparison Methodology

### Framework Variants

Each benchmark typically includes multiple variants:

1. **Hydro/DFIR Variant**: Native Hydro implementation using `dfir_rs`
2. **Timely Variant**: Implementation using Timely Dataflow operators
3. **Differential Variant**: Implementation using Differential Dataflow (for applicable benchmarks)
4. **Baseline Variant**: Simple Rust implementation without dataflow frameworks (where applicable)

### Measurement Approach

All benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) which provides:

- **Statistical Rigor**: Multiple iterations with outlier detection
- **Confidence Intervals**: 95% confidence intervals for all measurements
- **Regression Detection**: Automatic detection of performance changes
- **HTML Reports**: Detailed visualizations and analysis

### Fair Comparison Principles

1. **Identical Algorithms**: Same algorithm logic across all variants
2. **Same Input Data**: All variants process identical test data
3. **Same Work**: Equivalent computation and data movement
4. **Isolated Timing**: Only core dataflow operations are timed
5. **Release Mode**: All measurements in optimized release builds

## Benchmark Categories and Comparisons

### 1. Simple Operations

#### Identity Benchmark (`identity.rs`)
**Purpose**: Measure baseline dataflow overhead

**Variants**:
- Hydro: `dfir_syntax!` with identity mapping
- Timely: `ToStream` + `map(|x| x)` + `Inspect`
- Pipeline: Raw Rust channels for baseline

**What It Measures**:
- Minimal dataflow overhead
- Operator scheduling efficiency
- Data handoff performance

**Key Metrics**:
- Throughput (elements/second)
- Latency per element
- Framework overhead vs. raw Rust

#### Arithmetic Benchmark (`arithmetic.rs`)
**Purpose**: Measure computation within dataflow

**Variants**:
- Pipeline: Chained Rust channels with arithmetic
- Hydro: DFIR with arithmetic operators
- Timely: Timely operators with arithmetic

**What It Measures**:
- Computational efficiency
- Operator fusion capabilities
- Pipeline parallelism

#### Upcase Benchmark (`upcase.rs`)
**Purpose**: String processing performance

**Variants**:
- Hydro: DFIR string transformations
- Timely: Timely map operators

**What It Measures**:
- String allocation overhead
- Map operator efficiency
- Memory usage patterns

### 2. Dataflow Patterns

#### Fan-In Benchmark (`fan_in.rs`)
**Purpose**: Multiple inputs merging to single output

**Variants**:
- Hydro: Multiple sources with union
- Timely: `Concatenate` operator

**What It Measures**:
- Multi-source coordination
- Union/concatenate performance
- Scheduling fairness

**Pattern**:
```
Source1 ─┐
Source2 ─┼─> Union ─> Sink
Source3 ─┘
```

#### Fan-Out Benchmark (`fan_out.rs`)
**Purpose**: Single input splitting to multiple outputs

**Variants**:
- Hydro: Tee operator
- Timely: Multiple map branches

**What It Measures**:
- Data distribution efficiency
- Cloning overhead
- Parallel consumption

**Pattern**:
```
          ┌─> Map1 ─> Sink1
Source ─>─┼─> Map2 ─> Sink2
          └─> Map3 ─> Sink3
```

#### Fork-Join Benchmark (`fork_join.rs`)
**Purpose**: Split, process, and rejoin pattern

**Variants**:
- Hydro: Filter + union operations
- Timely: Filter + concatenate

**What It Measures**:
- Split-merge performance
- Filter efficiency
- Rejoin coordination

**Pattern**:
```
       ┌─> Filter(even) ─┐
Source ┤                 ├─> Union ─> Sink
       └─> Filter(odd)  ─┘
```

#### Diamond Pattern (`words_diamond.rs`)
**Purpose**: Complex multi-path dataflow

**Variants**:
- Hydro: Diamond topology with word processing

**What It Measures**:
- Complex topology handling
- Multiple path coordination
- Text processing efficiency

**Pattern**:
```
         ┌─> Process1 ─┐
Source ─>┤             ├─> Merge ─> Sink
         └─> Process2 ─┘
```

### 3. Join Operations

#### Basic Join (`join.rs`)
**Purpose**: Two-stream join performance

**Variants**:
- Hydro: DFIR join operator
- Timely: Custom join implementation

**What It Measures**:
- Join algorithm efficiency
- State management overhead
- Match detection performance

**Use Case**: Correlating two data streams

#### Symmetric Hash Join (`symmetric_hash_join.rs`)
**Purpose**: Hash-based join implementation

**Variants**:
- Hydro: Hash join with state

**What It Measures**:
- Hash table operations
- Memory efficiency
- Symmetric join logic

**Use Case**: Equi-joins with large datasets

### 4. Advanced Algorithms

#### Graph Reachability (`reachability.rs`)
**Purpose**: Iterative graph computation

**Variants**:
- Hydro: DFIR iterative computation
- Differential: Native differential-dataflow with `Iterate`
- Direct: Hand-coded graph traversal

**What It Measures**:
- Iterative computation efficiency
- Fixed-point detection
- Incremental computation overhead

**Algorithm**: 
- Computes transitive closure of graph
- Iterates until no new reachable nodes found
- Uses differential dataflow's incremental computation

**Key Comparisons**:
```
reachability/hydro            - DFIR implementation
reachability/differential     - Differential Dataflow implementation  
reachability/direct          - Plain Rust for baseline
```

### 5. Modern Patterns

#### Futures Benchmark (`futures.rs`)
**Purpose**: Async/await integration

**Variants**:
- Hydro: Async operators with tokio

**What It Measures**:
- Async/await overhead
- Future scheduling efficiency
- Tokio runtime integration

**Use Case**: I/O-bound operations, external service calls

#### Micro Operations (`micro_ops.rs`)
**Purpose**: Fine-grained operation performance

**Variants**:
- Hydro: Individual operator microbenchmarks

**What It Measures**:
- Per-operator overhead
- Operator composition cost
- Minimal operation latency

## Performance Metrics

### Primary Metrics

1. **Throughput**: Elements processed per second
2. **Latency**: Time per element or batch
3. **Memory Usage**: Peak and average memory consumption
4. **CPU Utilization**: Processor efficiency

### Criterion Output

Each benchmark produces:

```
benchmark/variant       time:   [2.0000 µs 2.1000 µs 2.2000 µs]
                        thrpt:  [454.54 K elem/s 476.19 K elem/s 500.00 K elem/s]
                        change: [-5.0000% +0.0000% +5.0000%]
```

- **time**: Execution time with 95% confidence interval
- **thrpt**: Throughput (when applicable)
- **change**: Performance delta vs. previous run

### Comparison Interpretation

#### Performance Ratio Example

If Hydro shows `2.0 µs` and Timely shows `2.5 µs`:
- Hydro is 25% faster
- Timely has 25% more overhead
- Ratio: 1.25x improvement

#### Statistical Significance

Criterion marks significant changes:
- ✓ **Performance improvement** detected
- ✗ **Performance regression** detected
- ? **No significant change** (within noise)

## Using Comparison Results

### 1. Framework Selection

Use benchmarks to choose appropriate framework:

| Use Case | Recommendation | Supporting Benchmarks |
|----------|----------------|----------------------|
| Simple pipelines | Hydro or Timely | identity, arithmetic |
| Complex topologies | Hydro | fork_join, diamond |
| Iterative algorithms | Differential | reachability |
| Async operations | Hydro | futures |
| Large-scale joins | Differential | symmetric_hash_join |

### 2. Optimization Guidance

Identify optimization opportunities:

```bash
# Compare before and after optimization
cargo bench -- --save-baseline before
# ... make changes ...
cargo bench -- --baseline before
```

### 3. Regression Detection

Track performance over time:

```bash
# Run on each commit or release
cargo bench -- --save-baseline v1.0.0
cargo bench -- --save-baseline v1.1.0
cargo bench -- --baseline v1.0.0
```

### 4. Feature Trade-offs

Understand cost of additional features:

- Compare simple vs. complex variants
- Measure overhead of debugging features
- Quantify cost of additional operators

## Benchmark Data Sets

### Size Configurations

Most benchmarks use configurable sizes:

```rust
const NUM_INTS: usize = 1_000_000;      // 1M elements
const NUM_OPS: usize = 20;               // 20 operations
```

### Test Data

#### Small Data (< 1KB)
- Quick iteration testing
- Overhead measurement
- Fast feedback loop

#### Medium Data (1KB - 1MB)
- Representative workloads
- Balanced measurement
- Default benchmark size

#### Large Data (> 1MB)
- Scalability testing
- Memory pressure
- Real-world simulation

### Provided Data Files

1. **words_alpha.txt** (3.9 MB)
   - 370,000+ English words
   - Text processing benchmarks
   - String operation testing

2. **reachability_edges.txt** (533 KB)
   - 100,000+ graph edges
   - Graph algorithm testing
   - Iterative computation

3. **reachability_reachable.txt** (38 KB)
   - Expected reachability results
   - Validation data
   - Correctness checking

## Extending Comparisons

### Adding New Variants

To add a comparison variant:

1. Implement algorithm in new framework
2. Ensure identical input/output
3. Add as benchmark group:

```rust
fn benchmark_comparison(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_benchmark");
    
    group.bench_function("hydro", |b| {
        // Hydro implementation
    });
    
    group.bench_function("timely", |b| {
        // Timely implementation
    });
    
    group.finish();
}
```

### Adding New Metrics

Criterion supports custom measurements:

```rust
group.throughput(Throughput::Elements(NUM_ELEMENTS as u64));
group.throughput(Throughput::Bytes(DATA_SIZE as u64));
```

## Best Practices

### 1. Consistent Environment

- Same hardware for all runs
- Minimal background processes
- Consistent CPU frequency
- Same Rust compiler version

### 2. Multiple Runs

- Run benchmarks 3-5 times
- Check for consistency
- Average results for reporting
- Note variance

### 3. Warm-up Periods

- Criterion handles warm-up automatically
- Allow JIT optimization
- Ensure caches are populated
- Stabilize CPU frequency

### 4. Comparative Analysis

- Always compare multiple variants
- Use same input data
- Measure same operations
- Control external factors

## Interpreting Results

### Framework Strengths

Based on typical benchmark results:

**Hydro Advantages**:
- Flexible topology
- Good async integration
- Compile-time optimization

**Timely Advantages**:
- Mature implementation
- Well-optimized operators
- Proven scalability

**Differential Advantages**:
- Incremental computation
- Iterative algorithms
- Change propagation

### Performance Expectations

Typical relationships:

1. **Overhead Ranking** (lowest to highest):
   - Raw Rust channels
   - Timely Dataflow
   - Hydro/DFIR
   - Differential Dataflow

2. **Flexibility Ranking**:
   - Hydro/DFIR (most flexible)
   - Differential Dataflow
   - Timely Dataflow
   - Raw Rust (least flexible)

3. **Use Case Fit**:
   - Simple pipelines → All frameworks comparable
   - Complex topologies → Hydro advantage
   - Iterative algorithms → Differential advantage
   - Real-time streams → Timely/Differential advantage

## Reporting Results

### Format for Reports

```markdown
## Benchmark Results

**Environment**:
- Rust: 1.XX.0
- OS: Ubuntu 22.04
- CPU: Intel i7-9700K @ 3.6GHz
- RAM: 32GB

**Results**:

| Benchmark | Hydro | Timely | Ratio |
|-----------|-------|--------|-------|
| Identity  | 2.1µs | 2.5µs  | 1.19x |
| Arithmetic| 45µs  | 48µs   | 1.07x |
| Fan-in    | 12µs  | 13µs   | 1.08x |
```

### Visualization

Use Criterion's HTML reports:
- Time series plots
- Violin plots for distribution
- Comparison charts
- Historical trends

## Conclusion

These benchmarks provide comprehensive performance comparison capabilities across multiple dataflow frameworks. Use them to:

1. Guide framework selection
2. Identify optimization opportunities
3. Track performance regressions
4. Validate implementation correctness
5. Understand trade-offs

For questions or contributions, see the main README.md.
