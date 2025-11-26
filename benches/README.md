# Timely and Differential-Dataflow Benchmarks

Performance benchmarks for timely-dataflow and differential-dataflow implementations.

## Overview

This package contains 8 benchmarks that measure the performance of various dataflow patterns and operations using timely-dataflow and differential-dataflow frameworks. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain better separation of concerns.

## Benchmarks

### Timely-Dataflow Benchmarks (7)

1. **arithmetic**: Arithmetic operations through dataflow pipeline (20 chained additions)
2. **fan_in**: Multiple streams merging into one (2-way merge)
3. **fan_out**: Single stream splitting into multiple (2-way split)
4. **fork_join**: Fork-join pattern with filtering (20 levels deep)
5. **identity**: Identity transformation (baseline benchmark)
6. **join**: Two-stream join operation
7. **upcase**: String uppercase transformation

### Differential-Dataflow Benchmarks (1)

8. **reachability**: Graph reachability computation using iterative dataflow

## Quick Start

### Run All Benchmarks

```bash
cargo bench -p hydro-deps-benches
```

### Run Specific Benchmark

```bash
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench reachability
```

### Run Specific Test Within Benchmark

```bash
cargo bench -p hydro-deps-benches --bench arithmetic -- timely
cargo bench -p hydro-deps-benches --bench reachability -- differential
```

## Benchmark Details

### Arithmetic (`arithmetic.rs`)

Compares performance of different approaches for chaining arithmetic operations:
- Pipeline: Standard Rust channels with threads
- Raw: Direct vector operations (baseline)
- Timely: Timely-dataflow implementation
- Hydroflow: dfir_rs implementations (requires integration)

**Data**: 1,000,000 integers, 20 operations

### Fan-In (`fan_in.rs`)

Measures stream merging performance:
- Timely: Using `Concatenate` operator
- Hydroflow: Using `union` (requires integration)

**Data**: 2 streams of 1,000,000 integers each

### Fan-Out (`fan_out.rs`)

Measures stream splitting performance:
- Timely: Multiple dataflow outputs
- Hydroflow: Using `tee` (requires integration)

**Data**: 1 stream of 1,000,000 integers split into 2

### Fork-Join (`fork_join.rs`)

Complex pattern with alternating splits and merges:
- Timely: Filter and concatenate operators
- Hydroflow: Interpreted and compiled modes (requires integration)

**Data**: 1,000,000 integers, 20 levels of fork-join

**Note**: Uses code generation in build.rs

### Identity (`identity.rs`)

Baseline benchmark measuring framework overhead:
- Raw: Direct passthrough (minimum possible)
- Pipeline: Channel-based
- Timely: Timely-dataflow
- Hydroflow: Interpreted and compiled (requires integration)

**Data**: 1,000,000 integers, no transformation

### Join (`join.rs`)

Two-stream join operation:
- Timely: Custom join operator with hash tables

**Data**: Configurable stream sizes with overlapping keys

### Upcase (`upcase.rs`)

Simple string transformation:
- Timely: Map operator for uppercase conversion

**Data**: Configurable number of strings

### Reachability (`reachability.rs`)

Iterative graph algorithm:
- Differential: Using `Iterate`, `Join`, and `Threshold`
- Hydroflow: dfir_rs implementation (requires integration)

**Data**: 
- `reachability_edges.txt`: 532KB of graph edges
- `reachability_reachable.txt`: 38KB of expected results

## Requirements

### Minimal Setup (Standalone Mode)

Works out of the box for timely and differential-dataflow benchmarks:

```toml
[dev-dependencies]
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
# ... other dependencies
```

### Full Setup (With Hydroflow Integration)

To enable Hydroflow comparisons, uncomment these in `Cargo.toml`:

```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

See [../INTEGRATION_GUIDE.md](../INTEGRATION_GUIDE.md) for detailed integration instructions.

## Build Script

The `build.rs` script generates code for complex benchmarks:

- **fork_join**: Generates deeply nested fork-join dataflow code

This happens automatically during `cargo build`.

## Test Data

### Reachability Data

- **reachability_edges.txt**: 
  - Format: `source_node target_node` per line
  - Size: ~532KB
  - Source: Synthetic graph for testing

- **reachability_reachable.txt**: 
  - Format: `node` per line
  - Size: ~38KB
  - Contains expected reachable nodes for validation

## Output

### Console Output

Criterion prints results to console:

```
arithmetic/timely       time:   [152.34 ms 153.21 ms 154.15 ms]
                        change: [-2.12% -1.57% -0.99%] (p = 0.00 < 0.05)
                        Performance has improved.
```

### HTML Reports

Detailed reports generated in:

```
target/criterion/<benchmark_name>/report/index.html
```

Open these files in a browser for:
- Detailed statistics
- Performance graphs
- Historical comparisons
- Distribution plots

## Performance Tips

1. **Close other applications** before benchmarking
2. **Run multiple times** to establish stable baseline
3. **Use release mode** (automatic with `cargo bench`)
4. **Disable CPU frequency scaling** for consistency:
   ```bash
   # Linux example
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```

## Comparison with Baselines

### Save a baseline:
```bash
cargo bench -p hydro-deps-benches -- --save-baseline my-baseline
```

### Compare against baseline:
```bash
# Make changes...
cargo bench -p hydro-deps-benches -- --baseline my-baseline
```

## Customizing Benchmarks

### Adjusting Data Sizes

Edit constants at the top of benchmark files:

```rust
const NUM_INTS: usize = 1_000_000;  // Increase/decrease data size
const NUM_OPS: usize = 20;          // Adjust operation count
```

### Adjusting Sample Size

For faster iteration during development:

```bash
cargo bench -p hydro-deps-benches -- --sample-size 10
```

## Troubleshooting

### Build Fails

```bash
cargo clean
cargo build -p hydro-deps-benches -v
```

### Benchmark Takes Too Long

Reduce sample size or data size:

```bash
cargo bench -p hydro-deps-benches --bench reachability -- --sample-size 10
```

### Missing dfir_rs

If you see compilation errors about `dfir_rs`:
- Either comment out Hydroflow variants in benchmarks
- Or set up integration (see [../INTEGRATION_GUIDE.md](../INTEGRATION_GUIDE.md))

## Contributing

To add new benchmarks:

1. Create new `.rs` file in `benches/`
2. Add `[[bench]]` entry to `Cargo.toml`
3. Update this README
4. Update [../BENCHMARK_DETAILS.md](../BENCHMARK_DETAILS.md)

See [../CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.

## References

- **Criterion Documentation**: https://bheisler.github.io/criterion.rs/book/
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Main Repository**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta

## License

Apache-2.0

---

**Word List Attribution**: The `words_alpha.txt` file (if needed for other benchmarks) is from https://github.com/dwyl/english-words
