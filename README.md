# bigweaver-agent-canary-zeta-hydro-deps

Performance benchmarking repository for Hydro dataflow processing with timely-dataflow and differential-dataflow dependencies.

## 📋 Overview

This repository contains comprehensive performance benchmarks that were strategically moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain clean separation of concerns and optimize build performance.

## 🎯 Purpose

This repository serves as a dedicated performance testing environment that isolates heavy dependencies from the main Hydro repository. The separation provides several key benefits:

### ✅ Primary Goals
- **Reduce Build Times**: Achieves 40-60% reduction in build times for the main repository
- **Isolate Heavy Dependencies**: Keeps `timely` and `differential-dataflow` dependencies separate from core functionality
- **Enable Performance Comparisons**: Provides infrastructure to compare Hydro/DFIR performance against timely and differential implementations
- **Independent Testing Workflow**: Allows performance testing without impacting main repository development
- **Reduce Maintenance Overhead**: Minimizes dependency complexity in the main codebase

### 🔗 Relationship to Main Repository

This repository maintains a close relationship with the main `bigweaver-agent-canary-hydro-zeta` repository:

- **Dependencies**: References `dfir_rs` and `sinktools` from the main repository via Git
- **Coordination**: Changes should be coordinated when APIs or interfaces change
- **Purpose**: Complements the main repository by providing performance validation
- **Architecture**: Part of a microservice architecture with clear component boundaries

## 🧪 Benchmark Suite Structure

The `benches/` directory contains **12 comprehensive benchmarks** that compare three different dataflow processing implementations:

| Implementation | Description |
|---------------|-------------|
| **dfir_rs** | Hydro's dataflow implementation optimized for compile-time optimization and type safety |
| **timely** | Mature runtime with dynamic dataflow and runtime flexibility |
| **differential** | Incremental computation framework with automatic updates and efficient change propagation |

### 📊 Benchmark Categories

#### Dataflow Patterns
- **fan_in.rs** - Multiple input streams merging into one (tests stream merging overhead)
- **fan_out.rs** - Single stream splitting to multiple outputs (tests broadcast distribution)
- **fork_join.rs** - Fork and join patterns with filtering and merging (complex branching)
- **words_diamond.rs** - Diamond-shaped dataflow pattern with word processing (data-dependent branching)

#### Operations & Algorithms
- **arithmetic.rs** - Basic arithmetic operations pipeline (baseline for simple operations)
- **identity.rs** - Identity function benchmark with timely implementation (establishes baseline overhead)
- **join.rs** - Stream join operations with timely implementation (hash join performance)
- **symmetric_hash_join.rs** - Symmetric hash join implementation (bidirectional join)
- **reachability.rs** - Graph reachability algorithm with differential-dataflow implementation (iterative graph traversal)

#### Specialized Tests
- **micro_ops.rs** - Micro-benchmarks for various operators (isolates specific operator performance)
- **upcase.rs** - String transformation benchmark (string processing overhead)
- **futures.rs** - Async futures-based processing (async overhead and scheduling)

### 📁 Test Data Files
- `reachability_edges.txt` - Graph edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation
- `words_alpha.txt` - Dictionary file for word processing benchmarks

## 🚀 Running Performance Comparisons

### Quick Start

Run all benchmarks to get comprehensive performance comparisons:

```bash
cargo bench
```

This will execute all 12 benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark

To focus on a particular benchmark:

```bash
cargo bench --bench <benchmark_name>
```

**Examples:**
```bash
# Test arithmetic pipeline performance
cargo bench --bench arithmetic

# Compare join implementations
cargo bench --bench join

# Test graph algorithm performance
cargo bench --bench reachability

# Baseline overhead measurement
cargo bench --bench identity
```

### Run Specific Test Within a Benchmark

To run a specific implementation within a benchmark:

```bash
cargo bench --bench <benchmark_name> -- <test_pattern>
```

**Examples:**
```bash
# Run only the dfir_rs implementation
cargo bench --bench arithmetic -- arithmetic/dfir_rs

# Run only the timely implementation
cargo bench --bench join -- join/usize/usize/timely

# Run only the differential implementation
cargo bench --bench reachability -- reachability/differential
```

### Quick Performance Check

For faster iteration during development:

```bash
# Run with reduced sample size
cargo bench -- --quick

# Run specific benchmark with quick mode
cargo bench --bench arithmetic -- --quick
```

## 📦 Dependencies

### Key Dependencies

The repository maintains the following critical dependencies:

#### Timely and Differential Dependencies
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

These are the heavy dependencies that were isolated from the main repository to improve build times.

#### Main Repository Dependencies
```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" }
```

