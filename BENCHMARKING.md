# Benchmarking Guide

## Quick Start

```bash
# Run all benchmarks
cargo bench

# Run with specific worker count
TIMELY_WORKER_THREADS=4 cargo bench

# Generate comparison report
cargo bench --bench join -- --save-baseline main
# After changes:
cargo bench --bench join -- --baseline main
```

## Understanding the Results

### Criterion Output

Criterion provides several metrics for each benchmark:

```
timely/barrier/single_thread/1000
                        time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-5.1234% -3.4567% -1.7890%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Interpreting:**
- **time**: Median time with confidence intervals
- **change**: Performance change from previous run
- **p-value**: Statistical significance (< 0.05 is significant)

### HTML Reports

Detailed reports are generated in `target/criterion/`:
- Violin plots showing distribution
- Line charts for parameter sweeps
- Historical comparison graphs

## Performance Comparison Methodology

### Baseline Comparisons

```bash
# Save current performance as baseline
cargo bench -- --save-baseline before-optimization

# Make your changes...

# Compare against baseline
cargo bench -- --baseline before-optimization
```

### Cross-Framework Comparisons

To compare timely vs differential performance:

1. Run benchmarks separately:
```bash
cargo bench --package timely-benchmarks > timely-results.txt
cargo bench --package differential-benchmarks > diff-results.txt
```

2. Extract metrics using the HTML reports
3. Compare similar operations (e.g., distinct in both frameworks)

## Advanced Configuration

### Custom Criterion Settings

Edit benchmark files to modify:

```rust
use criterion::{Criterion, BenchmarkId};

fn custom_criterion() -> Criterion {
    Criterion::default()
        .sample_size(100)           // Number of iterations
        .measurement_time(Duration::from_secs(10))  // Time per benchmark
        .warm_up_time(Duration::from_secs(3))       // Warm-up duration
}
```

### Environment Variables

- `TIMELY_WORKER_THREADS`: Number of worker threads (default: 1)
- `RUST_LOG`: Enable logging (e.g., `RUST_LOG=timely=debug`)

## Benchmark Design Best Practices

### 1. Isolate What You're Measuring

```rust
// Good: Measures only the operation
b.iter(|| {
    timely::example(|scope| {
        (0..size).to_stream(scope)
            .map(|x| x * 2)  // Only this is measured
            .inspect(|_| {});
    });
});

// Bad: Includes setup in measurement
b.iter(|| {
    let data = generate_data();  // Don't do this!
    // ...
});
```

### 2. Use Appropriate Sample Sizes

- Small operations (< 1ms): 1K-10K elements
- Medium operations (1-10ms): 10K-100K elements
- Large operations (> 10ms): 100K-1M elements

### 3. Avoid Optimization Pitfalls

```rust
use criterion::black_box;

// Good: Prevents compiler optimization
b.iter(|| {
    let result = compute(black_box(input));
    black_box(result)
});

// Bad: Compiler might optimize away
b.iter(|| {
    compute(input);  // Result unused, might be optimized out
});
```

## Continuous Integration

### GitHub Actions Example

```yaml
name: Benchmarks

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: actions-rs/toolchain@v1
      with:
        toolchain: stable
    - name: Run benchmarks
      run: cargo bench --all
    - name: Upload results
      uses: actions/upload-artifact@v2
      with:
        name: benchmark-results
        path: target/criterion/
```

## Performance Regression Detection

### Automated Checks

```bash
#!/bin/bash
# regression-check.sh

cargo bench --bench barrier -- --save-baseline main

# After changes
cargo bench --bench barrier -- --baseline main > results.txt

# Check for regressions > 10%
if grep -q "Performance has regressed" results.txt; then
    echo "⚠️  Performance regression detected!"
    exit 1
fi
```

## Profiling Integration

### Using perf

```bash
# Record benchmark execution
cargo bench --package timely-benchmarks --bench barrier --profile-time=5

# Or use perf directly
perf record --call-graph=dwarf cargo bench --package timely-benchmarks --bench barrier
perf report
```

### Using flamegraph

```bash
cargo install flamegraph
cargo flamegraph --bench barrier
```

## Common Issues and Solutions

### Issue: Inconsistent Results

**Causes:**
- Background processes
- Thermal throttling
- Insufficient warm-up time

**Solutions:**
```bash
# Run with higher sample size
# Edit benchmark to increase sample_size

# Disable frequency scaling (Linux)
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Close unnecessary applications
```

### Issue: Benchmarks Take Too Long

**Solutions:**
- Reduce sample sizes for development
- Use `--quick` flag (less accurate):
```bash
cargo bench -- --quick
```
- Run specific benchmarks only

### Issue: Out of Memory

**Solutions:**
- Reduce data sizes in benchmarks
- Run benchmarks individually
- Increase system swap space

## Reporting Performance Results

When sharing benchmark results, include:

1. **Hardware specs**:
   - CPU model and core count
   - RAM amount
   - OS and kernel version

2. **Software versions**:
   - Rust version
   - Cargo version
   - Dependency versions

3. **Configuration**:
   - Worker thread count
   - Custom Criterion settings
   - Environment variables

4. **Context**:
   - What changed
   - Why it matters
   - Comparison with baseline

Example report:

```markdown
## Benchmark Results

**Environment:**
- CPU: Intel i7-9700K (8 cores)
- RAM: 32GB DDR4
- OS: Ubuntu 22.04
- Rust: 1.70.0

**Configuration:**
- Workers: 4 threads
- Sample size: 100 iterations

**Results:**
Join benchmark improved by 15% after optimizing key distribution.

| Benchmark | Before | After | Change |
|-----------|--------|-------|--------|
| join/simple_join/1000 | 1.23ms | 1.05ms | -14.6% |
| join/simple_join/10000 | 12.5ms | 10.8ms | -13.6% |
```

## Further Reading

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://docs.rs/timely/)
- [Differential Dataflow Documentation](https://docs.rs/differential-dataflow/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
