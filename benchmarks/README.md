# Timely and Differential-Dataflow Benchmarks

Performance benchmarks comparing timely and differential-dataflow implementations with baseline Rust implementations.

## Overview

This directory contains comparative benchmarks that measure:
- **Timely Dataflow** - Low-level dataflow framework performance
- **Differential Dataflow** - Incremental computation framework performance
- **Baseline implementations** - Raw Rust, iterators, channels for comparison

## Quick Start

```bash
# From repository root
cargo bench -p hydro-deps-benchmarks

# Run specific benchmark
cargo bench -p hydro-deps-benchmarks --bench arithmetic

# Quick run (fewer samples)
cargo bench -p hydro-deps-benchmarks -- --quick
```

Or use the convenience script:

```bash
# From repository root
./run_benchmarks.sh all
./run_benchmarks.sh arithmetic
./run_benchmarks.sh quick
```

## Available Benchmarks

| Benchmark | Description | Key Metrics |
|-----------|-------------|-------------|
| `arithmetic` | Pipeline arithmetic operations | Framework overhead, operator chaining |
| `fan_in` | Multiple input stream merging | Synchronization, multi-input handling |
| `fan_out` | Single stream broadcasting | Data duplication, parallel consumers |
| `fork_join` | Parallel fork/join patterns | Work distribution, synchronization |
| `identity` | Identity/passthrough operations | Base framework overhead |
| `join` | Join operations | Hash join efficiency, memory usage |
| `reachability` | Graph reachability (iterative) | Iterative computation, state management |
| `upcase` | String transformations | String processing, allocations |

## Directory Structure

```
benchmarks/
├── Cargo.toml              # Package configuration with dependencies
├── README.md               # This file
└── benches/
    ├── arithmetic.rs       # Arithmetic pipeline benchmark
    ├── fan_in.rs          # Fan-in benchmark
    ├── fan_out.rs         # Fan-out benchmark
    ├── fork_join.rs       # Fork-join benchmark
    ├── identity.rs        # Identity benchmark
    ├── join.rs            # Join benchmark
    ├── reachability.rs    # Graph reachability benchmark
    ├── upcase.rs          # String transformation benchmark
    └── data/
        ├── reachability_edges.txt      # Test graph edges
        └── reachability_reachable.txt  # Expected reachability results
```

## Dependencies

Key dependencies (see `Cargo.toml` for full list):

- **criterion** (v0.5.0) - Benchmarking framework with statistical analysis
- **timely** (timely-master v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1) - Incremental computation

## Running Benchmarks

### All Benchmarks

```bash
cargo bench -p hydro-deps-benchmarks
```

### Individual Benchmarks

```bash
cargo bench -p hydro-deps-benchmarks --bench arithmetic
cargo bench -p hydro-deps-benchmarks --bench identity
cargo bench -p hydro-deps-benchmarks --bench reachability
```

### Multiple Specific Benchmarks

```bash
cargo bench -p hydro-deps-benchmarks --bench arithmetic --bench identity
```

### Quick Mode (Faster Iteration)

```bash
cargo bench -p hydro-deps-benchmarks -- --quick
```

### Save Baseline for Comparison

```bash
# Save current performance as baseline
cargo bench -p hydro-deps-benchmarks -- --save-baseline my-baseline

# Run benchmarks and compare against baseline
cargo bench -p hydro-deps-benchmarks -- --baseline my-baseline
```

## Viewing Results

### Terminal Output

Criterion outputs statistical summaries:

```
arithmetic/timely       time:   [45.231 ms 45.789 ms 46.421 ms]
                        thrpt:  [21.549 Melem/s 21.851 Melem/s 22.120 Melem/s]
```

### HTML Reports

Detailed HTML reports with visualizations:

```bash
# Reports are automatically generated in:
target/criterion/report/index.html

# Open in browser
open target/criterion/report/index.html
```

Reports include:
- Violin plots showing measurement distribution
- Line charts showing performance trends
- Statistical analysis (mean, median, std dev)
- Comparison with previous runs

## Benchmark Details

### Arithmetic (`arithmetic.rs`)

Tests overhead of pipeline operations with arithmetic.

**Implementations:**
- `babyflow` - Early prototype
- `pipeline` - Channel-based multi-threaded
- `raw copy` - Vector-based baseline
- `iter` - Iterator-based
- `timely` - Timely dataflow

**Configuration:**
- Operations: 20 chained map operations
- Data: 1,000,000 integers

### Fan In (`fan_in.rs`)

Tests merging multiple input streams.

**Implementations:**
- `timely` - Timely concat/merge operators
- `babyflow` - Prototype implementation

