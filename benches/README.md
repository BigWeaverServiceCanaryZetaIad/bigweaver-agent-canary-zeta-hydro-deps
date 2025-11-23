# Hydro Benchmarks - Timely and Differential-Dataflow Comparisons

This repository contains performance benchmarks comparing dfir_rs (Hydro) with timely and differential-dataflow implementations. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency separation.

## Overview

The benchmarks in this repository provide comprehensive performance comparisons between different dataflow implementations:
- **dfir_rs (Hydro)**: The main implementation being tested
- **Timely Dataflow**: Direct comparison baseline
- **Differential Dataflow**: Another comparison baseline
- **Raw implementations**: Theoretical performance baselines

## Benchmarks

### 1. Arithmetic (`arithmetic.rs`)
**Purpose**: Tests pipeline arithmetic operations with multiple map operations  
**Operations**: 20 sequential `+1` operations on 1,000,000 integers  
**Variants**:
- `arithmetic/pipeline`: Multi-threaded channel-based pipeline
- `arithmetic/raw`: Single-threaded vector-based (theoretical minimum)
- `arithmetic/iter`: Iterator-based without intermediate collection
- `arithmetic/iter-collect`: Iterator-based with collection per operation
- `arithmetic/dfir_rs/compiled`: Compiled dfir_rs implementation
- `arithmetic/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `arithmetic/timely`: Timely dataflow implementation
- `arithmetic/timely/multithreaded`: Multi-threaded timely implementation

**Lines of Code**: ~256

### 2. Fan-In (`fan_in.rs`)
**Purpose**: Tests fan-in pattern where multiple sources merge into one sink  
**Pattern**: Multiple input streams converging to a single output  
**Variants**:
- `fan_in/dfir_rs/compiled`: Compiled dfir_rs implementation
- `fan_in/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `fan_in/timely`: Timely dataflow implementation

**Lines of Code**: ~120

### 3. Fan-Out (`fan_out.rs`)
**Purpose**: Tests fan-out pattern where one source splits to multiple sinks  
**Pattern**: Single input stream diverging to multiple outputs  
**Variants**:
- `fan_out/dfir_rs/compiled`: Compiled dfir_rs implementation
- `fan_out/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `fan_out/timely`: Timely dataflow implementation

**Lines of Code**: ~120

### 4. Fork-Join (`fork_join.rs`)
**Purpose**: Tests fork-join pattern combining fan-out and fan-in  
**Pattern**: Data splits, processes in parallel, then merges  
**Variants**:
- `fork_join/dfir_rs/compiled`: Compiled dfir_rs implementation
- `fork_join/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `fork_join/timely`: Timely dataflow implementation

**Lines of Code**: ~130

### 5. Identity (`identity.rs`)
**Purpose**: Tests simple identity operation (pass-through)  
**Operations**: Minimal overhead baseline measurement  
**Variants**:
- `identity/raw`: Raw vector-based baseline
- `identity/channel`: Channel-based implementation
- `identity/dfir_rs/compiled`: Compiled dfir_rs implementation
- `identity/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `identity/timely`: Timely dataflow implementation

**Lines of Code**: ~220

### 6. Join (`join.rs`)
**Purpose**: Tests join operations between two streams  
**Pattern**: Combining data from two sources based on keys  
**Variants**:
- `join/dfir_rs/compiled`: Compiled dfir_rs implementation
- `join/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `join/differential`: Differential dataflow implementation

**Lines of Code**: ~150

### 7. Reachability (`reachability.rs`)
**Purpose**: Tests graph reachability computation  
**Data**: Real graph data from included text files  
**Files**:
- `reachability_edges.txt`: Graph edges (533 KB)
- `reachability_reachable.txt`: Expected reachable nodes (38 KB)
**Variants**:
- `reachability/dfir_rs/compiled`: Compiled dfir_rs implementation
- `reachability/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `reachability/differential`: Differential dataflow implementation

**Lines of Code**: ~386 + data files

### 8. Upcase (`upcase.rs`)
**Purpose**: Tests string transformation (uppercase conversion)  
**Operations**: String manipulation and transformation  
**Variants**:
- `upcase/dfir_rs/compiled`: Compiled dfir_rs implementation
- `upcase/dfir_rs/scheduled`: Scheduled dfir_rs implementation
- `upcase/timely`: Timely dataflow implementation

**Lines of Code**: ~110

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed with the appropriate toolchain. The benchmarks use:
- Criterion for benchmarking framework
- dfir_rs (from main hydro repository)
- timely and differential-dataflow dependencies

### Run All Benchmarks

```bash
cargo bench -p hydro-benchmarks
```

### Run Specific Benchmark

```bash
# Run only arithmetic benchmarks
cargo bench -p hydro-benchmarks --bench arithmetic

# Run only reachability benchmarks
cargo bench -p hydro-benchmarks --bench reachability
```

### Run Quick Tests (Faster Iteration)

```bash
# Use shorter sample time for faster iteration
CRITERION_SAMPLE_SIZE=10 cargo bench -p hydro-benchmarks
```

## Performance Comparison Workflow

### 1. Baseline Measurement

First, run benchmarks to establish a baseline:

```bash
cargo bench -p hydro-benchmarks -- --save-baseline main
```

### 2. Make Changes

Make your changes to the dfir_rs implementation in the main repository.

### 3. Compare Performance

```bash
cargo bench -p hydro-benchmarks -- --baseline main
```

This will show performance differences compared to the baseline.

### 4. View HTML Reports

Criterion generates HTML reports in `target/criterion/`. Open them in a browser:

```bash
# On Linux
xdg-open target/criterion/report/index.html

