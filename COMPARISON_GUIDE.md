# Performance Comparison Guide

## Overview

This repository enables performance comparisons between different dataflow implementations. This guide explains how to run benchmarks, interpret results, and compare performance across implementations.

## Current Benchmarks

### Hydro-Native Benchmarks (Available Now)

1. **micro_ops** - Tests basic dataflow operations
   - Identity transformations
   - Unique filtering
   - Map operations
   - Filter operations
   - Fold operations
   
2. **symmetric_hash_join** - Hash join implementation
   - Tests join performance
   - Evaluates hash-based join strategies
   
3. **words_diamond** - Word processing with diamond pattern
   - Tests complex dataflow patterns
   - Uses real-world word data (370K words)
   - Diamond-shaped dependency graph
   
4. **futures** - Asynchronous operations
   - Immediately available futures
   - Delayed futures with polling
   - Async operation overhead

### Future Benchmarks (Planned)

- Timely dataflow equivalent implementations
- Differential-dataflow comparison benchmarks
- Cross-implementation validation tests

## Running Benchmarks

### Quick Start

```bash
# Run all benchmarks
cd benches
cargo bench

# Run specific benchmark
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

### Using the Benchmark Runner Script

```bash
# Run all benchmarks with organized output
./scripts/run_benchmarks.sh
```

This script:
- Runs all benchmarks
- Creates timestamped results directory
- Generates summary reports
- Organizes output for easy comparison

## Understanding Results

### Criterion Output Format

Criterion (the benchmark framework) provides:

1. **Time per iteration**: Average execution time
2. **Throughput**: Operations per second
3. **Standard deviation**: Consistency of results
4. **Change detection**: Comparison with previous runs

Example output:
```
micro/ops/identity      time:   [123.45 µs 124.56 µs 125.67 µs]
                        change: [-2.5% -1.2% +0.3%] (p = 0.15 > 0.05)
                        No change in performance detected.
```

### Interpreting Changes

- **Green (improvement)**: New run is faster than baseline
- **Red (regression)**: New run is slower than baseline
- **Yellow (no change)**: Difference is within noise threshold
- **p-value**: Statistical significance (< 0.05 is significant)

## Comparing Implementations

### Setting Up Comparisons

1. **Baseline Run**: Establish baseline performance
   ```bash
   cargo bench > baseline_results.txt
   ```

2. **After Changes**: Run benchmarks again
   ```bash
   cargo bench > updated_results.txt
   ```

3. **Criterion Auto-Comparison**: Criterion automatically compares with previous runs

### Manual Comparison

```bash
# Compare two result files
diff -u baseline_results.txt updated_results.txt

# Or use criterion's built-in comparison
cargo bench -- --save-baseline baseline_name
cargo bench -- --baseline baseline_name
```

### HTML Reports

Criterion generates detailed HTML reports with:
- Execution time plots
- Performance distribution charts
- Historical comparison graphs
- Statistical analysis

View reports:
```bash
firefox target/criterion/report/index.html
```

## Performance Analysis Tips

### 1. Run Multiple Times

For accurate results, run benchmarks multiple times:
```bash
cargo bench -- --sample-size 100
```

### 2. Minimize Background Noise

- Close unnecessary applications
- Disable CPU frequency scaling if possible
- Run on consistent hardware
- Avoid thermal throttling

### 3. Compare Apples to Apples

- Use same input data sizes
- Test on same hardware
- Use same compiler settings
- Compare similar operations

### 4. Look for Patterns

- Does performance scale linearly with data size?
- Are there unexpected bottlenecks?
- How does performance vary across operations?

## Future: Cross-Implementation Comparison

When timely/differential-dataflow benchmarks are added:

### 1. Parallel Implementations

Create equivalent implementations:
- `micro_ops_hydro.rs` - Hydro implementation
- `micro_ops_timely.rs` - Timely implementation
- `micro_ops_differential.rs` - Differential implementation

### 2. Unified Comparison Script

```bash
# Run all implementations and compare
./scripts/compare_all_implementations.sh
```

### 3. Comparison Metrics

Compare across:
- Execution time
- Memory usage
- Compilation time
- Code complexity
- API ergonomics

## Benchmark Data Organization

### Results Directory Structure

```
results/
├── 20241219_143022/        # Timestamped run
│   ├── README.md           # Run summary
│   ├── benchmark_output.txt
│   └── benchmark_raw.json
├── 20241219_153045/        # Another run
│   └── ...
└── comparisons/            # Comparison reports
    └── hydro_vs_timely.md
```

### Tracking Performance Over Time

1. **Keep Historical Results**: Save results from each run
2. **Track Changes**: Monitor performance across commits
3. **Identify Regressions**: Catch performance degradation early
4. **Document Improvements**: Record optimization wins

## Example Workflow

### Performance Investigation

1. **Establish Baseline**
   ```bash
   git checkout main
   cargo bench --bench micro_ops > baseline.txt
   ```

2. **Test Optimization**
   ```bash
   git checkout feature/optimization
   cargo bench --bench micro_ops > optimized.txt
   ```

3. **Compare Results**
   ```bash
   # Criterion shows automatic comparison
   # Check HTML reports for detailed analysis
   ```

4. **Document Findings**
   ```bash
   # Create comparison report
   echo "# Optimization Results" > results/comparison.md
   echo "Baseline: ..." >> results/comparison.md
   echo "Optimized: ..." >> results/comparison.md
   ```

## Troubleshooting

### Benchmarks Won't Compile

- Check path dependencies (dfir_rs, sinktools)
- Verify workspace setup
- Check Rust version compatibility

### Inconsistent Results

- Reduce background load
- Increase sample size: `--sample-size 200`
- Check for thermal throttling
- Run multiple times and average

### Long Execution Times

- Reduce sample size for quick checks: `--sample-size 10`
- Use `--quick` for faster iterations
- Run specific benchmarks instead of all

## Best Practices

1. **Document Your Setup**: Record hardware, OS, and configuration
2. **Use Consistent Environments**: Same conditions for comparable results
3. **Save Baselines**: Keep reference points for comparison
4. **Version Your Data**: Track which data files used for each run
5. **Automate Where Possible**: Use scripts for reproducibility
6. **Analyze Trends**: Look at performance over time, not just single runs

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Benchmarking Best Practices](https://easyperf.net/blog/2018/08/26/Benchmarking)

## Contact

For questions about benchmarking or performance analysis, see the main repository documentation.
