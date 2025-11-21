# Timely and Differential Dataflow Benchmarks

This directory contains comprehensive benchmarks for Timely Dataflow and Differential Dataflow frameworks.

## Benchmark Suite Overview

### 1. Timely Basic Operations (`timely_basic_ops`)

Tests fundamental Timely Dataflow operators:
- **Map**: Transform elements
- **Filter**: Select elements based on predicates
- **Exchange**: Data movement between workers
- **Concatenate**: Merge multiple streams
- **Chain Map**: Multiple sequential transformations

**Run:**
```bash
cargo bench -p timely-differential-benches --bench timely_basic_ops
```

**Example specific test:**
```bash
cargo bench -p timely-differential-benches --bench timely_basic_ops -- map
```

### 2. Timely Reachability (`timely_reachability`)

Graph reachability computation using iterative dataflow:
- **Chain graphs**: Linear sequences of nodes
- **Random graphs**: Randomly connected graphs

**Run:**
```bash
cargo bench -p timely-differential-benches --bench timely_reachability
```

### 3. Differential Basic Operations (`differential_basic_ops`)

Tests fundamental Differential Dataflow collection operators:
- **Map**: Transform collection elements
- **Filter**: Select collection elements
- **Join**: Relational join of collections
- **Count**: Count occurrences of each element
- **Reduce**: Custom aggregations
- **Incremental Update**: Test differential computation efficiency

**Run:**
```bash
cargo bench -p timely-differential-benches --bench differential_basic_ops
```

### 4. Differential Reachability (`differential_reachability`)

Incremental graph reachability computation:
- **Chain graphs**: Linear sequences
- **Random graphs**: Random connectivity
- **Incremental updates**: Adding edges dynamically

**Run:**
```bash
cargo bench -p timely-differential-benches --bench differential_reachability
```

### 5. Performance Comparison (`comparison`)

Direct side-by-side comparisons:
- **Map operations**: Timely vs Differential
- **Filter operations**: Timely vs Differential
- **Aggregation**: Different aggregation approaches
- **Reachability**: Graph algorithms
- **Incremental updates**: Differential's strength

**Run:**
```bash
cargo bench -p timely-differential-benches --bench comparison
```

## Running All Benchmarks

```bash
# From repository root
cargo bench -p timely-differential-benches

# From benches directory
cd benches
cargo bench
```

## Filtering Benchmarks

Use Criterion's built-in filtering:

```bash
# Run only benchmarks with "map" in the name
cargo bench -p timely-differential-benches -- map

# Run only benchmarks with size 10000
cargo bench -p timely-differential-benches -- 10000

# Run only timely benchmarks
cargo bench -p timely-differential-benches -- timely/

# Run only differential benchmarks
cargo bench -p timely-differential-benches -- differential/
```

## Benchmark Results

Results are stored in `target/criterion/` with:
- **HTML Reports**: Visual comparison with plots
- **CSV Data**: Raw measurements for custom analysis
- **Statistical Analysis**: Confidence intervals, outliers, etc.

### Viewing Results

Open the generated HTML reports:
```bash
# Open the main index
open target/criterion/report/index.html

# Or specific benchmark reports
open target/criterion/timely/map/10000/report/index.html
```

## Performance Comparison Features

The comparison benchmarks help identify:

1. **Throughput Differences**: Which framework processes data faster for each operation
2. **Scaling Characteristics**: How performance changes with data size
3. **Incremental Computation**: Where Differential Dataflow excels (small updates to large datasets)
4. **Memory Usage**: Implicit in execution time differences

### Key Insights

- **Timely Dataflow**: Better for pure streaming, lower overhead for simple operations
- **Differential Dataflow**: Superior for incremental computation, maintaining state, and complex queries

## Customizing Benchmarks

### Adding New Benchmarks

1. Create a new file in `benches/` (e.g., `my_benchmark.rs`)
2. Add benchmark entry in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Use the common utilities from `common/mod.rs`

### Modifying Test Sizes

Edit the size arrays in each benchmark file:
```rust
for size in [1_000, 10_000, 100_000].iter() {
    // benchmark code
}
```

### Changing Benchmark Duration

Add configuration at the benchmark group level:
```rust
let mut group = c.benchmark_group("my_group");
group.measurement_time(std::time::Duration::from_secs(10));
group.sample_size(100);
```

## Common Utilities

The `common/mod.rs` module provides:
- **Graph generation**: Random, chain, and complete graphs
- **Performance measurement**: Timer and result structures
- **Comparison tools**: Statistical comparison utilities

## Independent Execution

Each benchmark can be executed independently:

```bash
# Build first
cargo build --release -p timely-differential-benches

# Run individual benchmark binaries
cargo bench -p timely-differential-benches --bench timely_basic_ops --no-fail-fast
```

## Troubleshooting

### Long Running Benchmarks

Some benchmarks (especially reachability) may take time:
```bash
# Reduce sample size
export CRITERION_SAMPLE_SIZE=10
cargo bench -p timely-differential-benches
```

### Memory Issues

For large datasets, you may need to:
1. Reduce test sizes in benchmark files
2. Run benchmarks individually
3. Increase system memory limits

### Comparing with Baselines

Save a baseline:
```bash
cargo bench -p timely-differential-benches -- --save-baseline before
```

Compare against it:
```bash
cargo bench -p timely-differential-benches -- --baseline before
```

## CI/CD Integration

For automated performance tracking:

```bash
# Generate machine-readable output
cargo bench -p timely-differential-benches -- --output-format bencher

# Or use Criterion's JSON output
cargo bench -p timely-differential-benches -- --message-format json
```

## Additional Resources

- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
