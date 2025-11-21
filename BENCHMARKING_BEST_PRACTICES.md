# Benchmarking Best Practices

This guide provides best practices for running, analyzing, and contributing to benchmarks in this repository.

## Table of Contents

- [Running Benchmarks Reliably](#running-benchmarks-reliably)
- [Interpreting Results](#interpreting-results)
- [Writing New Benchmarks](#writing-new-benchmarks)
- [Avoiding Common Pitfalls](#avoiding-common-pitfalls)
- [Performance Optimization Guidelines](#performance-optimization-guidelines)
- [Statistical Considerations](#statistical-considerations)

## Running Benchmarks Reliably

### Environment Preparation

#### 1. System Configuration

For consistent results, prepare your system:

```bash
# Close unnecessary applications
# Disable background services (antivirus, updates, etc.)

# Linux: Set CPU governor to performance mode
sudo cpupower frequency-set --governor performance

# Linux: Disable turbo boost for consistency
echo "1" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

# Check CPU frequency
cat /proc/cpuinfo | grep MHz
```

#### 2. Hardware Considerations

- **Laptops**: Connect to AC power to prevent throttling
- **Thermal**: Ensure adequate cooling (check temperature with `sensors`)
- **Memory**: Close memory-intensive applications
- **Storage**: Ensure sufficient disk space for results

#### 3. Benchmark Configuration

```bash
# Default: Accurate results (slower)
cargo bench

# Quick iteration: Fewer samples (faster)
CRITERION_SAMPLE_SIZE=10 cargo bench

# High accuracy: More samples and longer measurement
CRITERION_SAMPLE_SIZE=200 CRITERION_MEASUREMENT_TIME=10 cargo bench

# CI-friendly: Fast and reproducible
CRITERION_SAMPLE_SIZE=10 CRITERION_MEASUREMENT_TIME=5 cargo bench
```

### Best Practices for Consistent Results

1. **Multiple runs**: Run benchmarks 3-5 times and compare
2. **Consistent conditions**: Same time of day, temperature, load
3. **Warm system**: Run a full benchmark suite once to warm up
4. **Check variance**: Look at confidence intervals - narrow is better
5. **Baseline comparison**: Always compare against a saved baseline

### Example Workflow

```bash
# 1. Prepare system
make clean
sudo cpupower frequency-set --governor performance

# 2. Run baseline
git checkout main
cargo bench -- --save-baseline main

# 3. Switch to feature branch
git checkout my-feature

# 4. Run comparison
cargo bench -- --baseline main

# 5. Check for regressions
./check_performance.sh main
```

## Interpreting Results

### Understanding Criterion Output

```
arithmetic/timely       time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.3% -1.8% -1.2%] (p = 0.00 < 0.05)
                        Performance has improved.
```

Breaking this down:
- **time**: `[lower_bound mean upper_bound]` - 95% confidence interval
- **change**: Percentage change from baseline `[lower mean upper]`
- **p-value**: Statistical significance (p < 0.05 means significant)
- **Assessment**: Criterion's interpretation

### What to Look For

#### 1. Absolute Performance
```
arithmetic/timely:  45.456 ms
arithmetic/raw:     30.123 ms
Overhead:           ~50%
```

Questions:
- Is the overhead acceptable?
- Does it scale with data size?
- How does it compare to alternatives?

#### 2. Relative Performance
```
Before optimization: 45.456 ms
After optimization:  38.234 ms
Improvement:        ~16%
```

Questions:
- Is the improvement statistically significant?
- Is it consistent across benchmarks?
- Does it regress other benchmarks?

#### 3. Variance and Confidence

```
Narrow CI:   [45.1 ms 45.5 ms 45.9 ms]  ✓ Good
Wide CI:     [40.0 ms 50.0 ms 60.0 ms]  ✗ Bad
```

Wide confidence intervals indicate:
- Inconsistent measurements
- System noise
- Need for more samples
- Benchmark design issues

#### 4. Statistical Significance

```
p = 0.00 < 0.05  ✓ Significant difference
p = 0.15 > 0.05  ✗ Not significant (could be noise)
```

### HTML Reports

Open `target/criterion/report/index.html` for:
- Detailed timing plots
- Distribution graphs
- Historical comparisons
- Regression analysis

## Writing New Benchmarks

### Benchmark Structure

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

fn benchmark_my_feature(c: &mut Criterion) {
    // Group related benchmarks
    let mut group = c.benchmark_group("my_feature");
    
    // Configure group if needed
    group.sample_size(100);
    group.measurement_time(std::time::Duration::from_secs(5));
    
    // Framework implementation
    group.bench_function("timely", |b| {
        b.iter(|| {
            // Your timely implementation
            black_box(result);
        });
    });
    
    // Baseline implementation
    group.bench_function("raw", |b| {
        b.iter(|| {
            // Raw/baseline implementation
            black_box(result);
        });
    });
    
    group.finish();
}

criterion_group!(my_benches, benchmark_my_feature);
criterion_main!(my_benches);
```

### Setup vs Measurement

Separate expensive setup from measurement:

```rust
use criterion::BatchSize;

// BAD: Setup included in measurement
b.iter(|| {
    let data = generate_data();  // Expensive!
    process(data)
});

// GOOD: Setup excluded from measurement
b.iter_batched(
    || generate_data(),          // Setup (not measured)
    |data| process(data),        // Measurement
    BatchSize::LargeInput        // Optimize for large inputs
);
```

### Using black_box

Always use `black_box` to prevent compiler optimizations:

```rust
use criterion::black_box;

// BAD: Compiler might optimize away
b.iter(|| {
    let result = expensive_operation(input);
    result  // Dead code elimination!
});

// GOOD: black_box prevents optimization
b.iter(|| {
    let result = expensive_operation(black_box(input));
    black_box(result)
});
```

### Parameterized Benchmarks

Test multiple scenarios:

```rust
fn benchmark_scaling(c: &mut Criterion) {
    let mut group = c.benchmark_group("scaling");
    
    for size in [100, 1_000, 10_000, 100_000].iter() {
        group.bench_with_input(
            BenchmarkId::new("timely", size),
            size,
            |b, &size| {
                b.iter(|| process_n_items(black_box(size)));
            }
        );
    }
    
    group.finish();
}
```

## Avoiding Common Pitfalls

### 1. Dead Code Elimination

**Problem**: Compiler removes "unused" code

```rust
// BAD
b.iter(|| {
    expensive_operation();  // Result unused - might be optimized away!
});

// GOOD
b.iter(|| {
    black_box(expensive_operation());
});
```

### 2. Loop Hoisting

**Problem**: Compiler moves invariant code outside loop

```rust
// BAD
b.iter(|| {
    let constant = compute_constant();  // Hoisted outside loop!
    for item in data {
        process(item, constant);
    }
});

// GOOD
let constant = compute_constant();
b.iter(|| {
    for item in data {
        process(item, black_box(constant));
    }
});
```

### 3. Setup in Measurement

**Problem**: Setup time included in measurement

```rust
// BAD
b.iter(|| {
    let data = generate_test_data();  // Expensive setup!
    process(data)
});

// GOOD
b.iter_batched(
    || generate_test_data(),
    |data| process(data),
    BatchSize::LargeInput
);
```

### 4. Non-deterministic Input

**Problem**: Random input makes results inconsistent

```rust
// BAD
b.iter(|| {
    let random_data = random_vec();  // Different each time!
    process(random_data)
});

// GOOD
use rand::{SeedableRng, rngs::StdRng};
let mut rng = StdRng::seed_from_u64(42);  // Seeded RNG
let data: Vec<_> = (0..1000).map(|_| rng.gen()).collect();

b.iter(|| {
    process(black_box(&data))
});
```

### 5. Unrealistic Workloads

**Problem**: Benchmark doesn't reflect real usage

```rust
// BAD: Trivial workload
b.iter(|| {
    vec![1, 2, 3].iter().sum()  // Too small!
});

// GOOD: Realistic workload
const SIZE: usize = 10_000;
let data: Vec<_> = (0..SIZE).collect();

b.iter(|| {
    black_box(&data).iter().sum()
});
```

### 6. Cache Effects

**Problem**: Hot cache gives unrealistic results

```rust
// Consider cache effects
b.iter_batched(
    || generate_data(),
    |data| {
        // First access warms cache
        process(data)  // Subsequent accesses hit cache
    },
    BatchSize::PerIteration  // Fresh data each iteration
);
```

## Performance Optimization Guidelines

### 1. Profile Before Optimizing

```bash
# Use flamegraph for profiling
cargo flamegraph --bench arithmetic

# Use perf for detailed analysis (Linux)
perf record -g cargo bench --bench arithmetic --profile-time 10
perf report
```

### 2. Measure Impact

Always measure optimization impact:

```bash
# Save baseline before optimization
cargo bench -- --save-baseline before

# Make optimization changes
# ...

# Compare after optimization
cargo bench -- --baseline before
```

### 3. Micro vs Macro Optimization

- **Micro**: Small, local improvements (algorithm choice, data structures)
- **Macro**: Large, architectural changes (parallelism, async, caching)

Prioritize macro optimizations for bigger gains.

### 4. Optimization Checklist

- [ ] Profiled to identify bottleneck
- [ ] Measured baseline performance
- [ ] Implemented optimization
- [ ] Measured optimized performance
- [ ] Verified correctness
- [ ] Checked for regressions in other benchmarks
- [ ] Documented optimization rationale

## Statistical Considerations

### Confidence Intervals

```
Narrow CI (good):
  time: [45.1 ms 45.5 ms 45.9 ms]
  95% confident mean is between 45.1 and 45.9 ms
  
Wide CI (bad):
  time: [40.0 ms 50.0 ms 60.0 ms]
  High variance - need more samples or less noise
```

### P-values and Significance

```
p < 0.05: Change is statistically significant
p ≥ 0.05: Change might be noise

Example:
  change: [+2.1% +2.5% +2.9%] (p = 0.001)
  ✓ Significant regression
  
  change: [-0.5% +0.1% +0.7%] (p = 0.42)
  ○ Not significant (could be noise)
```

### Sample Size

```bash
# Small sample (fast, less accurate)
CRITERION_SAMPLE_SIZE=10 cargo bench

# Default sample (balanced)
cargo bench  # sample_size = 100

# Large sample (slow, more accurate)
CRITERION_SAMPLE_SIZE=200 cargo bench
```

### Outliers

Criterion automatically detects and handles outliers:
- **Mild outliers**: > 1.5 × IQR from quartiles
- **Severe outliers**: > 3.0 × IQR from quartiles

Check HTML report for outlier analysis.

### Comparing Benchmarks

Use appropriate statistical tests:

```bash
# Criterion uses t-test for comparing means
# Valid when:
# - Independent samples
# - Approximately normal distribution
# - Similar variances

# For non-normal distributions or unequal variances,
# consider longer measurement times or more samples
```

## Documentation Requirements

When adding benchmarks, document:

1. **What it measures**
   ```rust
   /// Benchmarks hash join performance with various input sizes.
   /// Measures both timely implementation and raw HashMap baseline.
   ```

2. **Configuration**
   ```rust
   const LEFT_SIZE: usize = 10_000;
   const RIGHT_SIZE: usize = 10_000;
   const KEY_SPACE: usize = 100;
   ```

3. **Expectations**
   ```rust
   // Expected performance:
   // - Timely: ~50ms (1.25x overhead)
   // - Raw: ~40ms (baseline)
   ```

4. **Known issues**
   ```rust
   // TODO: Add incremental join benchmark
   // NOTE: Large key spaces may cause memory pressure
   ```

## Continuous Integration

### CI-Friendly Configuration

```yaml
# GitHub Actions example
- name: Run benchmarks
  run: |
    CRITERION_SAMPLE_SIZE=10 \
    CRITERION_MEASUREMENT_TIME=5 \
    cargo bench --no-fail-fast
```

### Regression Detection

```bash
# In CI, compare against main branch
git checkout main
cargo bench -- --save-baseline main
git checkout $FEATURE_BRANCH
cargo bench -- --baseline main

# Check for regressions
./check_performance.sh main
```

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Statistics for A/B Testing](https://www.evanmiller.org/ab-testing/)
- [Benchmarking Crimes](https://www.youtube.com/watch?v=nXaxk27zwlk)

## Quick Reference

### Common Commands

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Quick iteration
make bench-quick

# Save baseline
cargo bench -- --save-baseline my-baseline

# Compare against baseline
cargo bench -- --baseline my-baseline

# Check for regressions
./check_performance.sh main
```

### Environment Variables

```bash
CRITERION_SAMPLE_SIZE=100        # Number of samples
CRITERION_MEASUREMENT_TIME=5     # Seconds per benchmark
CRITERION_WARM_UP_TIME=3         # Warm-up seconds
PERF_THRESHOLD=5.0              # Regression threshold (%)
```

### Troubleshooting

| Problem | Solution |
|---------|----------|
| High variance | Increase sample size, reduce system noise |
| Too slow | Reduce sample size, shorter measurement time |
| Inconsistent results | Check system load, disable frequency scaling |
| Wide CI | More samples, longer measurement time |
| Outliers | Check for background processes, thermal throttling |

---

Following these best practices will help ensure reliable, meaningful benchmark results that can guide performance optimization efforts.
