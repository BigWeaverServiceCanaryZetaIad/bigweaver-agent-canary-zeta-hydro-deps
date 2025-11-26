# Running Benchmarks Guide

Comprehensive guide for running, interpreting, and managing benchmarks in this repository.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Basic Usage](#basic-usage)
- [Advanced Usage](#advanced-usage)
- [Understanding Results](#understanding-results)
- [Benchmark Descriptions](#benchmark-descriptions)
- [Performance Tips](#performance-tips)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before running benchmarks, ensure:

1. **Repository Setup**: Both repositories are cloned as siblings
2. **Build Complete**: Run `cargo build --release -p timely-differential-benches`
3. **System Load**: Close unnecessary applications for accurate results
4. **Power Settings**: Use AC power on laptops (not battery)

## Basic Usage

### Run All Benchmarks

```bash
cargo bench -p timely-differential-benches
```

This will:
- Run all 8 benchmark suites
- Generate statistical analysis
- Create HTML reports
- Save baseline for future comparisons

**Time**: Expect 10-30 minutes depending on system

### Run Single Benchmark

```bash
cargo bench -p timely-differential-benches --bench arithmetic
```

Available benchmarks:
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in dataflow pattern
- `fan_out` - Fan-out dataflow pattern  
- `fork_join` - Fork-join pattern
- `identity` - Identity operations
- `join` - Join operations
- `reachability` - Graph reachability (uses differential-dataflow)
- `upcase` - String transformations

## Advanced Usage

### Filter by Pattern

Run only timely-related benchmarks:
```bash
cargo bench -p timely-differential-benches -- timely
```

Run only hydro-related benchmarks:
```bash
cargo bench -p timely-differential-benches -- hydro
```

Run only differential-dataflow benchmarks:
```bash
cargo bench -p timely-differential-benches -- differential
```

### Run Specific Test Cases

Run arithmetic benchmark with 1000 elements:
```bash
cargo bench -p timely-differential-benches --bench arithmetic -- "1000"
```

### Save Baselines

Save current results as baseline:
```bash
cargo bench -p timely-differential-benches -- --save-baseline my-baseline
```

Compare against baseline:
```bash
cargo bench -p timely-differential-benches -- --baseline my-baseline
```

### Quick Sampling (Fast Mode)

For rapid iteration during development:
```bash
cargo bench -p timely-differential-benches -- --quick
```

This reduces sample size and measurement time.

### Verbose Output

See detailed execution information:
```bash
cargo bench -p timely-differential-benches -- --verbose
```

## Understanding Results

### Console Output

Example output:
```
arithmetic/timely       time:   [123.45 µs 124.32 µs 125.21 µs]
                        change: [-2.1% -1.5% -0.9%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Interpretation**:
- **time**: [lower_bound average upper_bound] - Time measurements with confidence intervals
- **change**: Percentage change compared to previous run or baseline
- **p-value**: Statistical significance (< 0.05 means significant change)

### HTML Reports

Located in `target/criterion/report/index.html`

Reports include:
- **Violin plots**: Distribution of measurements
- **Line charts**: Performance over time
- **Comparison charts**: Timely vs Hydro performance
- **Statistical analysis**: Mean, median, standard deviation

### Comparing Implementations

Each benchmark typically includes multiple implementations:

1. **timely** - Native timely dataflow implementation
2. **hydro** (or **dfir_rs**) - Hydro/dfir_rs implementation
3. **differential** - Differential-dataflow implementation (reachability only)

Results show relative performance between implementations.

## Benchmark Descriptions

### arithmetic.rs
Tests basic arithmetic operations in dataflow pipelines.

**What it measures**:
- Data transformation performance
- Pipeline throughput
- Operator efficiency

**Input sizes**: Various (configured in benchmark)

### fan_in.rs
Tests fan-in dataflow pattern (multiple inputs, single output).

**What it measures**:
- Stream concatenation performance
- Multi-input handling
- Merge efficiency

### fan_out.rs
Tests fan-out dataflow pattern (single input, multiple outputs).

**What it measures**:
- Stream splitting performance
- Tee operation efficiency
- Parallel path creation

### fork_join.rs
Tests fork-join pattern (split, process, merge).

**What it measures**:
- Complex dataflow patterns
- Filter operation performance
- Stream recombination

**Note**: Uses generated code from build.rs (20 operations)

### identity.rs
Tests identity operations (passthrough).

**What it measures**:
- Minimal overhead
- Pipeline baseline performance
- Framework efficiency without transformations

### join.rs
Tests join operations between two streams.

**What it measures**:
- Join performance
- State management
- Cross-stream operations

### reachability.rs
Tests graph reachability using dataflow.

**What it measures**:
- Iterative computation
- State management
- Graph algorithm performance

**Data**: Uses reachability_edges.txt (521KB graph)

**Note**: Includes timely, hydro, AND differential-dataflow implementations

### upcase.rs
Tests string transformation operations.

**What it measures**:
- String processing
- Map operation performance
- Data transformation efficiency

## Performance Tips

### For Accurate Results

1. **System Setup**:
   ```bash
   # Close unnecessary applications
   # Use AC power (laptops)
   # Disable CPU frequency scaling if possible
   ```

2. **Run in Release Mode**:
   Always use `--release` or benchmark commands (which default to release)

3. **Multiple Runs**:
   ```bash
   # Run multiple times to establish confidence
   cargo bench -p timely-differential-benches
   cargo bench -p timely-differential-benches
   cargo bench -p timely-differential-benches
   ```

4. **Baseline Comparisons**:
   ```bash
   # Establish baseline before changes
   cargo bench -p timely-differential-benches -- --save-baseline before
   
   # Make changes...
   
   # Compare after changes
   cargo bench -p timely-differential-benches -- --baseline before
   ```

### For Faster Iteration

1. **Run Single Benchmarks**:
   ```bash
   cargo bench -p timely-differential-benches --bench arithmetic
   ```

2. **Use Quick Mode**:
   ```bash
   cargo bench -p timely-differential-benches -- --quick
   ```

3. **Filter Specific Tests**:
   ```bash
   cargo bench -p timely-differential-benches -- "timely"
   ```

## Troubleshooting

### Long Execution Times

**Symptom**: Benchmarks take hours to complete

**Solutions**:
- Run individual benchmarks instead of all
- Use `--quick` flag for rapid iteration
- Check system resources (CPU, memory)
- Ensure release mode is being used

### Inconsistent Results

**Symptom**: Large variance in results between runs

**Solutions**:
- Close background applications
- Disable CPU frequency scaling
- Run multiple times and average
- Use `--sample-size 100` for more samples

### Out of Memory

**Symptom**: System runs out of memory during benchmarks

**Solutions**:
- Close other applications
- Run benchmarks individually
- Check input sizes in benchmark code
- Monitor with `top` or `htop`

### Build Failures

**Symptom**: Compilation errors before benchmarks run

**Solutions**:
- Verify main repository is in sibling directory
- Check Rust version: `rustc --version`
- Clean and rebuild: `cargo clean && cargo build --release`
- Review error messages for missing dependencies

### Missing HTML Reports

**Symptom**: Can't find criterion HTML reports

**Solutions**:
```bash
# Reports are in target/criterion/
ls target/criterion/report/

# If missing, ensure benchmarks completed successfully
cargo bench -p timely-differential-benches --bench arithmetic
```

## CI/CD Integration

### Running in CI

Example GitHub Actions configuration:

```yaml
- name: Run benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench -p timely-differential-benches --no-fail-fast
```

### Saving Results

```bash
# Save as artifacts
tar -czf benchmark-results.tar.gz target/criterion/
```

## Advanced Configuration

### Criterion Configuration

Benchmarks use Criterion with these features:
- `async_tokio` - Async runtime support
- `html_reports` - HTML report generation

### Modifying Benchmark Parameters

Edit individual benchmark files in `benches/benches/` to adjust:
- Input sizes
- Number of iterations
- Test data

Example from `arithmetic.rs`:
```rust
const NUM_ELEMENTS: usize = 10_000; // Modify this
```

## Best Practices

1. **Establish Baselines**: Always save baselines before making changes
2. **Document Changes**: Note system changes that might affect results
3. **Consistent Environment**: Run on the same machine/configuration
4. **Multiple Runs**: Run at least 3 times for confidence
5. **Review HTML Reports**: Console output is summary, HTML has details
6. **Track Over Time**: Use baselines to track performance evolution

## See Also

- [QUICK_START.md](QUICK_START.md) - Initial setup
- [benches/README.md](benches/README.md) - Benchmark details
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/) - Criterion framework docs
