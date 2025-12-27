# bigweaver-agent-canary-zeta-hydro-deps

Comprehensive benchmark suite for Timely Dataflow and Differential Dataflow with performance comparison functionality.

## Overview

This repository contains benchmark implementations for:
- **Timely Dataflow**: Low-latency streaming dataflow benchmarks
- **Differential Dataflow**: Incremental computation benchmarks
- **Comparison Tools**: Utilities for analyzing and comparing performance

## Repository Structure

```
.
├── timely-benchmarks/          # Timely dataflow benchmarks
│   └── benches/
│       ├── graph_reachability.rs
│       ├── data_parallel.rs
│       ├── barrier_sync.rs
│       └── exchange.rs
├── differential-benchmarks/    # Differential dataflow benchmarks
│   └── benches/
│       ├── incremental_join.rs
│       ├── graph_computation.rs
│       ├── group_reduce.rs
│       └── distinct.rs
└── comparison-tools/           # Performance comparison utilities
    └── src/
        ├── compare.rs
        └── analyze.rs
```

## Benchmark Categories

### Timely Dataflow Benchmarks

1. **Graph Reachability** (`graph_reachability.rs`)
   - Graph reachability computation using iterative dataflow
   - Join operations with data shuffling
   - Tests scalability with different graph sizes

2. **Data Parallel Operations** (`data_parallel.rs`)
   - Map, filter, and flat_map operations
   - Basic data-parallel transformations
   - Tests throughput with varying data sizes

3. **Barrier Synchronization** (`barrier_sync.rs`)
   - Barrier synchronization performance
   - Epoch advancement timing
   - Tests coordination overhead

4. **Exchange Patterns** (`exchange.rs`)
   - Data exchange/shuffling performance
   - Hash-based partitioning
   - Tests network communication patterns

### Differential Dataflow Benchmarks

1. **Incremental Join** (`incremental_join.rs`)
   - Incremental join operations
   - Multi-way join performance
   - Tests incremental update efficiency

2. **Graph Computation** (`graph_computation.rs`)
   - Connected components computation
   - Transitive closure computation
   - Tests iterative graph algorithms

3. **Group and Reduce** (`group_reduce.rs`)
   - Group-by and aggregation operations
   - Count and sum aggregations
   - Tests incremental aggregation

4. **Distinct Operations** (`distinct.rs`)
   - Distinct value computation
   - High and low cardinality scenarios
   - Tests deduplication performance

## Running Benchmarks

### Prerequisites

```bash
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Update Rust toolchain
rustup update
```

### Run All Benchmarks

```bash
# Run all timely benchmarks
cargo bench -p timely-benchmarks

# Run all differential benchmarks
cargo bench -p differential-benchmarks

# Run all benchmarks in workspace
cargo bench --workspace
```

### Run Specific Benchmarks

```bash
# Run specific timely benchmark
cargo bench -p timely-benchmarks --bench graph_reachability
cargo bench -p timely-benchmarks --bench data_parallel
cargo bench -p timely-benchmarks --bench barrier_sync
cargo bench -p timely-benchmarks --bench exchange

# Run specific differential benchmark
cargo bench -p differential-benchmarks --bench incremental_join
cargo bench -p differential-benchmarks --bench graph_computation
cargo bench -p differential-benchmarks --bench group_reduce
cargo bench -p differential-benchmarks --bench distinct
```

### Run Specific Test Cases

```bash
# Run only join benchmarks
cargo bench --bench graph_reachability -- join

# Run benchmarks with specific size
cargo bench --bench data_parallel -- 10000
```

## Performance Comparison

### Using the Comparison Tool

The comparison tool analyzes and compares benchmark results from Criterion output:

```bash
# Build comparison tools
cargo build --release -p comparison-tools

# Compare timely vs differential results
./target/release/compare-benchmarks \
    ./target/criterion/timely \
    ./target/criterion/differential

# Analyze benchmark results
./target/release/analyze-results ./target/criterion
```

