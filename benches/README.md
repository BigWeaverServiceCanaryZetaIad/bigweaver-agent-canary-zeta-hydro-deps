# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for timely-dataflow and differential-dataflow that were moved from the main Hydro repository to avoid including these dependencies in the main codebase.

## Overview

These benchmarks compare the performance of different dataflow implementations:
- **Timely-dataflow**: A low-level dataflow framework
- **Differential-dataflow**: An incremental computation framework built on timely
- **DFIR/Hydro**: The Hydro dataflow implementations for comparison

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p hydro-timely-differential-benches
```

### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p hydro-timely-differential-benches --bench reachability

# Run multiple specific benchmarks
cargo bench -p hydro-timely-differential-benches --bench arithmetic --bench join
```

### Run with Filters

```bash
# Run only benchmarks matching a pattern
cargo bench -p hydro-timely-differential-benches -- "timely"

# Run only dfir comparisons
cargo bench -p hydro-timely-differential-benches -- "dfir"
```

## Benchmark Descriptions

### arithmetic.rs
**Purpose**: Measures performance of basic arithmetic operations  
**Implementations**: Timely-dataflow + DFIR comparison  
**Operations**: Addition, multiplication, and other numeric operations on data streams

### fan_in.rs
**Purpose**: Tests fan-in pattern where multiple streams merge into one  
**Implementations**: Timely-dataflow + DFIR comparison  
**Pattern**: Multiple input streams → Single output stream

### fan_out.rs
**Purpose**: Tests fan-out pattern where one stream splits into multiple  
**Implementations**: Timely-dataflow + DFIR comparison  
**Pattern**: Single input stream → Multiple output streams

### fork_join.rs
**Purpose**: Benchmarks fork-join parallelism pattern  
**Implementations**: Timely-dataflow + DFIR comparison  
**Pattern**: Split computation, process in parallel, then rejoin results  
**Note**: Uses generated DFIR code via `build.rs`

### identity.rs
**Purpose**: Measures overhead of identity operations (pass-through)  
**Implementations**: Timely-dataflow + DFIR comparison  
**Use case**: Baseline for understanding framework overhead

### join.rs
**Purpose**: Tests join operations on two data streams  
**Implementations**: Timely-dataflow only  
**Operations**: Relational-style joins between datasets

### reachability.rs
**Purpose**: Graph reachability computation (transitive closure)  
**Implementations**: Timely-dataflow, Differential-dataflow + DFIR comparison  
**Data files**: 
- `reachability_edges.txt` - Graph edge list
- `reachability_reachable.txt` - Expected reachable nodes
**Use case**: Tests iterative computation and fixpoint algorithms

### upcase.rs
**Purpose**: String transformation operations  
**Implementations**: Timely-dataflow only  
**Operations**: Convert strings to uppercase

## Performance Comparison

### Comparing with DFIR Benchmarks

To compare performance between implementations:

1. **Run benchmarks from this repository**:
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-timely-differential-benches
   ```

2. **Run DFIR-only benchmarks from main repository**:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Analyze results**:
   - Results are stored in `target/criterion/` in each repository
   - HTML reports: `target/criterion/*/report/index.html`
   - CSV data: `target/criterion/*/base/estimates.json`

### Understanding Benchmark Output

Criterion provides:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Elements processed per second (when applicable)
- **Change**: Comparison with previous runs (if available)

Example output:
```
reachability/timely  time: [1.234 ms 1.245 ms 1.256 ms]
                     change: [-2.3% +0.1% +2.5%] (p = 0.95)
```

## Build Configuration

### build.rs
The `build.rs` script generates DFIR code for the `fork_join` benchmark. It creates a file `fork_join_20.hf` with 20 operations, which is then included in the benchmark.

**Generated code pattern**:
```rust
dfir_syntax! {
    a0 = source_iter(0..NUM_INTS) -> tee();
    a1 = union() -> tee();
    a0 -> filter(|x| x % 2 == 0) -> a1;
    a0 -> filter(|x| x % 2 == 1) -> a1;
    // ... continues for NUM_OPS
    a20 = union() -> for_each(|x| { black_box(x); });
}
```

## Data Files

### reachability_edges.txt
Format: Space-separated pairs of node IDs (one edge per line)
```
1 2
1 3
2 4
```

### reachability_reachable.txt
Format: One node ID per line (nodes reachable from a starting node)
```
1
2
3
4
```

## Troubleshooting

### Build Failures

If you encounter build errors:

1. **Check Rust version**: Ensure you have Rust 1.91.1 or later
   ```bash
   rustc --version
   ```

2. **Clean and rebuild**:
   ```bash
   cargo clean
   cargo build -p hydro-timely-differential-benches
   ```

3. **Update dependencies**:
   ```bash
   cargo update
   ```

### Benchmark Issues

If benchmarks produce unexpected results:

1. **Check system load**: Close other applications for consistent results
2. **Run multiple times**: Criterion automatically runs multiple iterations
3. **Compare with previous results**: Check if changes are within expected variance

## Contributing

When adding new benchmarks:

1. Add the `.rs` file to `benches/benches/`
2. Update `Cargo.toml` to include the new benchmark:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Update this README with benchmark description
4. Add any required data files to `benches/benches/`
5. Run `cargo fmt` and `cargo clippy` before committing

## Related Documentation

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
