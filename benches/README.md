# Timely and Differential-Dataflow Performance Comparison Benchmarks

This directory contains benchmarks that compare dfir_rs/Hydro performance against timely and differential-dataflow implementations. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the timely and differential-dataflow dependencies.

## Purpose

These benchmarks provide performance comparisons between:
- **dfir_rs/Hydro implementations** - The primary dataflow framework
- **Timely Dataflow implementations** - Reference implementations using timely
- **Differential Dataflow implementations** - Reference implementations using differential-dataflow

This enables data-driven performance evaluation and helps identify optimization opportunities.

## Available Benchmarks

### Arithmetic Operations
**File**: `arithmetic.rs`

Benchmarks arithmetic operation pipelines with multiple computation stages.

**Variants**:
- `arithmetic/pipeline` - Multi-threaded channel-based pipeline
- `arithmetic/raw` - Raw iterator with minimal overhead (baseline)
- `arithmetic/timely` - Timely dataflow implementation
- `arithmetic/dfir_rs` - dfir_rs implementation
- `arithmetic/dfir_compiled` - Compiled dfir_rs implementation

**Run**:
```bash
cargo bench -p benches --bench arithmetic
```

### Fan-In Pattern
**File**: `fan_in.rs`

Tests fan-in dataflow patterns where multiple streams merge into one.

**Variants**:
- `fan_in/timely` - Timely dataflow implementation
- `fan_in/dfir_rs` - dfir_rs implementation

**Run**:
```bash
cargo bench -p benches --bench fan_in
```

### Fan-Out Pattern
**File**: `fan_out.rs`

Tests fan-out dataflow patterns where one stream splits into multiple streams.

**Variants**:
- `fan_out/timely` - Timely dataflow implementation
- `fan_out/dfir_rs` - dfir_rs implementation

**Run**:
```bash
cargo bench -p benches --bench fan_out
```

### Fork-Join Pattern
**File**: `fork_join.rs`

Benchmarks fork-join patterns with data splitting and merging.

**Variants**:
- `fork_join/timely` - Timely dataflow implementation
- `fork_join/dfir_rs` - dfir_rs implementation

**Run**:
```bash
cargo bench -p benches --bench fork_join
```

### Identity Operations
**File**: `identity.rs`

Tests basic data passing and identity transformations.

**Variants**:
- `identity/raw` - Raw iterator baseline
- `identity/timely` - Timely dataflow implementation
- `identity/dfir_rs` - dfir_rs implementation
- `identity/dfir_compiled` - Compiled dfir_rs implementation

**Run**:
```bash
cargo bench -p benches --bench identity
```

### Join Operations
**File**: `join.rs`

Benchmarks join operations on keyed data streams.

**Variants**:
- `join/timely` - Timely dataflow implementation
- `join/dfir_rs` - dfir_rs implementation

**Run**:
```bash
cargo bench -p benches --bench join
```

### Graph Reachability
**File**: `reachability.rs`

Complex graph reachability computation using iterative dataflow.

**Data Files**:
- `reachability_edges.txt` - Graph edge list (521K)
- `reachability_reachable.txt` - Expected reachable nodes (38K)

**Variants**:
- `reachability/dfir_rs` - dfir_rs implementation
- `reachability/timely` - Timely dataflow implementation
- `reachability/differential` - Differential dataflow implementation

**Run**:
```bash
cargo bench -p benches --bench reachability
```

### String Uppercase
**File**: `upcase.rs`

Benchmarks string transformation operations.

**Variants**:
- `upcase/timely` - Timely dataflow implementation
- `upcase/dfir_rs` - dfir_rs implementation

**Run**:
```bash
cargo bench -p benches --bench upcase
```

## Running Benchmarks

### All Benchmarks
Run all performance comparison benchmarks:
```bash
cargo bench -p benches
```

### Specific Benchmark
Run a single benchmark file:
```bash
cargo bench -p benches --bench <benchmark_name>
```

### Filter by Pattern
Run benchmarks matching a specific pattern:
```bash
# Run all timely implementations
cargo bench -p benches -- timely

# Run all dfir_rs implementations
cargo bench -p benches -- dfir_rs

# Run all arithmetic benchmarks
cargo bench -p benches -- arithmetic
```

### Quick Benchmarks
For faster iteration during development:
```bash
# Run with reduced sample size
cargo bench -p benches -- --quick

# Run specific benchmark variants
cargo bench -p benches -- arithmetic/dfir_rs
```

## Benchmark Output

### Criterion Reports
Criterion generates detailed HTML reports in:
```
target/criterion/<benchmark_name>/report/index.html
```

Open these in a browser to see:
- Performance graphs
- Statistical analysis
- Comparison with previous runs
- Detailed timing information

