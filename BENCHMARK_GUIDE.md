# Benchmark Guide

This guide provides comprehensive information about the benchmarks in this repository, including setup, execution, and performance comparison capabilities.

## Overview

This repository contains performance benchmarks that compare implementations across three dataflow systems:
- **Hydro (dfir_rs)**: The primary implementation
- **Timely Dataflow**: Comparison baseline
- **Differential Dataflow**: Advanced dataflow comparison

## Prerequisites

### Rust Toolchain

Ensure you have Rust installed with the version specified in `rust-toolchain.toml`:

```bash
rustup show
```

### Dependencies

All dependencies are managed through Cargo. The main dependencies include:
- `criterion`: Benchmarking framework with statistical analysis
- `timely-master`: Timely dataflow library
- `differential-dataflow-master`: Differential dataflow library
- `dfir_rs`: Hydro runtime (from main repository)

## Available Benchmarks

### 1. Arithmetic (`arithmetic.rs`)
**Purpose**: Tests arithmetic operations and data transformation pipelines.

**What it measures**:
- Pipeline throughput with chained operations
- Raw data copying performance
- Hydro vs Timely comparison for arithmetic chains

**Run**:
```bash
cargo bench -p benches --bench arithmetic
```

### 2. Fan-In (`fan_in.rs`)
**Purpose**: Tests merging multiple input streams into one.

**What it measures**:
- Union operation performance
- Multiple source handling
- Stream merging efficiency

**Run**:
```bash
cargo bench -p benches --bench fan_in
```

### 3. Fan-Out (`fan_out.rs`)
**Purpose**: Tests splitting one stream into multiple outputs.

**What it measures**:
- Tee operation performance
- Stream duplication overhead
- Multiple consumer handling

**Run**:
```bash
cargo bench -p benches --bench fan_out
```

### 4. Fork-Join (`fork_join.rs`)
**Purpose**: Tests fork-join parallel computation patterns.

**What it measures**:
- Parallel branching and merging
- Filter operations in branches
- Union operations for joining

**Run**:
```bash
cargo bench -p benches --bench fork_join
```

**Note**: This benchmark uses generated code from `build.rs`.

### 5. Identity (`identity.rs`)
**Purpose**: Tests identity transformations and no-op pipelines.

**What it measures**:
- Baseline overhead of dataflow systems
- Identity map performance
- Minimal transformation cost

**Run**:
```bash
cargo bench -p benches --bench identity
```

### 6. Join (`join.rs`)
**Purpose**: Tests join operations on keyed streams.

**What it measures**:
- Hash join performance
- Keyed stream operations
- Join operator efficiency

**Run**:
```bash
cargo bench -p benches --bench join
```

### 7. Micro Operations (`micro_ops.rs`)
**Purpose**: Microbenchmarks of individual operators.

**What it measures**:
- Individual operator overhead
- Operator composition costs
- Fine-grained performance characteristics

**Run**:
```bash
cargo bench -p benches --bench micro_ops
```

### 8. Reachability (`reachability.rs`)
**Purpose**: Tests graph reachability algorithms.

**What it measures**:
- Fixed-point computation performance
- Recursive dataflow patterns
- Graph algorithm efficiency

**Data files**:
- `reachability_edges.txt`: Graph edge data
- `reachability_reachable.txt`: Expected reachable nodes

**Run**:
```bash
cargo bench -p benches --bench reachability
```

### 9. Symmetric Hash Join (`symmetric_hash_join.rs`)
**Purpose**: Tests symmetric hash join implementations.

**What it measures**:
- Symmetric join performance
- Hash table operations
- Join symmetry overhead

**Run**:
```bash
cargo bench -p benches --bench symmetric_hash_join
```

### 10. Upcase (`upcase.rs`)
**Purpose**: Tests string transformation operations.

**What it measures**:
- String manipulation overhead
- Map operations on strings
- Data transformation performance

