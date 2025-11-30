# Benchmark Guide

This guide explains how to run and interpret the Hydro benchmarks in this repository.

## Prerequisites

- Rust toolchain (1.70 or later)
- Access to the sibling `bigweaver-agent-canary-hydro-zeta` repository
- Sufficient disk space for test data files (~4.5 MB total)

## Quick Start

```bash
# Clone both repositories as siblings
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench identity
```

## Available Benchmarks

### 1. Arithmetic (`arithmetic.rs`)

Tests arithmetic operation pipelines with multiple transformation stages.

**What it measures**: Performance of sequential arithmetic operations across different dataflow systems.

**Run**:
```bash
cargo bench -p benches --bench arithmetic
```

**Compares**:
- Raw iteration
- Thread-based pipeline
- Hydro (DFIR)
- Timely Dataflow

### 2. Identity (`identity.rs`)

Tests identity transformations (no-op operations).

**What it measures**: Pure overhead of dataflow systems without computation.

**Run**:
```bash
cargo bench -p benches --bench identity
```

**Compares**:
- Hydro pull (iterator-based)
- Hydro push (streaming)
- Timely Dataflow

### 3. Fan-In (`fan_in.rs`)

Tests merging multiple streams into one.

**What it measures**: Union/merge operation performance.

**Run**:
```bash
cargo bench -p benches --bench fan_in
```

**Compares**:
- Raw iteration with concatenation
- Hydro (DFIR)
- Timely Dataflow

### 4. Fan-Out (`fan_out.rs`)

Tests splitting one stream into multiple outputs.

**What it measures**: Tee/broadcast operation performance.

**Run**:
```bash
cargo bench -p benches --bench fan_out
```

**Compares**:
- Raw iteration
- Hydro (DFIR)
- Timely Dataflow

### 5. Fork-Join (`fork_join.rs`)

Tests split-filter-merge patterns with multiple stages.

**What it measures**: Complex dataflow pattern performance.

**Run**:
```bash
cargo bench -p benches --bench fork_join
```

**Note**: Uses generated code from `build.rs` to create large fork-join patterns.

### 6. Join (`join.rs`)

Tests join operations between two streams.

**What it measures**: Join operation performance.

**Run**:
```bash
cargo bench -p benches --bench join
```

**Compares**:
- Hydro (DFIR) hash join
- Timely Dataflow join

### 7. Symmetric Hash Join (`symmetric_hash_join.rs`)

Tests symmetric hash join specifically.

**What it measures**: Specialized join implementation performance.

**Run**:
```bash
cargo bench -p benches --bench symmetric_hash_join
```

### 8. Reachability (`reachability.rs`)

Tests graph reachability computation using real graph data.

**What it measures**: Iterative graph algorithm performance.

**Data files**:
- `reachability_edges.txt` - Graph edges (~521 KB)
- `reachability_reachable.txt` - Expected reachable nodes (~38 KB)

**Run**:
```bash
cargo bench -p benches --bench reachability
```

**Compares**:
- Hydro (DFIR)
- Differential Dataflow

### 9. Words Diamond (`words_diamond.rs`)

Tests diamond-shaped dataflow patterns with string operations.

**What it measures**: Complex string processing in diamond patterns.

**Data files**:
- `words_alpha.txt` - English word list (~3.7 MB, 370k+ words)

**Run**:
```bash
cargo bench -p benches --bench words_diamond
```

### 10. Upcase (`upcase.rs`)

Tests string transformation (uppercase conversion).

**What it measures**: String processing performance.

**Run**:
```bash
cargo bench -p benches --bench upcase
```

### 11. Micro Operations (`micro_ops.rs`)

Tests individual micro-operations in isolation.

**What it measures**: Performance of specific dataflow operators.

**Run**:
```bash
cargo bench -p benches --bench micro_ops
```

### 12. Futures (`futures.rs`)

Tests async operations and future-based processing.

**What it measures**: Async runtime integration performance.

**Run**:
```bash
cargo bench -p benches --bench futures
```

## Understanding Results

Criterion outputs results in a formatted table:

```
identity/hydro_pull/1000000
                        time:   [2.1234 ms 2.1456 ms 2.1678 ms]
                        change: [-2.34% -1.23% +0.45%] (p = 0.45 > 0.05)
                        No change in performance detected.
```

**Key metrics**:
- **time**: Median time with confidence interval [lower bound median upper bound]
- **change**: Performance change from previous run
- **p-value**: Statistical significance (< 0.05 means significant change)

## Performance Comparison Tips

### Run baselines first

```bash
# Run all benchmarks to establish baseline
cargo bench -p benches
```

### Make changes and compare

```bash
# After making changes to main repository
cargo bench -p benches

# Criterion will automatically compare with baseline
```

### Save specific baseline

```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against specific baseline
cargo bench -p benches -- --baseline my-baseline
```

### Generate detailed reports

```bash
# Criterion generates HTML reports in:
# target/criterion/report/index.html

# Open in browser
firefox target/criterion/report/index.html
```

## Customizing Benchmark Runs

### Adjust sample size

```bash
# More samples = more accurate, but slower
CRITERION_SAMPLE_SIZE=1000 cargo bench -p benches
```

### Filter specific benchmarks

```bash
# Run only benchmarks matching pattern
cargo bench -p benches identity
cargo bench -p benches "join"
```

### Quick mode (for development)

```bash
# Use smaller sample size for quick feedback
cargo bench -p benches -- --quick
```

### Profile mode

```bash
# Build with profiling information
cargo bench -p benches --profile=profile

# Then use profiling tools like perf, valgrind, etc.
```

## Adding New Benchmarks

1. **Create benchmark file**:
   ```bash
   touch benches/benches/my_benchmark.rs
   ```

2. **Add benchmark entry to Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. **Implement benchmark**:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_benchmark", |b| {
           b.iter(|| {
               // Your code to benchmark
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

4. **Run your benchmark**:
   ```bash
   cargo bench -p benches --bench my_benchmark
   ```

## Troubleshooting

### Build errors about missing dfir_rs or sinktools

**Problem**: Path dependencies not found.

**Solution**: Ensure both repositories are cloned as siblings:
```
parent/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

### Benchmark takes too long

**Solution**: Reduce sample size or use quick mode:
```bash
cargo bench -p benches --bench <name> -- --quick
```

### Out of memory errors

**Problem**: Some benchmarks process large datasets.

**Solution**: Close other applications or increase swap space.

### Data files not found

**Problem**: `words_alpha.txt` or reachability data not present.

**Solution**: Ensure you've cloned the full repository with LFS files, or manually download data files.

## Performance Regression Testing

### Set up CI benchmarks

1. Run benchmarks on main branch
2. Save baseline
3. On PR branches, compare against baseline
4. Fail if performance degrades > threshold

### Example CI script

```bash
#!/bin/bash
# Save baseline from main
git checkout main
cargo bench -p benches -- --save-baseline main

# Compare PR against main
git checkout pr-branch
cargo bench -p benches -- --baseline main

# Parse results and fail if regression > 10%
```

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Contributing

When adding or modifying benchmarks:

1. **Clear purpose**: Document what the benchmark measures
2. **Reproducible**: Use fixed seeds for random data
3. **Realistic**: Use realistic data sizes and patterns
4. **Fair comparison**: Compare equivalent operations across systems
5. **Document results**: Add comments explaining expected performance characteristics

## Contact

For questions about benchmarks:
- Open an issue in this repository
- Check main repository for API documentation
- Review existing benchmarks for patterns and examples
