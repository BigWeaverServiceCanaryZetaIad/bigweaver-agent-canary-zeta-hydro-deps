# Hydro Microbenchmarks

Comprehensive performance benchmarks comparing Hydro (dfir_rs) with timely-dataflow, differential-dataflow, and raw Rust implementations.

## Quick Start

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark Suite
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

### Run Specific Test Cases
```bash
# Run only tests matching a pattern
cargo bench -p benches --bench reachability -- timely
cargo bench -p benches -- dfir_rs
cargo bench -p benches -- /raw/
```

## Benchmark Descriptions

### arithmetic.rs
**Purpose**: Measures overhead of chaining multiple operations in a dataflow pipeline.

**Implementation**: Applies 20 sequential increment operations to 1,000,000 integers.

**Compared Implementations**:
- `arithmetic/raw` - Raw Rust with Vec operations (baseline)
- `arithmetic/iter` - Rust iterator chain
- `arithmetic/iter-collect` - Iterator with intermediate collections
- `arithmetic/pipeline` - Multi-threaded pipeline with channels
- `arithmetic/timely` - Timely dataflow implementation
- `arithmetic/dfir_rs/compiled` - Hydro compiled dataflow
- `arithmetic/dfir_rs/surface` - Hydro surface syntax

**Key Insights**: Shows framework overhead for linear pipelines. Raw/iter should be fastest, followed by Hydro, then Timely.

---

### fan_in.rs
**Purpose**: Tests merging multiple input streams into a single output stream.

**Implementation**: Merges 10 separate input streams, each with 100,000 elements.

**Compared Implementations**:
- `fan_in/dfir_rs/surface` - Hydro surface syntax
- `fan_in/dfir_rs/compiled` - Hydro compiled
- `fan_in/timely` - Timely dataflow

**Key Insights**: Evaluates union/merge operation efficiency and scheduling overhead.

---

### fan_out.rs
**Purpose**: Tests splitting a single input stream to multiple output streams.

**Implementation**: Splits one input stream to 10 outputs, processing 100,000 elements.

**Compared Implementations**:
- `fan_out/dfir_rs/surface` - Hydro surface syntax
- `fan_out/dfir_rs/compiled` - Hydro compiled
- `fan_out/timely` - Timely dataflow

**Key Insights**: Evaluates tee/broadcast operation efficiency.

---

### fork_join.rs
**Purpose**: Tests fork-join pattern with branching computation paths.

**Implementation**: Forks stream into even/odd filters, then joins back together, repeated 20 times.

**Compared Implementations**:
- `fork_join/dfir_rs` - Hydro implementation
- `fork_join/timely` - Timely dataflow

**Key Insights**: Complex dataflow pattern with branching and merging. Tests scheduler efficiency.

**Note**: Uses build.rs to generate the dataflow graph at compile time.

---

### futures.rs
**Purpose**: Tests async future handling and waker mechanisms in Hydro.

**Implementation**: Schedules and processes futures with manual wakers.

**Compared Implementations**:
- `futures/waker_drop_before_wake` - Waker dropped before wake
- `futures/waker_drop_after_wake` - Waker dropped after wake

**Key Insights**: Evaluates Hydro's async runtime overhead and waker behavior.

---

### identity.rs
**Purpose**: Baseline benchmark for minimal overhead pass-through operation.

**Implementation**: Passes 100,000 elements through with no transformation.

**Compared Implementations**:
- `identity/raw` - Direct Vec iteration
- `identity/pipeline` - Multi-threaded channel pipeline
- `identity/iter` - Iterator chain
- `identity/timely` - Timely dataflow
- `identity/dfir_rs/compiled` - Hydro compiled
- `identity/dfir_rs/surface` - Hydro surface syntax

**Key Insights**: Establishes baseline framework overhead. Raw should be fastest with minimal CPU usage.

---

### join.rs
**Purpose**: Tests hash join operation performance with different data types.

**Implementation**: Joins two streams of 100,000 elements each.

**Compared Implementations**:
- `join/usize/usize/timely` - Timely with usize keys/values
- `join/usize/usize/sol` - Raw Rust implementation with usize
- `join/String/String/timely` - Timely with String keys/values
- `join/String/String/sol` - Raw Rust implementation with String