These point to the main Hydro repository to access core functionality.

#### Benchmarking Framework
```toml
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
```

Provides statistical analysis and HTML report generation.

## ➕ Adding New Benchmarks

To add a new benchmark to the suite:

### Step 1: Create Benchmark File

Create a new `.rs` file in the `benches/` directory:

```rust
use criterion::{Criterion, criterion_group, criterion_main, black_box};

fn benchmark_dfir_rs(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir_rs", |b| {
        b.iter(|| {
            // Your dfir_rs implementation
            black_box(/* result */);
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Your timely implementation
            black_box(/* result */);
        });
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("my_benchmark/differential", |b| {
        b.iter(|| {
            // Your differential implementation
            black_box(/* result */);
        });
    });
}

criterion_group!(
    benches,
    benchmark_dfir_rs,
    benchmark_timely,
    benchmark_differential
);
criterion_main!(benches);
```

### Step 2: Register in Cargo.toml

Add the benchmark to `Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### Step 3: Follow Best Practices

- **Use consistent naming**: `<benchmark_name>/<implementation>` pattern
- **Include all three implementations**: dfir_rs, timely, and differential (when applicable)
- **Use realistic workloads**: Representative data sizes and operations
- **Add data files**: Place test data files in `benches/` directory if needed
- **Document the benchmark**: Add description to this README and `BENCHMARKS_GUIDE.md`
- **Use `black_box()`**: Prevent compiler optimizations from skipping work

### Step 4: Verify Performance

Run your new benchmark:

```bash
cargo bench --bench my_benchmark
```

Check the generated HTML report in `target/criterion/my_benchmark/`.

## 📖 Interpreting Results

### Criterion Output

Benchmark results provide:

- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second (when applicable)
- **Change**: Performance change compared to previous runs (after first run)
- **R² value**: Statistical measure of fit quality

### HTML Reports

Generated reports (`target/criterion/`) include:

- **Violin plots**: Distribution of measurement samples
- **Line charts**: Performance trends over time
- **Comparison tables**: Side-by-side implementation comparison
- **Statistical analysis**: Outlier detection and confidence intervals

### What to Look For

✅ **Good Signs:**
- Consistent performance across runs (narrow distributions)
- dfir_rs competitive with or outperforming timely/differential
- Linear scaling with input size
- Low variance in measurements

⚠️ **Warning Signs:**
- High variance or outliers (may indicate non-deterministic behavior)
- Performance regressions compared to previous runs
- Unexpected bottlenecks in specific patterns
- Non-linear scaling characteristics

## 🛠️ Troubleshooting

### Build Failures

**Problem**: Compilation errors or dependency resolution failures

**Solutions:**
```bash
# Check Rust version (requires 1.91.1+)
rustc --version

# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Verify git access to main repository
git ls-remote https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
```

### Slow Benchmark Execution

**Problem**: Benchmarks taking too long to complete

**Solutions:**
```bash
# Run in quick mode (fewer iterations)
cargo bench -- --quick

# Run specific benchmark only
cargo bench --bench <name>

# Reduce sample size in benchmark code
# Modify iteration counts or data sizes
```

### Inconsistent Results

**Problem**: High variance or inconsistent measurements

**Solutions:**
- Close other applications to reduce system noise
- Run benchmarks multiple times to establish baseline
- Check for thermal throttling on laptops
- Disable CPU frequency scaling if possible
- Use `--sample-size` flag to increase samples

### Git Dependency Issues

**Problem**: Cannot fetch dependencies from main repository

**Solutions:**
```bash
# Update git credentials
git config --global credential.helper store

# Use cargo with verbose output
cargo bench -vv

# Check network connectivity
ping zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev
```

## 📚 Additional Documentation

For more detailed information:

- **[BENCHMARKS_GUIDE.md](BENCHMARKS_GUIDE.md)** - Comprehensive guide with detailed benchmark descriptions, CI/CD integration, and performance comparison strategies
- **[benches/README.md](benches/README.md)** - Implementation details and code organization
- **[MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)** - History of benchmark migration from main repository

## 🔧 Requirements

- **Rust**: Version 1.91.1 or later (specified in `rust-toolchain.toml`)
- **Git Access**: Required for fetching dependencies from main hydro repository
- **System**: Sufficient memory for running benchmarks (recommend 4GB+ available)

## 📞 Support & Contributing

For questions or issues:

1. Check the troubleshooting section above
2. Review existing benchmarks for implementation patterns
3. Consult the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository documentation
4. Ensure changes follow the existing code organization and architectural patterns

## 🔗 References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/) - Benchmarking framework
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Streaming dataflow framework
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Incremental computation
- [Main Hydro Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Core functionality