**Run**:
```bash
cargo bench -p benches --bench upcase
```

### 11. Words Diamond (`words_diamond.rs`)
**Purpose**: Tests diamond-shaped dataflow patterns on word data.

**What it measures**:
- Complex dataflow patterns
- Multiple path convergence
- Filter and union operations

**Data file**: `words_alpha.txt` (English word list)

**Run**:
```bash
cargo bench -p benches --bench words_diamond
```

### 12. Futures (`futures.rs`)
**Purpose**: Tests async futures-based implementations.

**What it measures**:
- Async dataflow performance
- Futures integration overhead
- Tokio runtime interaction

**Run**:
```bash
cargo bench -p benches --bench futures
```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench <benchmark_name>
```

### Run with Custom Parameters
```bash
# Run with smaller sample size
cargo bench -p benches --bench reachability -- --sample-size 50

# Run only tests matching a pattern
cargo bench -p benches --bench arithmetic -- pipeline

# Disable outlier detection
cargo bench -p benches --bench micro_ops -- --nooutliers
```

### Baseline Comparisons

Save a baseline:
```bash
cargo bench -p benches -- --save-baseline before-changes
```

Compare against baseline:
```bash
cargo bench -p benches -- --baseline before-changes
```

## Performance Comparison

Each benchmark typically includes implementations for:
1. **Hydro (dfir_rs)**: Using `dfir_syntax!` macro
2. **Timely**: Using timely dataflow operators
3. **Differential**: Using differential dataflow operators (where applicable)

Results show:
- Throughput (operations/second)
- Latency (time per operation)
- Statistical confidence intervals
- Performance comparisons between implementations

## Understanding Results

### Criterion Output

Criterion generates:
- **HTML Reports**: `target/criterion/<benchmark_name>/report/index.html`
- **Plots**: Throughput and latency visualizations
- **Statistics**: Mean, median, standard deviation
- **Change Detection**: Automatic regression detection

### Interpreting Results

Look for:
- **Relative Performance**: How Hydro compares to Timely/Differential
- **Scalability**: Performance with different data sizes
- **Consistency**: Low variance indicates stable performance
- **Regressions**: Significant performance changes between runs

## Configuration

### Benchmark Parameters

Edit constants in benchmark files:
- `NUM_OPS`: Number of operations in pipeline
- `NUM_INTS`: Number of data items processed
- `BATCH_SIZE`: Batch processing size

### Criterion Configuration

Criterion is configured with:
- `async_tokio`: Async benchmark support
- `html_reports`: HTML report generation
- Default sample size: 100
- Warm-up time: 3 seconds
- Measurement time: 5 seconds

## Troubleshooting

### Compilation Issues

If benchmarks fail to compile:
1. Verify Rust toolchain: `rustup show`
2. Update dependencies: `cargo update`
3. Clean build: `cargo clean && cargo build`

### Performance Anomalies

If results seem unusual:
1. Ensure machine is not under load
2. Run with larger sample size
3. Disable other applications
4. Check for thermal throttling

### Missing Data Files

If reachability or words benchmarks fail:
- Verify `reachability_edges.txt`, `reachability_reachable.txt`, and `words_alpha.txt` exist
- Files should be in `benches/benches/` directory

## Integration with CI

To run benchmarks in CI:
```bash
# Run with reduced sample size for faster execution
cargo bench -p benches -- --sample-size 10 --quick

# Generate JSON output for parsing
cargo bench -p benches -- --output-format json
```

## Contributing

When adding new benchmarks:

1. **Create benchmark file**: `benches/benches/my_benchmark.rs`
2. **Add to Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. **Follow patterns**:
   - Include Hydro, Timely, and Differential implementations
   - Use criterion for measurement
   - Document what the benchmark measures
4. **Test locally**:
   ```bash
   cargo bench -p benches --bench my_benchmark
   ```
5. **Update this guide**: Add documentation for the new benchmark

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