**Key Insights**: Join is a critical operation in dataflow systems. Tests hash table efficiency and data movement overhead. String operations show allocation costs.

---

### micro_ops.rs
**Purpose**: Measures individual Hydro operator performance in isolation.

**Implementation**: Tests each operator with 10,000 elements.

**Operations Tested**:
- `micro/ops/identity` - Pass-through
- `micro/ops/unique` - Deduplication
- `micro/ops/map` - Transformation
- `micro/ops/flat_map` - One-to-many mapping
- `micro/ops/join` - Two-input join
- `micro/ops/cross_join` - Cartesian product
- `micro/ops/union` - Stream merging
- `micro/ops/difference` - Set difference
- `micro/ops/anti_join` - Anti-join
- `micro/ops/tee` - Stream splitting
- `micro/ops/fold` - Aggregation
- `micro/ops/sort` - Ordering

**Key Insights**: Identifies performance characteristics of individual operators. Useful for understanding which operations are expensive.

---

### reachability.rs
**Purpose**: Graph reachability algorithm - a classic dataflow benchmark.

**Implementation**: Computes reachable nodes from a starting node in a directed graph.

**Data**: 
- Graph edges from `reachability_edges.txt`
- Expected results from `reachability_reachable.txt`

**Compared Implementations**:
- `reachability/raw` - Raw Rust with HashMap
- `reachability/timely` - Timely dataflow with iteration
- `reachability/differential` - Differential dataflow (incremental)
- `reachability/dfir_rs/surface` - Hydro surface syntax
- `reachability/dfir_rs/compiled` - Hydro compiled

**Key Insights**: Tests iterative computation and fixed-point algorithms. Differential should excel with incremental updates. Important real-world use case.

---

### symmetric_hash_join.rs
**Purpose**: Tests symmetric hash join with various data distributions.

**Implementation**: Joins with different match selectivities.

**Test Cases**:
- `symmetric_hash_join/no_match` - No matching keys (worst case)
- `symmetric_hash_join/all_match` - All keys match (best case)

**Key Insights**: Shows join performance under different selectivity conditions. Hash table behavior under different loads.

---

### upcase.rs
**Purpose**: String transformation benchmark simulating text processing.

**Implementation**: Converts strings to uppercase, processing word list.

**Data**: Word list from `words_alpha.txt` (370,000+ English words)

**Compared Implementations**:
- `upcase/raw` - Raw Rust with Vec and string operations
- `upcase/timely` - Timely dataflow
- `upcase/differential` - Differential dataflow
- `upcase/dfir_rs/surface` - Hydro surface syntax
- `upcase/dfir_rs/compiled` - Hydro compiled

**Key Insights**: Real-world text processing scenario. Tests string handling overhead in dataflow frameworks.

---

### words_diamond.rs
**Purpose**: Diamond-shaped dataflow pattern on word processing.

**Implementation**: Splits word stream, processes through two paths (vowel/consonant counting), then joins.

**Data**: Word list from `words_alpha.txt`

**Compared Implementations**:
- `words_diamond/raw` - Raw Rust
- `words_diamond/timely` - Timely dataflow
- `words_diamond/dfir_rs/compiled` - Hydro compiled
- `words_diamond/dfir_rs/surface` - Hydro surface syntax

**Key Insights**: Tests complex dataflow topology with parallel processing paths. Common pattern in stream processing.

## Understanding Results

### Criterion Output

Criterion provides detailed statistical analysis:

```
arithmetic/raw          time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-2.3% -1.5% -0.7%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Components**:
- `time:` - [lower bound, estimate, upper bound] with 95% confidence
- `change:` - Comparison to previous run (if baseline exists)
- `p =` - Statistical significance (< 0.05 is significant)

### HTML Reports

Open `target/criterion/report/index.html` for:
- Interactive performance plots
- Historical trend analysis
- Statistical distribution charts
- Outlier detection
- Comparison between implementations

### Comparing Implementations

Expected performance hierarchy (fastest to slowest):
1. **Raw Rust** - Optimal compiler-generated code
2. **Iterator** - Zero-cost abstractions
3. **Hydro Compiled** - Low-level dataflow compilation
4. **Hydro Surface** - High-level syntax (small overhead)
5. **Timely/Differential** - Production frameworks with scheduling overhead

**Note**: Differential may outperform others for incremental/streaming scenarios.

## Performance Analysis Tips

### 1. Identify Bottlenecks
```bash
# Run with profiling
cargo bench -p benches --bench reachability -- --profile-time=10
```

### 2. Compare Specific Implementations
```bash
# Compare only raw vs hydro
cargo bench -p benches --bench arithmetic -- /raw/
cargo bench -p benches --bench arithmetic -- /dfir_rs/
```

### 3. Analyze Variance
High variance indicates:
- System interference (background processes)
- Non-deterministic behavior
- Thermal throttling
- Memory pressure

### 4. Save and Compare Baselines
```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline before-optimization

# Make changes...

# Compare against baseline
cargo bench -p benches -- --baseline before-optimization
```

### 5. Quick Iteration During Development
```bash
# Reduce sample size for faster feedback
cargo bench -p benches -- --sample-size 10 --warm-up-time 1
```

## Benchmark Configuration

### Adjusting Workload Size

Some benchmarks define constants that can be modified:
- `arithmetic.rs`: `NUM_OPS = 20`, `NUM_INTS = 1_000_000`
- `join.rs`: `NUM_INTS = 100_000`
- `micro_ops.rs`: `NUM_INTS = 10_000`

Edit the source files to test different workload sizes.

### Criterion Configuration

Edit `Cargo.toml` `[dev-dependencies]` to modify Criterion features:
```toml
criterion = { version = "0.5.0", features = [
    "async_tokio",      # Enable async benchmark support
    "html_reports",     # Generate HTML reports
    # "csv_output",     # Export to CSV
    # "plotters",       # Advanced plotting
] }
```

## Troubleshooting

### Build Failures

**Problem**: Cannot find dfir_rs or sinktools
```
error: failed to load manifest for dependency `dfir_rs`
```

**Solution**: Ensure the main Hydro repository is at the correct relative path:
```bash
ls ../../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

---

**Problem**: Build script fails
```
error: failed to run custom build command for `benches`
```

**Solution**: Check `build.rs` output:
```bash
cargo clean
cargo build -p benches --verbose
```

---

### Runtime Errors

**Problem**: Missing data files
```
thread 'main' panicked at 'cannot load reachability_edges.txt'
```

**Solution**: Data files are embedded via `include_bytes!` at compile time. Rebuild:
```bash
cargo clean -p benches
cargo bench -p benches
```

---

### Performance Issues

**Problem**: Benchmarks taking too long

**Solutions**:
1. Reduce sample size: `cargo bench -- --sample-size 10`
2. Run specific benchmarks only: `cargo bench --bench micro_ops`
3. Skip slow benchmarks: `cargo bench -- --skip reachability`

---

**Problem**: High variance in results

**Solutions**:
1. Close background applications
2. Disable CPU frequency scaling
3. Run multiple times and average
4. Use a dedicated benchmark machine

## Data Sources

- **words_alpha.txt**: English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- **reachability_edges.txt**: Graph edge list for reachability tests (custom generated)
- **reachability_reachable.txt**: Expected reachable nodes (custom generated)

## Adding New Benchmarks

### Template
```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn benchmark_my_feature(c: &mut Criterion) {
    c.bench_function("my_feature/implementation", |b| {
        b.iter(|| {
            // Your benchmark code here
        });
    });
}

criterion_group!(my_benchmarks, benchmark_my_feature);
criterion_main!(my_benchmarks);
```

### Steps
1. Create `benches/benches/my_benchmark.rs`
2. Add entry to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Run: `cargo bench -p benches --bench my_benchmark`

### Best Practices
- Include multiple implementation variants (raw, timely, hydro)
- Use meaningful workload sizes
- Add documentation comments explaining the benchmark
- Use `black_box()` to prevent compiler optimization
- Include setup/teardown outside timing loop
- Verify correctness before benchmarking performance

## References

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/) - Comprehensive benchmarking guide
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Reference dataflow implementation
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Incremental computation framework
