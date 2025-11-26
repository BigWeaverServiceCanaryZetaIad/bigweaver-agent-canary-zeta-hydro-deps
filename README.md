# Hydro Dependencies Benchmarks

This repository contains benchmarks for timely and differential-dataflow that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository as part of a dependency cleanup initiative. These benchmarks compare Hydro's dataflow implementation with timely and differential-dataflow frameworks.

## Overview

This dedicated benchmarks repository houses performance comparison benchmarks that depend on:
- **timely** - A low-latency data-parallel dataflow system
- **differential-dataflow** - An implementation of differential dataflow over timely dataflow

By separating these benchmarks from the main repository, we:
- Reduce dependency footprint in the main codebase
- Improve build times for the main project
- Maintain the ability to run performance comparisons
- Keep the main architecture cleaner

## Repository Structure

```
.
├── Cargo.toml                         # Package configuration with benchmark dependencies
├── build.rs                           # Build script for generating benchmark code
├── benches/                           # Benchmark implementations
│   ├── arithmetic.rs                  # Arithmetic operations benchmarks (timely)
│   ├── fan_in.rs                      # Fan-in pattern benchmarks (timely)
│   ├── fan_out.rs                     # Fan-out pattern benchmarks (timely)
│   ├── fork_join.rs                   # Fork-join pattern benchmarks (timely)
│   ├── identity.rs                    # Identity transformation benchmarks (timely)
│   ├── join.rs                        # Join operation benchmarks (timely)
│   ├── upcase.rs                      # String uppercase benchmarks (timely)
│   ├── reachability.rs                # Graph reachability benchmarks (timely + differential)
│   ├── reachability_edges.txt         # Test data for reachability benchmark
│   ├── reachability_reachable.txt     # Expected results for reachability benchmark
│   └── words_alpha.txt                # Word list for text processing benchmarks
└── README.md                          # This file
```

## Benchmarks

### Timely-Dependent Benchmarks

These benchmarks compare Hydro's dataflow implementation with timely dataflow:

- **`arithmetic`** - Performance comparison of arithmetic operations across different dataflow patterns
- **`fan_in`** - Tests fan-in patterns where multiple streams converge
- **`fan_out`** - Tests fan-out patterns where streams are distributed
- **`fork_join`** - Benchmarks fork-join parallelism patterns
- **`identity`** - Identity transformation comparing different pipeline implementations
- **`join`** - Join operation performance across implementations
- **`upcase`** - String processing (uppercase transformation) benchmarks

### Differential-Dataflow-Dependent Benchmarks

These benchmarks use both timely and differential-dataflow:

- **`reachability`** - Graph reachability computation using incremental computation patterns

## Prerequisites

Before running the benchmarks, ensure you have:

