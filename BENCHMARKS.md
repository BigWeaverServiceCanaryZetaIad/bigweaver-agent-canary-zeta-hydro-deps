# Benchmark Guide

This document provides detailed information about running, interpreting, and comparing the performance benchmarks in this repository.

## Overview

The benchmarks in this repository are designed to compare the performance of Hydro (DFIR) implementations against Timely and Differential-Dataflow implementations. They help answer questions like:

- How does Hydro performance compare to Timely for basic dataflow operations?
- What is the overhead of different framework abstractions?
- How do different implementations scale with data size?
- Which framework is best suited for specific workload patterns?

## Benchmark Categories

### 1. Basic Dataflow Operations

#### Identity Benchmark (`identity.rs`)
**Purpose**: Measures minimal framework overhead by passing data through unchanged.

**Variants**:
- `identity/pipeline` - Multi-threaded channel-based pipeline
- `identity/raw` - Single-threaded vector copying (theoretical minimum)
- `identity/timely` - Timely dataflow implementation
- `identity/dfir` - DFIR implementation

**Key Metrics**: Shows baseline overhead of each framework.

**Run**:
```bash
cargo bench --bench identity
```

#### Arithmetic Benchmark (`arithmetic.rs`)
**Purpose**: Measures performance of simple computational operations in a pipeline.

**Operation**: Applies 20 increment operations to 1 million integers.

**Variants**:
- `arithmetic/pipeline` - Multi-threaded channel-based
- `arithmetic/raw` - Single-threaded vector operations
- `arithmetic/timely` - Timely dataflow
- `arithmetic/dfir` - DFIR implementation

**Run**:
```bash
cargo bench --bench arithmetic
```

#### Upcase Benchmark (`upcase.rs`)
**Purpose**: Measures string transformation performance.

**Operation**: Converts strings to uppercase.

**Run**:
```bash
cargo bench --bench upcase
```

### 2. Dataflow Patterns

#### Fan-In Benchmark (`fan_in.rs`)
**Purpose**: Tests performance when multiple input streams merge into one.

**Pattern**: Multiple producers → Single consumer

**Variants**:
- `fan_in/timely` - Timely dataflow implementation
- `fan_in/dfir` - DFIR implementation

**Run**:
```bash
cargo bench --bench fan_in
```

#### Fan-Out Benchmark (`fan_out.rs`)
**Purpose**: Tests performance when one stream splits to multiple outputs.

**Pattern**: Single producer → Multiple consumers

**Variants**:
- `fan_out/timely` - Timely dataflow implementation
- `fan_out/dfir` - DFIR implementation

**Run**:
```bash
cargo bench --bench fan_out
```

#### Fork-Join Benchmark (`fork_join.rs`)
**Purpose**: Tests split-process-merge patterns common in parallel computing.

**Pattern**: Split → Process in parallel → Join

**Features**:
- Includes output verification
- Generates output files (ignored by git)

**Variants**:
- `fork_join/timely` - Timely dataflow implementation
- `fork_join/dfir` - DFIR implementation

**Run**:
```bash
cargo bench --bench fork_join
```

### 3. Relational Operations

#### Join Benchmark (`join.rs`)
**Purpose**: Measures performance of stream join operations.

**Operation**: Joins two data streams on a key.

**Why Important**: Joins are fundamental to relational data processing and often performance-critical.

**Variants**:
- `join/timely` - Timely dataflow implementation
- `join/dfir` - DFIR implementation

**Run**:
```bash
cargo bench --bench join
```

### 4. Iterative Computation

#### Reachability Benchmark (`reachability.rs`)
**Purpose**: Tests iterative, incremental computation on graphs using fixed-point iteration.

**Operation**: Computes transitive closure (all reachable nodes) in a graph.

**Data**: Uses real graph data:
- `reachability_edges.txt` (521KB) - Graph edges
- `reachability_reachable.txt` (38KB) - Expected results

**Variants**:
- `reachability/differential` - Differential dataflow implementation
- `reachability/dfir` - DFIR implementation

**Why Important**: Tests incremental computation and iteration performance, which are key features of differential dataflow.

**Run**:
```bash
cargo bench --bench reachability
```

## Running Benchmarks

### Basic Usage

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench <name>
```

Run specific tests within a benchmark:
```bash
cargo bench --bench arithmetic -- arithmetic/dfir
cargo bench --bench arithmetic -- arithmetic/timely
```

### Quick Mode

For rapid iteration during development:
```bash
cargo bench -- --quick
```

This reduces:
- Sample size
- Warm-up iterations
- Measurement iterations

Results will be less statistically robust but much faster.

### Comparing Specific Implementations

To compare DFIR vs Timely for arithmetic:
```bash
cargo bench --bench arithmetic -- arithmetic/dfir arithmetic/timely
```

### Saving and Comparing Results

Save a baseline:
```bash
cargo bench --bench arithmetic -- --save-baseline my-baseline
```

Compare against baseline:
```bash
cargo bench --bench arithmetic -- --baseline my-baseline
```

## Interpreting Results

### Terminal Output

Criterion provides statistical analysis including:
```
arithmetic/dfir        time:   [49.234 ms 49.891 ms 50.621 ms]
                       change: [-2.3421% +0.0234% +2.5123%] (p = 0.94 > 0.05)
                       No change in performance detected.