**Use case:** Aggregating data from multiple sources

### Fan Out (`fan_out.rs`)

Tests broadcasting to multiple outputs.

**Implementations:**
- `timely` - Timely broadcast operators
- `babyflow` - Prototype implementation

**Use case:** Distributing data to multiple consumers

### Fork Join (`fork_join.rs`)

Tests parallel fork/join patterns.

**Implementations:**
- `timely` - Fork/join with timely operators
- `babyflow` - Prototype implementation
- Baseline - Raw threading

**Use case:** MapReduce-style parallel processing

### Identity (`identity.rs`)

Tests minimal framework overhead with passthrough.

**Implementations:**
- `babyflow` - Prototype passthrough
- `pipeline` - Channel-based
- `raw copy` - Vector baseline
- `timely` - Timely identity

**Use case:** Measuring base framework "tax"

### Join (`join.rs`)

Tests join operations between streams.

**Implementations:**
- `timely` - Timely join operators

**Use case:** Database-style joins, stream correlation

### Reachability (`reachability.rs`)

Tests graph reachability with iterative computation.

**Implementations:**
- `timely` - Feedback loops and iteration
- `hydroflow` - Hydroflow graph operators (if available)

**Data:** 
- Input edges: `benches/data/reachability_edges.txt`
- Expected results: `benches/data/reachability_reachable.txt`

**Use case:** Graph algorithms, network analysis

### Upcase (`upcase.rs`)

Tests string transformation operations.

**Implementations:**
- `timely` - Map operator
- `babyflow` - Prototype transformation
- Baseline - Raw iterator

**Use case:** Text processing, data normalization

## Performance Analysis

### Understanding Results

Compare implementations to understand trade-offs:

1. **Baseline performance** - Theoretical minimum (raw Rust)
2. **Framework overhead** - Cost of abstraction
3. **Throughput scaling** - Performance at different data volumes

### Optimization Tips

If performance is lower than expected:

1. **Check data sizes** - Too small may not show realistic characteristics
2. **Profile with flamegraph** - `cargo flamegraph --bench <name>`
3. **Review operator usage** - Some operators have better alternatives
4. **Consider batch sizes** - Larger batches often more efficient
5. **Check for unnecessary clones** - Data copying can dominate

### Comparing with DFIR

To compare with DFIR implementations in the main repository:

1. Run benchmarks here: `cargo bench -p hydro-deps-benchmarks`
2. Run main repo: `cd ../bigweaver-agent-canary-hydro-zeta && cargo bench -p benches`
3. Compare reports in `target/criterion/`

See [PERFORMANCE_COMPARISON.md](../PERFORMANCE_COMPARISON.md) for detailed guidance.

## Adding New Benchmarks

To add a new benchmark:

1. **Create benchmark file** in `benches/`:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn benchmark_name(c: &mut Criterion) {
       c.bench_function("benchmark_name/timely", |b| {
           b.iter(|| {
               // Implementation
           });
       });
   }
   
   criterion_group!(benches, benchmark_name);
   criterion_main!(benches);
   ```

2. **Add to `Cargo.toml`**:
   ```toml
   [[bench]]
   name = "benchmark_name"
   harness = false
   ```

3. **Add data files** (if needed) to `benches/data/`

4. **Document** in this README and `../BENCHMARKS.md`

5. **Test**: `cargo bench -p hydro-deps-benchmarks --bench benchmark_name`

## Troubleshooting

### Compilation Errors

**Missing dependencies:**
```bash
# Ensure dependencies are available
cargo update
cargo check -p hydro-deps-benchmarks
```

**Version conflicts:**
- Check `Cargo.toml` versions match requirements
- Update `Cargo.lock` if needed

### Runtime Issues

**Benchmark timeout:**
- Reduce data size for testing
- Use `--quick` flag
- Check for infinite loops

**Inconsistent results:**
- Close other applications
- Run multiple times to verify
- Check system load: `top` or `htop`

### Data File Issues

**Cannot find data files:**
- Ensure data files are in `benches/data/`
- Check `include_bytes!()` paths are correct
- Verify files are committed to git

## Documentation

For more detailed information:

- **[../BENCHMARKS.md](../BENCHMARKS.md)** - Comprehensive benchmark documentation
- **[../PERFORMANCE_COMPARISON.md](../PERFORMANCE_COMPARISON.md)** - Performance comparison guide
- **[../README.md](../README.md)** - Repository overview

## References

- [Criterion.rs](https://bheisler.github.io/criterion.rs/book/) - Benchmarking framework documentation
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Timely framework
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Differential computation