### Terminal Output
Benchmark results are printed to the terminal with:
- Mean execution time
- Standard deviation
- Performance change vs previous run
- Confidence intervals

### CI Integration
For CI environments, use the bencher output format:
```bash
cargo bench -p benches --output-format bencher
```

## Performance Comparison Methodology

### Baseline Comparisons
Each benchmark includes baseline implementations (where applicable):
- **Raw**: Minimal-overhead iterator baseline
- **Pipeline**: Multi-threaded channel pipeline baseline

These establish performance targets and overhead measurements.

### Framework Comparisons
Benchmarks compare:
1. **Timely Dataflow**: Established streaming dataflow framework
2. **Differential Dataflow**: Incremental computation framework
3. **dfir_rs**: Surface syntax API with runtime optimization
4. **dfir_compiled**: Compile-time optimized dfir_rs

### Interpreting Results
When comparing results:
- **Lower is better** - All times are execution duration
- **Overhead**: Compare framework implementations vs raw baselines
- **Relative performance**: Compare dfir_rs vs timely/differential
- **Optimization impact**: Compare dfir_rs vs dfir_compiled

## Dependencies

### Core Dependencies
- **criterion**: Benchmarking harness with statistical analysis
- **dfir_rs**: Main dataflow framework (from main repository)
- **timely**: Timely Dataflow framework (v0.13.0-dev.1)
- **differential-dataflow**: Differential Dataflow framework (v0.13.0-dev.1)

### Supporting Dependencies
- **futures**: Async/await support
- **tokio**: Async runtime
- **rand**: Random data generation
- **static_assertions**: Compile-time checks

### Dependency Sources
The dfir_rs and sinktools dependencies reference the main repository via git:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git" }
```

For local development, you can override these in `.cargo/config.toml`:
```toml
[patch."https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git"]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

## Adding New Benchmarks

### Structure
Follow this pattern for new benchmarks:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_bench/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_dfir_rs(c: &mut Criterion) {
    c.bench_function("my_bench/dfir_rs", |b| {
        b.iter(|| {
            // dfir_rs implementation
        });
    });
}

criterion_group!(benches, benchmark_timely, benchmark_dfir_rs);
criterion_main!(benches);
```

### Registration
Add to `Cargo.toml`:
```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### Best Practices
1. **Use black_box**: Prevent compiler optimizations: `black_box(value)`
2. **Realistic data**: Use representative data sizes and distributions
3. **Measure fairly**: Ensure all implementations solve the same problem
4. **Document purpose**: Add comments explaining what's being measured
5. **Include baselines**: Add raw/pipeline baselines where applicable

## Troubleshooting

### Build Errors

**Problem**: Compilation fails with dependency errors
```bash
cargo clean
cargo build -p benches
```

**Problem**: dfir_rs or sinktools not found
- Ensure the main repository is accessible
- Check git repository URLs in Cargo.toml
- Consider using local path overrides for development

### Benchmark Failures

**Problem**: Benchmark assertions fail
- Verify test data files are present
- Check that implementations produce identical results
- Review the benchmark logic for correctness

**Problem**: Timeouts or hangs
- Reduce data sizes for faster iteration
- Check for deadlocks in dataflow implementations
- Increase timeout values if needed

### Performance Issues

**Problem**: Benchmarks take too long
```bash
# Reduce sample size
cargo bench -p benches -- --quick --sample-size 10

# Run specific benchmarks only
cargo bench -p benches --bench micro_ops
```

## CI/CD Integration

### GitHub Actions
Example workflow configuration:
```yaml
- name: Run Performance Benchmarks
  run: |
    cargo bench -p benches --output-format bencher | tee benchmark_results.txt
    
- name: Publish Benchmark Results
  uses: benchmark-action/github-action-benchmark@v1
  with:
    tool: 'cargo'
    output-file-path: benchmark_results.txt
```

### Regression Detection
Configure criterion for regression alerts:
```rust
Criterion::default()
    .significance_level(0.05)
    .measurement_time(Duration::from_secs(10))
```

## Related Documentation

- Main repository: bigweaver-agent-canary-hydro-zeta
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion.rs: https://bheisler.github.io/criterion.rs/book/

## Maintenance

### Updating Dependencies
```bash
# Update all dependencies
cargo update -p benches

# Update specific dependency
cargo update -p timely
cargo update -p differential-dataflow
```

### Cleaning Benchmark Data
```bash
# Remove old benchmark results
rm -rf target/criterion/

# Clean and rebuild
cargo clean
cargo build -p benches
```

## Notes

- This repository specifically maintains benchmarks with timely/differential dependencies
- These dependencies are intentionally kept separate from the main repository
- Performance comparison infrastructure enables data-driven optimization decisions
- Benchmark results should be tracked over time to detect regressions
