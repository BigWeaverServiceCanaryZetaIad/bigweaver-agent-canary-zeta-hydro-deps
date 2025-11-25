# Benchmark Details

This document provides detailed information about each benchmark in the repository, including what they measure, how they work, and how to interpret results.

## Overview

The benchmarks compare three implementations:
1. **Raw**: Baseline using standard Rust constructs (channels, threads, vectors)
2. **DFIR/Hydro**: Hydro's dataflow intermediate representation
3. **Timely**: Timely-dataflow and differential-dataflow frameworks

## Benchmark Descriptions

### Arithmetic (`arithmetic.rs`)

**Purpose**: Measures performance of arithmetic operations in a pipeline

**Implementations**:
- `arithmetic/raw` - Vector operations with minimal overhead
- `arithmetic/pipeline` - Multi-threaded channel-based pipeline
- `arithmetic/dfir` - DFIR implementation
- `arithmetic/timely` - Timely dataflow implementation

**Test Pattern**: Applies 20 arithmetic operations (increment) to 1,000,000 integers

**What it measures**: 
- Overhead of dataflow frameworks vs raw operations
- Pipeline throughput
- Data movement efficiency

**Expected results**: Raw should be fastest, DFIR and Timely should show comparable performance with reasonable overhead

---

### Fan In (`fan_in.rs`)

**Purpose**: Tests performance of merging multiple input streams into one output

**Implementations**:
- `fan_in/dfir` - DFIR union operation
- `fan_in/timely` - Timely concatenate operation

**Test Pattern**: 4 input streams of 250,000 integers each, merged into one stream

**What it measures**:
- Stream merging efficiency
- Synchronization overhead
- Multi-producer performance

**Expected results**: Both implementations should have similar performance, dominated by synchronization costs

---

### Fan Out (`fan_out.rs`)

**Purpose**: Tests performance of splitting one input stream to multiple outputs

**Implementations**:
- `fan_out/dfir` - DFIR tee operation
- `fan_out/timely` - Timely broadcast operation

**Test Pattern**: 1 input stream of 1,000,000 integers, split to 4 output streams

**What it measures**:
- Stream splitting efficiency
- Data duplication costs
- Multi-consumer performance

**Expected results**: Performance depends on whether data is copied or shared; both should handle fanout efficiently

---

### Fork Join (`fork_join.rs`)

**Purpose**: Tests parallel processing patterns where data is split, processed independently, then rejoined

**Implementations**:
- `fork_join/dfir` - DFIR filter and union operations
- `fork_join/timely` - Timely filter and concatenate operations

**Test Pattern**: 20 levels of fork-join, splitting even/odd numbers and rejoining

**What it measures**:
- Parallel dataflow efficiency
- Filter operation performance
- Union/concatenate performance

**Expected results**: Should scale well with parallelism; overhead should be proportional to fork depth

---

### Identity (`identity.rs`)

**Purpose**: Minimal overhead baseline - just passes data through

**Implementations**:
- `identity/pipeline` - Channel-based pass-through
- `identity/raw` - Direct vector copy
- `identity/dfir_pull` - DFIR pull-based execution
- `identity/dfir_push` - DFIR push-based execution
- `identity/timely` - Timely pass-through

**Test Pattern**: Pass 1,000,000 integers through with no operations

**What it measures**:
- Minimum framework overhead
- Data movement costs
- Scheduling overhead

**Expected results**: Raw should be fastest, shows baseline overhead of each framework

---

### Join (`join.rs`)

**Purpose**: Tests join operations between two streams

**Implementations**:
- `join/dfir` - DFIR join operation
- `join/timely` - Timely join operation

**Test Pattern**: Join two streams of 100,000 elements each on matching keys

**What it measures**:
- Join algorithm efficiency
- Hash table performance
- Memory usage patterns

**Expected results**: Performance depends on data distribution; both should use similar hash-based algorithms

---

### Reachability (`reachability.rs`)

**Purpose**: Complex graph algorithm - finds reachable nodes in a directed graph

**Implementations**:
- `reachability/dfir` - DFIR iterative dataflow
- `reachability/differential` - Differential dataflow with incremental updates

**Test Pattern**: Graph with thousands of edges, computing transitive closure

**What it measures**:
- Iterative dataflow performance
- Fixed-point computation
- Complex graph algorithm efficiency

**Expected results**: Differential should excel at incremental updates; DFIR should compete for full computation

**Data files**:
- `reachability_edges.txt` - Input graph edges
- `reachability_reachable.txt` - Expected reachable nodes

---

### Symmetric Hash Join (`symmetric_hash_join.rs`)

**Purpose**: Tests symmetric hash join implementation

**Implementations**:
- `symmetric_hash_join/dfir` - DFIR symmetric hash join
- `symmetric_hash_join/timely` - Timely symmetric hash join

**Test Pattern**: Join two streams where both are built and probed simultaneously

**What it measures**:
- Bidirectional join performance
- Memory efficiency
- Join state management

**Expected results**: Similar performance between implementations; sensitive to data distribution

---

### Upcase (`upcase.rs`)

**Purpose**: String transformation operations

**Implementations**:
- `upcase/dfir` - DFIR string transformation
- `upcase/timely` - Timely string transformation