# On macOS
open target/criterion/report/index.html
```

## Understanding Results

### Interpreting Output

Criterion provides several statistics:
- **Time**: Mean execution time with confidence intervals
- **Change**: Percentage change from baseline (if comparing)
- **Throughput**: Operations per second (where applicable)

### Example Output

```
arithmetic/dfir_rs/compiled
                        time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-5.2% -4.8% -4.4%] (p = 0.00 < 0.05)
                        Performance has improved.
```

### What to Look For

- **Regression**: Performance decrease (positive change %)
- **Improvement**: Performance increase (negative change %)
- **Significance**: p-value < 0.05 indicates statistically significant change
- **Variance**: Smaller confidence intervals indicate more consistent performance

## Benchmark Methodology

### Data Size Selection

Benchmark data sizes are chosen to:
- Exercise realistic workloads
- Complete in reasonable time (< 10 seconds per variant)
- Minimize measurement noise
- Fit in cache for micro-benchmarks

### Iteration Count

Criterion automatically determines iteration count to:
- Achieve statistical significance
- Maintain consistent runtime
- Reduce measurement variance

### Warm-up Period

All benchmarks include warm-up iterations to:
- Stabilize JIT compilation
- Prime caches
- Reach steady-state performance

## Integration with Main Repository

### Dependency Reference

The benchmarks reference dfir_rs and sinktools from the main hydro repository via git:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = ["debugging"] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

### Local Development

For local development with unpublished changes:

1. Clone both repositories:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Modify `benches/Cargo.toml` to use local paths:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

3. Run benchmarks:
   ```bash
   cargo bench -p hydro-benchmarks
   ```

## Continuous Integration

### CI Configuration

To run benchmarks in CI:

```yaml
- name: Run benchmarks
  run: cargo bench -p hydro-benchmarks --no-fail-fast
```

### Performance Tracking

Consider using tools like:
- **Criterion's HTML reports**: Commit to GitHub Pages for tracking
- **Bencher**: For historical performance tracking
- **Custom scripts**: Parse Criterion JSON output for alerting

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Check Rust version**: Ensure you're using the correct toolchain
   ```bash
   rustc --version
   ```

2. **Update dependencies**:
   ```bash
   cargo update
   ```

3. **Clean build**:
   ```bash
   cargo clean
   cargo build -p hydro-benchmarks
   ```

### Performance Anomalies

If you see unexpected performance results:

1. **Disable CPU frequency scaling**: Use performance governor
   ```bash
   # Linux example
   sudo cpupower frequency-set --governor performance
   ```

2. **Close background applications**: Reduce system load

3. **Check system load**:
   ```bash
   top
   # or
   htop
   ```

4. **Run multiple times**: Verify consistency

### Memory Issues

If benchmarks run out of memory:

1. **Check available memory**:
   ```bash
   free -h
   ```

2. **Run benchmarks individually**:
   ```bash
   cargo bench -p hydro-benchmarks --bench arithmetic
   ```

3. **Adjust benchmark parameters**: Reduce data sizes in benchmark code

## Architecture

### Benchmark Structure

```
benches/
├── Cargo.toml                    # Benchmark package configuration
├── build.rs                      # Build script (if needed)
├── benches/                      # Benchmark implementations
│   ├── arithmetic.rs             # Arithmetic pipeline benchmarks
│   ├── fan_in.rs                 # Fan-in pattern benchmarks
│   ├── fan_out.rs                # Fan-out pattern benchmarks
│   ├── fork_join.rs              # Fork-join pattern benchmarks
│   ├── identity.rs               # Identity operation benchmarks
│   ├── join.rs                   # Join operation benchmarks
│   ├── reachability.rs           # Graph reachability benchmarks
│   ├── reachability_edges.txt    # Graph edges data
│   ├── reachability_reachable.txt# Expected reachable nodes
│   └── upcase.rs                 # String transformation benchmarks
└── README.md                     # This file
```

### Dependencies

- **criterion**: Benchmarking framework with statistical analysis
- **dfir_rs**: Hydro dataflow implementation
- **timely**: Timely dataflow for comparison
- **differential-dataflow**: Differential dataflow for comparison
- **tokio**: Async runtime for dfir_rs
- **rand**: Random data generation
- **static_assertions**: Compile-time assertions

## Contributing

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Implement benchmark using Criterion framework
3. Add benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
4. Document the benchmark in this README
5. Test the benchmark locally
6. Submit a pull request

### Benchmark Guidelines

- **Realistic workloads**: Use realistic data sizes and patterns
- **Multiple variants**: Compare dfir_rs, timely, differential, and raw implementations
- **Clear naming**: Use descriptive names for benchmark functions
- **Documentation**: Comment complex benchmark logic
- **Reproducibility**: Ensure benchmarks are deterministic

## Historical Context

**Migration Date**: November 2025

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to this dedicated repository to:
- Maintain clean dependency separation
- Avoid introducing timely/differential-dataflow dependencies in the main repository
- Keep benchmark code focused and independent
- Improve build times for the main repository
- Allow benchmark evolution without affecting core codebase

The original benchmarks provided comprehensive performance comparisons and this separation allows them to continue serving that purpose while maintaining architectural cleanliness.

## Related Documentation

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- dfir_rs documentation: See main repository
- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## License

Apache-2.0

## Support

For questions or issues:
1. Check this README and related documentation
2. Review the benchmark source code
3. Check the main repository documentation
4. Contact the team for assistance