1. **Rust toolchain** - Install from [rustup.rs](https://rustup.rs/)
2. **Cargo** - Included with Rust installation
3. **(Optional) Main hydro repository** - If using local path dependencies instead of git

### Using Local Dependencies

If you have the main `bigweaver-agent-canary-hydro-zeta` repository cloned locally, you can modify `Cargo.toml` to use local paths instead of git dependencies:

```toml
# Change this:
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }

# To this (adjust path as needed):
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks:

```bash
cargo bench
```

This will execute all 8 benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

To run individual benchmarks:

```bash
# Run a specific benchmark
cargo bench --bench identity
cargo bench --bench fork_join
cargo bench --bench reachability

# Run benchmarks matching a pattern
cargo bench --bench fan_*
```

### Available Benchmark Commands

```bash
# Identity transformation benchmarks
cargo bench --bench identity

# Fork-join pattern benchmarks
cargo bench --bench fork_join

# Join operation benchmarks
cargo bench --bench join

# String uppercase benchmarks
cargo bench --bench upcase

# Fan-in pattern benchmarks
cargo bench --bench fan_in

# Fan-out pattern benchmarks
cargo bench --bench fan_out

# Arithmetic operations benchmarks
cargo bench --bench arithmetic

# Graph reachability benchmarks
cargo bench --bench reachability
```

## Performance Comparisons

Each benchmark typically compares multiple implementations:

1. **Raw/Baseline** - Direct Rust implementation without dataflow frameworks
2. **Iterator** - Using Rust's built-in iterator abstractions
3. **Timely** - Using timely dataflow
4. **Hydro/dfir_rs** - Using Hydro's dataflow implementation
5. **Differential** - Using differential-dataflow (where applicable)

The benchmarks help identify:
- Overhead of different dataflow abstractions
- Performance characteristics of different patterns
- Optimization opportunities
- Regression detection

## Viewing Results

Benchmark results are saved in the `target/criterion/` directory:

```bash
# Open the main report
open target/criterion/report/index.html

# View specific benchmark results
open target/criterion/identity/report/index.html
```

Results include:
- Execution time statistics (mean, median, std dev)
- Comparison with previous runs (if available)
- Performance graphs and visualizations
- Throughput measurements

## Build Configuration

The `build.rs` script generates additional benchmark code at compile time. It currently generates:
- Fork-join pattern configurations with varying operation counts
- Dynamic benchmark variations

The generated files are placed in the `benches/` directory and are automatically included in the build.

## Dependencies

### Core Dependencies

- **criterion** (0.5.0) - Benchmarking framework with statistical analysis
  - Features: `async_tokio`, `html_reports`
- **dfir_rs** - Hydro's dataflow implementation
  - Features: `debugging`
- **timely** (0.13.0-dev.1) - Timely dataflow framework
  - Package: `timely-master`
- **differential-dataflow** (0.13.0-dev.1) - Differential dataflow framework
  - Package: `differential-dataflow-master`

### Supporting Dependencies

- **futures** (0.3) - Async programming primitives
- **tokio** (1.29.0) - Async runtime
  - Features: `rt-multi-thread`
- **rand** (0.8.0) - Random number generation
- **rand_distr** (0.4.3) - Random distributions
- **seq-macro** (0.2.0) - Sequence generation macros
- **nameof** (1.0.0) - Name reflection utilities
- **static_assertions** (1.0.0) - Compile-time assertions
- **sinktools** (^0.0.1) - Utility tools for stream sinks

## Configuration

### Benchmark Parameters

Many benchmarks use configurable constants (defined in each benchmark file):

```rust
const NUM_OPS: usize = 20;      // Number of operations in pipeline
const NUM_INTS: usize = 1_000_000;  // Input data size
```

You can modify these values to:
- Test different scales
- Focus on specific performance characteristics
- Reduce benchmark execution time during development

### Criterion Configuration

Criterion is configured with:
- Async tokio support for async benchmarks
- HTML report generation
- Custom harness disabled (`harness = false`) for all benchmarks

## Integration with Main Repository

These benchmarks were originally part of the `bigweaver-agent-canary-hydro-zeta` repository. The migration history is documented in:

- **Main repo:** `BENCHMARK_REMOVAL_SUMMARY.md`
- **Main repo:** `benches/README.md`

### Migration Summary

The benchmarks were moved to:
1. Reduce the main repository's dependency on timely and differential-dataflow
2. Improve build times for developers working on core Hydro functionality
3. Provide a dedicated space for comparative performance analysis
4. Enable independent evolution of benchmarking infrastructure

## Continuous Integration

To integrate these benchmarks into CI/CD:

```bash
# Quick smoke test (runs shorter iterations)
cargo bench --no-run  # Just build, don't run
cargo build --benches # Verify benchmarks compile

# Full benchmark suite (for nightly runs)
cargo bench --all
```

Consider:
- Running benchmarks on dedicated hardware for consistent results
- Tracking performance over time
- Setting up alerts for performance regressions

## Troubleshooting

### Common Issues

**Build Errors with dfir_rs or sinktools:**
- Ensure you have network access to clone from GitHub
- Or use local path dependencies if you have the main repo

**Benchmark Compilation Failures:**
- Check that you're using the correct Rust edition (2024)
- Verify all dependencies are available
- Try `cargo clean` and rebuild

**Slow Benchmark Execution:**
- Adjust NUM_OPS and NUM_INTS constants
- Run individual benchmarks instead of the full suite
- Use `--quick` flag for faster iterations during development

**Missing Data Files:**
- Ensure `reachability_edges.txt` and `reachability_reachable.txt` exist
- Ensure `words_alpha.txt` exists in the benches directory

## Contributing

When adding new benchmarks:

1. Follow the existing benchmark structure
2. Use criterion for statistical analysis
3. Include multiple implementation variants for comparison
4. Document the benchmark purpose and parameters
5. Add appropriate `[[bench]]` entries to `Cargo.toml`
6. Update this README with benchmark descriptions

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://hydro-project.github.io/)

## License

Apache-2.0

---

For questions or issues with these benchmarks, please refer to the main `bigweaver-agent-canary-hydro-zeta` repository or contact the Hydro development team.