```

**Key Fields**:
- `time`: Mean and confidence interval (lower bound, mean, upper bound)
- `change`: Performance change from previous run
- `p value`: Statistical significance (p < 0.05 means significant change)

### HTML Reports

Detailed reports with charts are generated in `target/criterion/<benchmark-name>/report/index.html`

**Features**:
- Violin plots showing distribution
- Line charts for trends over time
- Detailed statistical analysis
- Outlier detection

Open in browser:
```bash
open target/criterion/report/index.html
```

### Performance Comparison

When comparing implementations, look for:

1. **Absolute Performance**: Which is fastest?
2. **Scaling**: How does performance change with data size?
3. **Consistency**: Check standard deviation and outliers
4. **Overhead**: Compare against baseline (raw/pipeline) implementations

**Example Analysis**:
```
identity/raw        time: [10.2 ms 10.3 ms 10.4 ms]
identity/timely     time: [12.1 ms 12.3 ms 12.5 ms]  (~20% overhead)
identity/dfir       time: [11.5 ms 11.7 ms 11.9 ms]  (~14% overhead)
```

Interpretation: DFIR has less overhead than Timely for identity operations.

## Performance Tips

### System Considerations

For accurate benchmarks:

1. **Disable CPU frequency scaling**:
   ```bash
   # Linux
   sudo cpupower frequency-set --governor performance
   ```

2. **Close other applications**: Reduce system noise

3. **Run multiple times**: Use Criterion's built-in statistical analysis

4. **Check for thermal throttling**: Ensure CPU doesn't overheat during long runs

### Benchmark Parameters

Many benchmarks have configurable constants:

```rust
const NUM_INTS: usize = 1_000_000;
const NUM_OPS: usize = 20;
```

Modify these to test different scales, but document changes for reproducibility.

## Troubleshooting

### Compilation Issues

If benchmarks fail to compile:

1. Check Rust version:
   ```bash
   rustc --version  # Should be 1.91.1
   ```

2. Update dependencies:
   ```bash
   cargo update
   ```

3. Clean and rebuild:
   ```bash
   cargo clean
   cargo check --benches
   ```

### Dependency Issues

If `dfir_rs` or `sinktools` dependencies fail:

```bash
# Update git dependencies
cargo update -p dfir_rs -p sinktools
```

### Benchmark Failures

If a benchmark fails at runtime:

1. **Check test data**: Ensure `.txt` files are present in `benches/`
2. **Run in debug mode**: `cargo bench --bench <name> -- --profile-time 10`
3. **Check output**: Look for assertion failures or panics

### Performance Anomalies

If results seem unusual:

1. **System interference**: Close other applications
2. **Thermal throttling**: Check CPU temperature
3. **Different hardware**: Results vary by CPU, memory, etc.
4. **Sample size**: Increase measurement iterations

## Continuous Integration

### CI/CD Integration

For automated performance regression testing:

```yaml
# Example GitHub Actions snippet
- name: Run benchmarks
  run: cargo bench --bench arithmetic -- --output-format bencher | tee output.txt
  
- name: Check for regressions
  run: cargo bench --bench arithmetic -- --baseline main
```

### Performance Regression Detection

Set up alerts for performance regressions:

1. Save baseline on main branch
2. Compare feature branches against baseline
3. Fail CI if performance degrades significantly (e.g., >10%)

## Advanced Usage

### Custom Benchmark Parameters

Modify benchmark constants for specific workloads:

```rust
// In arithmetic.rs
const NUM_OPS: usize = 50;     // More operations
const NUM_INTS: usize = 10_000_000; // Larger dataset
```

### Profiling Integration

Use profiling tools with benchmarks:

```bash
# Linux perf
cargo bench --bench arithmetic --no-run
perf record -g target/release/deps/arithmetic-*
perf report
```

### Flamegraphs

Generate flamegraphs for visual performance analysis:

```bash
cargo install flamegraph
cargo flamegraph --bench arithmetic
```

## Contributing Benchmarks

When adding new benchmarks:

1. **Follow existing patterns**: Use Criterion framework
2. **Include multiple implementations**: For comparison
3. **Document thoroughly**: Explain what you're measuring and why
4. **Choose realistic workloads**: Not just microbenchmarks
5. **Add to Cargo.toml**: Include `[[bench]]` entry
6. **Update documentation**: Add to this guide

### Benchmark Template

```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_benchmark/baseline", |b| {
        b.iter(|| {
            // Baseline implementation
        });
    });
    
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
    
    c.bench_function("my_benchmark/dfir", |b| {
        b.iter(|| {
            // DFIR implementation
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

## Best Practices

1. **Run full suite before committing**: `cargo bench`
2. **Document significant changes**: Note in commit messages
3. **Save baselines**: For tracking performance over time
4. **Test on target hardware**: Results vary by platform
5. **Use consistent environment**: Same system, same settings
6. **Warm up properly**: Let Criterion handle warm-up iterations
7. **Check statistical significance**: Don't overreact to noise

## References

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