**Test Pattern**: Convert strings to uppercase from word list

**What it measures**:
- String operation overhead
- Map operation performance
- String allocation patterns

**Expected results**: Similar performance, dominated by actual string operations

**Data files**:
- `words_alpha.txt` - List of English words (~370,000 words)

---

### Words Diamond (`words_diamond.rs`)

**Purpose**: Diamond-shaped dataflow with word processing

**Implementations**:
- `words_diamond/dfir` - DFIR diamond pattern
- `words_diamond/timely` - Timely diamond pattern

**Test Pattern**: 
1. Load words
2. Split to two branches (filter by length)
3. Transform in each branch
4. Merge results

**What it measures**:
- Complex dataflow patterns
- Branch and merge efficiency
- Real-world text processing

**Expected results**: Good test of overall framework efficiency with realistic workload

---

### Micro Ops (`micro_ops.rs`)

**Purpose**: Collection of micro-benchmarks for individual operations

**Implementations**: Various basic operations in both DFIR and Timely

**Operations tested**:
- Map (transformation)
- Filter (conditional filtering)
- FlatMap (one-to-many transformation)
- Fold (aggregation)
- And more...

**What it measures**: Individual operation overhead and efficiency

**Expected results**: Varies by operation; useful for identifying performance characteristics

---

### Futures (`futures.rs`)

**Purpose**: Tests async/futures-based dataflow operations

**Implementations**:
- `futures/dfir` - DFIR with async operations
- `futures/timely` - Timely with async operations

**Test Pattern**: Async processing of data streams

**What it measures**:
- Async operation overhead
- Future scheduling efficiency
- Integration with async ecosystem

**Expected results**: Shows overhead of async abstraction; important for I/O-bound workloads

---

## Interpreting Results

### Understanding Output

Criterion provides detailed output:

```
benchmark_name          time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.5% -1.2% +0.5%] (p = 0.15 > 0.05)
```

- **Lower bound**: 45.123 ms (fastest observed)
- **Estimate**: 45.456 ms (statistical mean)
- **Upper bound**: 45.789 ms (slowest observed)
- **Change**: Comparison with previous run (if available)
- **p-value**: Statistical significance of change

### Performance Comparison

When comparing implementations:

1. **Overhead**: How much slower than raw implementation?
2. **Relative Performance**: How do DFIR and Timely compare?
3. **Scalability**: How does performance change with data size?
4. **Consistency**: Are results stable across runs?

### Red Flags

Watch for:
- **High variance**: Indicates unstable performance or system interference
- **Outliers**: May indicate GC pauses, page faults, or thermal throttling
- **Unexpected regressions**: Significant slowdowns compared to previous runs
- **Extreme overhead**: More than 10x slower than raw implementation

## Data Files

### reachability_edges.txt
Format: Space-separated node pairs representing directed edges
```
node1 node2
node3 node4
...
```

### reachability_reachable.txt
Format: Nodes that should be reachable in the test graph

### words_alpha.txt
Format: One word per line, ~370,000 English words
Source: https://github.com/dwyl/english-words

## Configuration

Benchmark configuration is set in each benchmark file:

```rust
const NUM_OPS: usize = 20;        // Number of operations
const NUM_INTS: usize = 1_000_000; // Data size
```

You can modify these to test different scenarios, but be aware:
- Larger values = longer benchmark times
- Smaller values = less accurate results
- Some benchmarks may behave differently at different scales

## Adding Custom Benchmarks

To add a new benchmark:

1. Create file in `benches/benches/your_benchmark.rs`
2. Use Criterion framework:
```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn benchmark_something(c: &mut Criterion) {
    c.bench_function("benchmark_name", |b| {
        b.iter(|| {
            // Your benchmark code
        });
    });
}

criterion_group!(benches, benchmark_something);
criterion_main!(benches);
```

3. Add entry to `benches/Cargo.toml`:
```toml
[[bench]]
name = "your_benchmark"
harness = false
```

4. Run: `cargo bench -p benches --bench your_benchmark`

## Best Practices

1. **Warm-up**: Criterion automatically handles warm-up iterations
2. **Multiple Runs**: Run benchmarks multiple times to verify consistency
3. **System State**: Close other applications, ensure consistent power/cooling
4. **Baselines**: Save baselines before making changes: `--save-baseline name`
5. **Comparison**: Compare against baseline: `--baseline name`
6. **Documentation**: Document what each benchmark measures and why

## Troubleshooting

### Benchmark Fails to Build

Check that dependencies are available:
```bash
cargo update
cargo check -p benches
```

### Benchmark Crashes

Some benchmarks use large datasets. Ensure sufficient memory:
```bash
# Check memory usage
cargo bench -p benches --bench identity  # Smallest benchmark
```

### Inconsistent Results

Reduce system interference:
- Close background applications
- Disable CPU frequency scaling
- Run on AC power (not battery)
- Check for thermal throttling

### Benchmark Takes Too Long

Use quick mode for faster (less accurate) results:
```bash
cargo bench -p benches -- --quick
```

Or reduce sample size in code:
```rust
c.bench_function("name", |b| {
    b.iter(|| { /* ... */ });
}).sample_size(10);  // Reduce from default 100
```

## Further Reading

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://hydro.run/docs/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
