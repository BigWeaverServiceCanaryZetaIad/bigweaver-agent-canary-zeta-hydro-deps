# Hydroflow External Framework Benchmarks

This repository contains performance comparison benchmarks between Hydroflow and external dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Purpose

This separate repository keeps external framework dependencies isolated from the main Hydroflow repository while enabling comprehensive performance comparisons. The benchmarks implement equivalent dataflow patterns across frameworks to enable fair comparisons.

## Benchmarks Included

### 1. Identity Benchmark (`identity_comparison`)
Measures throughput of simple pass-through operations with minimal transformation.

**Implementations:**
- Timely Dataflow
- Hydroflow (compiled, scheduled, surface syntax)
- Baseline iterator

**Key Metrics:**
- 20 operations
- 1,000,000 elements
- Pure overhead measurement

### 2. Join Benchmark (`join_comparison`)
Compares hash join performance for combining two data streams.

**Implementations:**
- Timely Dataflow (binary operator with hash tables)
- Hydroflow (surface syntax join)
- Baseline sequential hash join

**Key Metrics:**
- 100,000 elements per stream
- Key-value pairs with String and usize types

### 3. Reachability Benchmark (`reachability_comparison`)
Graph algorithm with iterative fixed-point computation.

**Implementations:**
- Differential Dataflow (iterate with semijoin)
- Timely Dataflow (feedback loops)
- Hydroflow (surface syntax)
- Baseline BFS

**Key Metrics:**
- Real graph data from included files
- Fixed-point iteration
- State management

### 4. Fan-In Benchmark (`fan_in_comparison`)
Merging multiple input streams.

**Implementations:**
- Timely Dataflow (concatenate)
- Hydroflow (union)
- Baseline iterator

**Key Metrics:**
- 10 input streams
- Simple merge operation

### 5. Fan-Out Benchmark (`fan_out_comparison`)
Splitting a stream to multiple consumers.

**Implementations:**
- Timely Dataflow
- Hydroflow (tee)
- Baseline cloning

**Key Metrics:**
- 10 consumers
- Data cloning overhead

### 6. Fork-Join Benchmark (`fork_join_comparison`)
Split, process differently, and merge patterns.

**Implementations:**
- Timely Dataflow
- Hydroflow
- Baseline iterator

**Key Metrics:**
- Even/odd split pattern
- Filtering and merging

### 7. Arithmetic Benchmark (`arithmetic_comparison`)
Computational workload with mathematical operations.

**Implementations:**
- Timely Dataflow
- Hydroflow
- Baseline iterator

**Key Metrics:**
- 20 arithmetic operations per element
- 1,000,000 elements

## Quick Start

### Build the benchmarks
```bash
cargo build --release
```

### Run all benchmarks
```bash
cargo bench
```

### Run specific benchmarks
```bash
# Identity benchmark
cargo bench --bench identity_comparison

# Join benchmark
cargo bench --bench join_comparison

# Reachability benchmark
cargo bench --bench reachability_comparison

# Fan patterns
cargo bench --bench fan_in_comparison
cargo bench --bench fan_out_comparison
cargo bench --bench fork_join_comparison

# Arithmetic
cargo bench --bench arithmetic_comparison
```

## Viewing Results

Criterion generates HTML reports in `target/criterion/`:
```bash
open target/criterion/report/index.html
```

## Framework Versions

- **Timely Dataflow**: `timely-master` 0.13.0-dev.1
- **Differential Dataflow**: `differential-dataflow-master` 0.13.0-dev.1
- **Hydroflow**: Latest from main repository (via path dependency)

## Benchmark Data

The `benches/data/` directory contains:
- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachable nodes from node 1

## Using Results for Comparison

The benchmarks are designed to enable fair comparisons:

1. **Equivalent Operations**: Each framework implements the same logical dataflow
2. **Same Input Data**: All implementations use identical input
3. **Consistent Measurement**: Criterion provides statistical analysis
4. **Multiple Variants**: Hydroflow benchmarks include multiple implementation styles

## Integration with Main Repository

This repository is designed to work alongside the main Hydroflow repository:

```
/projects/sandbox/
  ├── bigweaver-agent-canary-hydro-zeta/     # Main Hydroflow repository
  └── bigweaver-agent-canary-zeta-hydro-deps/ # This benchmark repository
```

The Cargo.toml references Hydroflow components via path dependencies, allowing benchmarks to always use the latest local version for comparisons.

## Performance Considerations

### Framework Strengths

**Differential Dataflow:**
- Excels at incremental computation
- Automatic incrementalization
- Best for iterative algorithms

**Timely Dataflow:**
- Excellent for complex coordination patterns
- Low-level control
- Flexible dataflow construction

**Hydroflow:**
- Multiple programming models (compiled, scheduled, surface)
- Optimized for common patterns
- Good balance of ergonomics and performance

### Interpretation Guidelines

1. **Compare Like with Like**: Compare similar implementation patterns
2. **Consider Use Cases**: Each framework has different strengths
3. **Look at Trends**: Relative performance matters more than absolute numbers
4. **Hardware Dependent**: Results vary by CPU, memory, etc.

## Extending the Benchmarks

To add a new benchmark:

1. Create a new file in `benches/`: `benches/my_benchmark_comparison.rs`
2. Add the benchmark declaration to `Cargo.toml`:
```toml
[[bench]]
name = "my_benchmark_comparison"
harness = false
```
3. Implement equivalent patterns for each framework
4. Run with `cargo bench --bench my_benchmark_comparison`

## References

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow](https://hydro.run/)
- [Criterion.rs](https://bheisler.github.io/criterion.rs/book/)

## License

Apache-2.0 (consistent with Hydroflow project)