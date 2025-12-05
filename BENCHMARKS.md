# Benchmark Documentation

This document provides detailed information about each benchmark in this repository.

## Overview

All benchmarks in this repository compare the performance of Hydro (dfir_rs) implementations against Timely Dataflow and/or Differential Dataflow implementations. These benchmarks were moved from the main Hydro repository to avoid adding timely and differential-dataflow as dependencies to the core codebase.

## Benchmark Descriptions

### arithmetic

**File:** `benches/benches/arithmetic.rs`

Benchmarks basic arithmetic operations on streaming data. Compares Hydro and Timely implementations for operations like addition, multiplication, and other mathematical computations on data streams.

### fan_in

**File:** `benches/benches/fan_in.rs`

Tests the fan-in pattern where multiple source streams are merged into a single output stream. This is a common pattern in dataflow systems for aggregating data from multiple sources.

**Benchmark variants:**
- Hydro implementation
- Timely implementation

### fan_out

**File:** `benches/benches/fan_out.rs`

Tests the fan-out pattern where a single source stream is distributed to multiple downstream operators. Useful for understanding the overhead of duplicating data across multiple processing paths.

**Benchmark variants:**
- Hydro implementation
- Timely implementation

### fork_join

**File:** `benches/benches/fork_join.rs`

Benchmarks the fork-join pattern where data is split, processed in parallel paths, and then recombined. This pattern is fundamental to parallel processing systems.

**Benchmark variants:**
- Hydro implementation
- Timely implementation

### identity

**File:** `benches/benches/identity.rs`

Tests the overhead of simple pass-through operations. This benchmark helps measure the baseline performance overhead of the dataflow framework itself.

**Benchmark variants:**
- Hydro implementation
- Timely implementation

### join

**File:** `benches/benches/join.rs`

Benchmarks join operations between two data streams. Join is a critical operation in many data processing applications.

**Benchmark variants:**
- Timely implementation

### reachability

**File:** `benches/benches/reachability.rs`

Tests graph reachability algorithms using iterative computation. This benchmark exercises the incremental and iterative capabilities of the dataflow systems, particularly using Differential Dataflow.

**Data files:**
- `reachability_edges.txt` - Graph edge definitions
- `reachability_reachable.txt` - Expected reachable nodes

**Benchmark variants:**
- Hydro implementation
- Differential Dataflow implementation

### upcase

**File:** `benches/benches/upcase.rs`

Benchmarks string transformation operations (converting to uppercase). Tests the performance of map operations on string data.

**Data file:**
- `words_alpha.txt` - List of English words for transformation

**Benchmark variants:**
- Timely implementation

## Running Benchmarks

### Run all benchmarks

```bash
cargo bench
```

### Run a specific benchmark

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench reachability
cargo bench --bench fan_in
```

### Run benchmarks with specific parameters

Some benchmarks accept parameters through environment variables or command-line arguments. Check the individual benchmark source files for details.

## Interpreting Results

Benchmark results are generated using the [Criterion](https://github.com/bheisler/criterion.rs) framework. Results include:

- **Time per iteration**: The average time to complete one iteration of the benchmark
- **Throughput**: Operations per second (where applicable)
- **Comparison**: When available, comparison between different implementations

Results are saved to `target/criterion/` and include:
- Statistical analysis
- HTML reports
- Performance graphs
- Regression analysis

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Implement the benchmark using Criterion
3. Add a `[[bench]]` entry to `benches/Cargo.toml`
4. Update this documentation

Example benchmark structure:

```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydro", |b| {
        b.iter(|| {
            // Benchmark code here
        })
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

## Dependencies

These benchmarks require:

- **timely** (timely-master): Core Timely Dataflow system
- **differential-dataflow** (differential-dataflow-master): Differential Dataflow system
- **dfir_rs**: Hydro's dataflow implementation (fetched from main repository)
- **criterion**: Benchmarking framework

## Performance Considerations

When running benchmarks:

1. **System Load**: Ensure minimal background processes for accurate results
2. **CPU Scaling**: Disable CPU frequency scaling for consistent measurements
3. **Warm-up**: Criterion automatically performs warm-up iterations
4. **Statistical Significance**: Multiple runs are performed to ensure statistical validity

## Continuous Integration

These benchmarks can be integrated into CI pipelines to:

- Track performance regressions
- Compare performance across versions
- Generate performance reports

## Related Documentation

- [Criterion User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
