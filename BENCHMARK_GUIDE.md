# Benchmark Guide

Quick reference for running and analyzing Hydro benchmarks.

## Quick Start

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Use helper script
./scripts/run_benchmarks.sh all
```

## Common Tasks

### Running Benchmarks

```bash
# All benchmarks
cargo bench -p benches

# Specific benchmark
cargo bench -p benches --bench join

# With verbose output
cargo bench -p benches --bench reachability -- --verbose

# Quick test (fewer iterations)
cargo bench -p benches --bench identity -- --quick
```

### Saving Baselines

Baselines allow you to compare performance over time:

```bash
# Save current performance as baseline
cargo bench -p benches -- --save-baseline v1

# Run benchmarks and compare to baseline
cargo bench -p benches -- --baseline v1

# Save a new baseline
cargo bench -p benches -- --save-baseline v2
```

### Comparing Performance

```bash
# Compare two baselines
./scripts/compare_performance.sh v1 v2

# Compare specific benchmark
./scripts/compare_performance.sh v1 v2 reachability
```

### Filtering Tests

```bash
# Run only tests matching pattern
cargo bench -p benches --bench micro_ops -- filter

# Run tests for specific implementation
cargo bench -p benches --bench join -- dfir
cargo bench -p benches --bench join -- timely
```

## Benchmark Implementations

Most benchmarks include multiple implementations:

- **dfir**: Hydro's native dataflow implementation
- **timely**: Timely dataflow implementation
- **differential**: Differential dataflow implementation (where applicable)

Example output:
```
join/dfir               time:   [12.3 ms 12.5 ms 12.7 ms]
join/timely             time:   [15.1 ms 15.4 ms 15.7 ms]
```

## Understanding Results

### Time Metrics

```
time:   [45.234 ms 45.789 ms 46.421 ms]
         ^^^^^^    ^^^^^^    ^^^^^^
         lower     estimate  upper
         bound               bound
```

The estimate is the mean, with confidence intervals.

### Throughput Metrics

```
thrpt:  [21.532 Kelem/s 21.836 Kelem/s 22.103 Kelem/s]
```

Higher throughput is better.

### Change Detection

```
change: [-5.2% -3.1% -1.2%] (p = 0.00 < 0.05)
        Performance has improved.
```

Criterion automatically detects significant changes.

## Viewing Reports

Criterion generates HTML reports:

```bash
# View in browser
open target/criterion/report/index.html

# Individual benchmark report
open target/criterion/reachability/report/index.html
```

Reports include:
- Statistical analysis
- Violin plots
- Historical comparison graphs
- Detailed metrics

## Best Practices

### Before Running Benchmarks

1. **Close unnecessary applications** - Reduce system noise
2. **Use a quiet system** - Avoid background processes
3. **Disable CPU frequency scaling** (if possible)
   ```bash
   # Linux example
   sudo cpupower frequency-set --governor performance
   ```
4. **Let system cool down** - Avoid thermal throttling

### Running Benchmarks

1. **Run multiple times** - Ensure consistency
2. **Save baselines** - Track performance over time
3. **Document changes** - Note what changed between runs
4. **Check for outliers** - Review individual iterations

### Analyzing Results

1. **Look at trends** - Single runs can be noisy
2. **Compare implementations** - Identify best approach
3. **Check confidence intervals** - Wide intervals indicate instability
4. **Investigate regressions** - Don't ignore performance drops

## Troubleshooting

### Build Errors

```bash
# Clean build
cargo clean

# Check dependencies
cargo check -p benches

# Verify main repo is accessible
ls ../../bigweaver-agent-canary-hydro-zeta
```

### Slow Benchmarks

```bash
# Run with quick mode
cargo bench -p benches -- --quick

# Run specific test
cargo bench -p benches --bench identity -- dfir
```

### Missing Data Files

Some benchmarks require data files:
- `reachability_edges.txt` - Graph edges
- `reachability_reachable.txt` - Expected results
- `words_alpha.txt` - Word list

These should be in `benches/benches/` directory.

## Adding Custom Benchmarks

### 1. Create Benchmark File

Create `benches/benches/my_benchmark.rs`:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_test", |b| {
        b.iter(|| {
            // Your code here
            black_box(42)
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

### 2. Register in Cargo.toml

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### 3. Run

```bash
cargo bench -p benches --bench my_benchmark
```

## Performance Tips

### Optimization

- Use `black_box()` to prevent compiler optimizations
- Warm up before measurement
- Use appropriate sample sizes
- Consider memory allocation overhead

### Measurement

- Measure what matters (not setup/teardown)
- Use criterion's iteration count
- Profile to understand bottlenecks
- Compare against baselines

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- Main repository: `bigweaver-agent-canary-hydro-zeta`

## Support

For issues or questions:
1. Check the main repository documentation
2. Review criterion.rs documentation
3. Examine existing benchmark implementations
4. Verify cross-repository dependencies are correct