### Comparison Output

The comparison tool generates:
- Console output with side-by-side comparisons
- JSON export (`benchmark_comparison.json`) with detailed results
- Statistical analysis including speedup factors

Example output:
```
=== Benchmark Comparison Results ===

Benchmark                                  Timely (ns)  Differential (ns)    Speedup  Notes
----------------------------------------------------------------------------------------------------
join/1000                                      1234.56           1456.78        1.18x  OK
graph/reachability/100                         2345.67           2567.89        1.09x  OK
```

### Analysis Output

The analysis tool provides:
- Detailed statistical metrics (mean, median, standard error)
- Throughput calculations (elements/second)
- Identification of fastest/slowest benchmarks

## Benchmark Results

Results are stored in `target/criterion/` with the following structure:
```
target/criterion/
├── timely/
│   ├── graph_reachability/
│   ├── data_parallel/
│   └── ...
└── differential/
    ├── incremental_join/
    ├── graph_computation/
    └── ...
```

Each benchmark directory contains:
- `base/`: Baseline results for comparison
- `new/`: Latest benchmark results
- `report/`: HTML reports with graphs
- `estimates.json`: Raw statistical data

## Viewing HTML Reports

Criterion generates detailed HTML reports:

```bash
# Open the main report
open target/criterion/report/index.html

# Open specific benchmark report
open target/criterion/timely/graph_reachability/report/index.html
```

## Performance Tips

### Optimizing Benchmark Runs

1. **Reduce System Noise**:
   ```bash
   # Disable CPU frequency scaling (Linux)
   sudo cpupower frequency-set --governor performance
   ```

2. **Isolate CPU Cores**:
   ```bash
   # Run on specific CPU cores
   taskset -c 0-3 cargo bench
   ```

3. **Adjust Sample Size**:
   - Edit benchmark to change sample size
   - Larger samples = more accurate but slower

### Interpreting Results

- **Mean**: Average execution time
- **Median**: Middle value (less affected by outliers)
- **MAD**: Median Absolute Deviation (measure of variability)
- **Throughput**: Elements processed per second

## Comparing with Hydro

To compare these benchmarks with Hydro implementations:

1. Run these benchmarks and save results
2. Run equivalent Hydro benchmarks from the main repository
3. Use the comparison tool to analyze differences
4. Consider differences in:
   - Execution model (push vs pull)
   - Scheduling strategies
   - Memory management
   - API abstractions

## Development

### Adding New Benchmarks

1. Create a new benchmark file in `benches/`:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // Your benchmark code
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. Add to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Run your benchmark:
   ```bash
   cargo bench --bench my_benchmark
   ```

### Customizing Comparison Tools

The comparison tools are designed to be extensible:
- Modify `compare.rs` to add new comparison metrics
- Update `analyze.rs` to include custom statistical analyses
- Add new output formats (CSV, Markdown, etc.)

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Benchmarks

on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          profile: minimal
          toolchain: stable
      - name: Run benchmarks
        run: cargo bench --workspace
      - name: Upload results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

## Performance Baselines

Establish performance baselines for regression testing:

```bash
# Save baseline
cargo bench --workspace -- --save-baseline my-baseline

# Compare against baseline
cargo bench --workspace -- --baseline my-baseline
```

## Troubleshooting

### Common Issues

1. **Out of Memory**:
   - Reduce benchmark data sizes
   - Run benchmarks individually
   - Increase system swap space

2. **Slow Benchmark Execution**:
   - Use `--sample-size` to reduce iterations
   - Run specific benchmarks instead of all
   - Example: `cargo bench -- --sample-size 10`

3. **Inconsistent Results**:
   - Close background applications
   - Disable CPU frequency scaling
   - Run multiple times and average

## Contributing

Contributions are welcome! Please ensure:
- New benchmarks are well-documented
- Benchmark names follow the existing convention
- Results are reproducible
- Performance characteristics are explained

## License

MIT OR Apache-2.0

## References

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Project](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)