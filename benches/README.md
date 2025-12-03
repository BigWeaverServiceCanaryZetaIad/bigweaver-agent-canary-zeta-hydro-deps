# Hydro Benchmarks

This package contains performance benchmarks for comparing Hydro with timely and differential-dataflow implementations. These benchmarks enable performance regression testing and optimization validation.

## 📋 Overview

The benchmark suite includes:

- **Micro-operations**: Basic dataflow operations (map, filter, aggregations)
- **Graph algorithms**: Reachability and iterative computations
- **Dataflow patterns**: Common distributed patterns (joins, reductions, map-reduce)

## 🎯 Purpose

These benchmarks serve multiple purposes:

1. **Performance Comparison**: Compare Hydro implementations against timely/differential-dataflow baselines
2. **Regression Testing**: Detect performance regressions in new releases
3. **Optimization Validation**: Verify that optimizations improve performance
4. **Capacity Planning**: Understand throughput and latency characteristics

## 🔧 Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark Suite

```bash
# Run micro-operations benchmarks
cargo bench --bench micro_ops

# Run reachability benchmarks  
cargo bench --bench reachability

# Run dataflow pattern benchmarks
cargo bench --bench dataflow_patterns
```

### Run Specific Benchmark

```bash
# Run only map operations
cargo bench --bench micro_ops -- timely_map

# Run only small graph reachability
cargo bench --bench reachability -- small_graph
```

### Generate HTML Reports

Criterion automatically generates HTML reports in `target/criterion/`. View them in a browser:

```bash
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## 📊 Benchmark Structure

### Micro-operations (`micro_ops.rs`)

Tests fundamental operations:
- `timely_map`: Map transformation throughput
- `timely_filter`: Filter operation performance
- `timely_map_filter`: Combined operations

### Reachability (`reachability.rs`)

Tests graph algorithms with differential-dataflow:
- `small_graph`: 10 nodes, ~20 edges
- `medium_graph`: 100 nodes, chain structure
- `dense_graph`: 20 nodes, dense connections

### Dataflow Patterns (`dataflow_patterns.rs`)

Tests common distributed patterns:
- `count_operation`: Aggregation performance
- `join_operation`: Join throughput
- `reduce_operation`: Reduction operations
- `map_reduce_pattern`: End-to-end MapReduce

## 🚀 Performance Comparison Workflow

### 1. Baseline Measurement

Run benchmarks on the current main branch:

```bash
git checkout main
cargo bench --bench micro_ops -- --save-baseline main
```

### 2. Test Changes

After making changes:

```bash
git checkout feature-branch
cargo bench --bench micro_ops -- --baseline main
```

### 3. Compare Results

Criterion will show performance differences:
- **Green**: Improvement
- **Red**: Regression
- **White**: No significant change

## 📈 Interpreting Results

Criterion provides several metrics:

- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second
- **Change**: Percentage difference from baseline

Example output:
```
timely_map/100          time:   [45.2 μs 46.1 μs 47.3 μs]
                        thrpt:  [2.11M elem/s 2.17M elem/s 2.21M elem/s]
                        change: [-5.2% -3.1% -0.8%] (p = 0.02 < 0.05)
                        Performance has improved.
```

## 🔍 Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/` (e.g., `new_bench.rs`)
2. Add it to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "new_bench"
   harness = false
   ```
3. Implement using the Criterion API
4. Run with `cargo bench --bench new_bench`

## ⚙️ Configuration

Benchmark parameters can be adjusted in each file:

- **Sample sizes**: Modify the iteration counts in benchmark groups
- **Data sizes**: Change input sizes in the benchmark loops
- **Warm-up time**: Adjust criterion configuration
- **Measurement time**: Control how long each benchmark runs

## 📚 Dependencies

- `timely`: 0.12 - Timely dataflow system
- `differential-dataflow`: 0.12 - Differential dataflow computations
- `criterion`: 0.5 - Statistical benchmarking framework
- `tokio`: 1.29 - Async runtime for async benchmarks

## 🔗 Integration with CI/CD

These benchmarks can be integrated into CI/CD pipelines:

```bash
# Run benchmarks and fail if regressions detected
cargo bench -- --test

# Save baseline for future comparisons
cargo bench -- --save-baseline ci-baseline
```

## 📝 Notes

- Benchmarks use `black_box` to prevent compiler optimizations
- Results may vary based on system load and hardware
- Run benchmarks on dedicated hardware for consistent results
- Criterion performs statistical analysis to detect real changes

## 🤝 Contributing

When adding benchmarks:

1. Follow existing naming conventions
2. Document what the benchmark measures
3. Use appropriate sample sizes
4. Include both small and large input tests
5. Add comments explaining non-obvious code

## 🔧 Troubleshooting

### Benchmarks Taking Too Long

Reduce sample counts in benchmark configuration:

```rust
group.sample_size(10);  // Default is 100
```

### Inconsistent Results

- Close other applications
- Disable CPU frequency scaling
- Use `--baseline` to compare against stable reference

### Compilation Errors

Ensure dependencies are up to date:

```bash
cargo update
cargo build --benches
```
