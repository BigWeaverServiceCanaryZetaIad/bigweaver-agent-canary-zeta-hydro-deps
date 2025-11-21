# Project Summary: Hydroflow External Framework Benchmarks

## Overview

This repository provides comprehensive performance benchmarks comparing Hydroflow against external dataflow frameworks (Timely Dataflow and Differential Dataflow). It was created to keep external dependencies separate from the main Hydroflow repository while enabling fair performance comparisons.

## Repository Contents

### Benchmark Implementations

Seven complete benchmark suites comparing equivalent implementations:

1. **Identity Benchmark** (`identity_comparison.rs`)
   - Pure framework overhead measurement
   - 20 pass-through operations on 1M elements
   - Compares: Timely, Hydroflow (3 variants), Baseline

2. **Join Benchmark** (`join_comparison.rs`)
   - Hash join performance
   - 100K elements per stream
   - Compares: Timely, Hydroflow, Baseline

3. **Reachability Benchmark** (`reachability_comparison.rs`)
   - Graph algorithm with iteration
   - Real graph data included
   - Compares: Differential, Timely, Hydroflow, Baseline BFS

4. **Fan-In Benchmark** (`fan_in_comparison.rs`)
   - Stream merging (10 streams)
   - Compares: Timely, Hydroflow, Baseline

5. **Fan-Out Benchmark** (`fan_out_comparison.rs`)
   - Stream splitting (10 consumers)
   - Compares: Timely, Hydroflow, Baseline

6. **Fork-Join Benchmark** (`fork_join_comparison.rs`)
   - Split-process-merge pattern
   - Compares: Timely, Hydroflow, Baseline

7. **Arithmetic Benchmark** (`arithmetic_comparison.rs`)
   - Computational workload
   - 20 arithmetic operations per element
   - Compares: Timely, Hydroflow, Baseline

### Documentation

Comprehensive documentation for users at all levels:

- **README.md**: Quick start and overview
- **SETUP.md**: Detailed installation and setup guide
- **BENCHMARKING_GUIDE.md**: In-depth benchmarking methodology and best practices
- **FRAMEWORK_COMPARISON.md**: Detailed framework comparison with code examples
- **PROJECT_SUMMARY.md**: This file - high-level overview

### Supporting Files

- **Cargo.toml**: Complete dependency specification with all benchmarks configured
- **src/lib.rs**: Common utilities and abstractions for benchmarks
- **benches/data/**: Graph data files for reachability benchmarks
- **run_benchmarks.sh**: Helper script for easy benchmark execution

## Key Features

### Comprehensive Coverage

✅ **Multiple Frameworks**: Timely, Differential, Hydroflow, Baseline
✅ **Multiple Patterns**: Identity, Join, Iteration, Fan-in, Fan-out, Fork-join, Arithmetic
✅ **Multiple Hydroflow APIs**: Compiled, Scheduled, Surface syntax
✅ **Real Data**: Included graph data for realistic testing

### Production Quality

✅ **Statistical Analysis**: Using Criterion.rs for robust measurements
✅ **Reproducibility**: Fixed data, documented methodology
✅ **Correctness Checks**: Assertions verify equivalent results
✅ **Performance Optimized**: Release profile with LTO and optimizations

### Developer Friendly

✅ **Clear Documentation**: Multiple guides for different needs
✅ **Helper Scripts**: Easy-to-use benchmark runner
✅ **Extensibility**: Clear patterns for adding new benchmarks
✅ **Troubleshooting**: Comprehensive problem-solving guides

## Dependencies

### External Frameworks

- `timely-master` (0.13.0-dev.1): Low-level dataflow coordination
- `differential-dataflow-master` (0.13.0-dev.1): Incremental computation

### Hydroflow Components (via path)

- `dfir_rs`: Hydroflow core with debugging features
- `sinktools`: Hydroflow utilities

### Benchmark Infrastructure

- `criterion` (0.5.0): Statistical benchmarking framework
- `tokio` (1.29.0): Async runtime for Hydroflow
- Various utilities: `futures`, `rand`, `seq-macro`, etc.

## Usage Examples

### Quick Start

```bash
# Run all benchmarks with helper script
./run_benchmarks.sh

# Run specific benchmark
./run_benchmarks.sh --bench identity

# Quick mode (fewer samples)
./run_benchmarks.sh --quick

# Save baseline for future comparison
./run_benchmarks.sh --baseline my_baseline
```

### Manual Execution

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability_comparison

# Run with custom options
cargo bench -- --sample-size 100 --quick

# Compare against saved baseline
cargo bench -- --baseline my_baseline
```

### View Results

```bash
# Open HTML report (macOS)
open target/criterion/report/index.html

# Open HTML report (Linux)
xdg-open target/criterion/report/index.html
```

## Integration with Main Repository

This repository is designed to work alongside the main Hydroflow repository:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/       # Main Hydroflow repository
│   ├── dfir_rs/                              # Core Hydroflow (referenced by deps)
│   ├── sinktools/                            # Utilities (referenced by deps)
│   ├── benches/                              # Hydroflow-only benchmarks
│   └── BENCHMARK_COMPARISON_ARCHIVE.md       # Historical methodology
│
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
    ├── benches/                              # Comparison benchmarks
    ├── src/                                  # Common utilities
    └── [documentation files]
```

### Why Separate Repository?

1. **Dependency Isolation**: Keeps external framework dependencies out of main repo
2. **Build Times**: Main repo builds faster without Timely/Differential
3. **Maintenance**: Easier to update external framework versions
4. **Focus**: Main repo focuses on Hydroflow development
5. **Comparison**: Clear separation of internal vs external benchmarks

## Results Interpretation

### What the Benchmarks Show

**Single-Query Performance**: Our benchmarks measure one-shot query execution
- Best for: Comparing throughput and overhead
- Favors: Specialized implementations and optimized patterns

**Framework Overhead**: Difference from baseline
- Expected: 5-30% overhead for convenience and generality
- Acceptable: Framework value (features, ergonomics) justifies overhead

### What the Benchmarks Don't Show

**Incremental Performance**: Differential Dataflow's main strength
- Real benefit appears with data updates
- Single-query benchmarks underestimate Differential's value

**Distributed Performance**: Single-node only
- Timely/Differential designed for distribution
- Real value emerges at scale

**Development Velocity**: Code complexity and maintainability
- See FRAMEWORK_COMPARISON.md for code examples
- Ergonomics matter in production

### Making Comparisons

When comparing results:

1. **Compare Like with Like**: Same input size, same pattern
2. **Consider Context**: What's the use case?
3. **Look at Trends**: Relative performance across benchmarks
4. **Statistical Significance**: Check p-values and confidence intervals
5. **Multiple Runs**: Verify consistency

## Performance Characteristics

### Expected Performance Order

**Simple Operations (Identity, Arithmetic)**:
1. Baseline (specialized)
2. Hydroflow compiled (optimized for common patterns)
3. Timely (general-purpose framework)
4. Differential (overhead from generality)

**Joins**:
1. Baseline sequential (optimized for single-shot)
2. Hydroflow (good default)
3. Timely with manual state (more code, similar performance)

**Iterative Algorithms (Reachability)**:
1. Baseline BFS (specialized for single query)
2. Differential (with incremental updates, would dominate)
3. Hydroflow (good balance)
4. Timely with feedback (flexible but verbose)

### Framework Strengths

**Timely Dataflow**:
- Low-level control
- Complex coordination patterns
- Research flexibility

**Differential Dataflow**:
- Incremental computation (main strength!)
- Multiple queries on changing data
- Automatic incrementalization

**Hydroflow**:
- Ergonomics and productivity
- Multiple programming models
- Good balance of performance and usability

## Development Workflow

### For Users

1. Read documentation (start with README.md)
2. Run quick benchmarks: `./run_benchmarks.sh --quick`
3. Explore results in HTML reports
4. Compare frameworks for your use case
5. Reference framework comparison guide

### For Contributors

1. Study existing benchmark implementations
2. Follow patterns for new benchmarks
3. Add benchmark to Cargo.toml
4. Document purpose and expected results
5. Verify correctness with assertions
6. Run and validate results

### For Maintainers

1. Keep dependencies updated
2. Verify benchmarks after updates
3. Document any breaking changes
4. Maintain consistency across benchmarks
5. Update documentation with insights

## File Structure Reference

```
bigweaver-agent-canary-zeta-hydro-deps/
│
├── Cargo.toml                        # Dependencies and benchmark configuration
├── run_benchmarks.sh                 # Helper script for running benchmarks
│
├── src/
│   └── lib.rs                        # Common utilities and abstractions
│
├── benches/
│   ├── data/
│   │   ├── reachability_edges.txt    # Graph edges data
│   │   └── reachability_reachable.txt # Expected results
│   │
│   ├── identity_comparison.rs        # Identity benchmark
│   ├── join_comparison.rs            # Join benchmark
│   ├── reachability_comparison.rs    # Graph reachability benchmark
│   ├── fan_in_comparison.rs          # Fan-in benchmark
│   ├── fan_out_comparison.rs         # Fan-out benchmark
│   ├── fork_join_comparison.rs       # Fork-join benchmark
│   └── arithmetic_comparison.rs      # Arithmetic benchmark
│
└── Documentation/
    ├── README.md                     # Quick start and overview
    ├── SETUP.md                      # Installation and setup guide
    ├── BENCHMARKING_GUIDE.md         # Comprehensive benchmarking guide
    ├── FRAMEWORK_COMPARISON.md       # Framework comparison details
    └── PROJECT_SUMMARY.md            # This file
```

## Metrics and Statistics

### What Criterion Measures

- **Mean Time**: Average execution time
- **Median Time**: Middle value (robust to outliers)
- **Standard Deviation**: Variability measure
- **MAD**: Median Absolute Deviation
- **Confidence Intervals**: Range of likely true values
- **P-values**: Statistical significance

### Performance Metrics

- **Throughput**: Elements per second
- **Latency**: End-to-end time
- **Overhead**: Framework cost vs baseline
- **Scalability**: Performance vs input size

## Common Commands

```bash
# Setup
cargo build --release              # Build all benchmarks
cargo test                         # Run tests

# Run Benchmarks
./run_benchmarks.sh               # Run all with helper script
cargo bench                        # Run all manually
cargo bench --bench NAME           # Run specific benchmark

# Options
cargo bench -- --quick             # Quick mode
cargo bench -- --sample-size 100   # More samples
cargo bench -- --baseline NAME     # Compare with baseline
cargo bench -- --save-baseline N   # Save baseline

# Results
open target/criterion/report/index.html  # View HTML report

# Development
cargo check                        # Quick validation
cargo bench --no-run              # Compile without running
cargo clean                        # Clean build artifacts
```

## Best Practices

### Before Benchmarking

1. Close unnecessary applications
2. Ensure system is cool (not thermally throttling)
3. Plug in laptop (don't benchmark on battery)
4. Disable background tasks
5. Build in release mode

### During Benchmarking

1. Don't interrupt the process
2. Let Criterion collect sufficient samples
3. Watch for warnings (high variance, outliers)
4. Monitor system resources
5. Note any anomalies

### After Benchmarking

1. Review HTML reports for details
2. Check statistical significance
3. Compare across multiple runs
4. Document findings
5. Save baselines for future comparison

## Future Enhancements

Potential additions:

- [ ] Memory usage profiling
- [ ] Distributed benchmarks (multiple nodes)
- [ ] Incremental update benchmarks (show Differential's strength)
- [ ] More complex graph algorithms
- [ ] String processing benchmarks
- [ ] State management benchmarks
- [ ] Coordination overhead measurements
- [ ] Compilation time comparisons

## References

### This Repository
- [README.md](README.md) - Overview and quick start
- [SETUP.md](SETUP.md) - Installation guide
- [BENCHMARKING_GUIDE.md](BENCHMARKING_GUIDE.md) - Comprehensive guide
- [FRAMEWORK_COMPARISON.md](FRAMEWORK_COMPARISON.md) - Framework details

### Main Repository
- [BENCHMARK_COMPARISON_ARCHIVE.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_COMPARISON_ARCHIVE.md)
- Hydroflow documentation

### External Resources
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow](https://hydro.run/)
- [Criterion.rs](https://bheisler.github.io/criterion.rs/book/)

## License

Apache-2.0 (consistent with Hydroflow project)

## Conclusion

This repository provides a comprehensive benchmark suite for comparing Hydroflow with external dataflow frameworks. It includes:

✅ **7 Complete Benchmarks**: Covering common dataflow patterns
✅ **3 Framework Implementations**: Timely, Differential, Hydroflow
✅ **Extensive Documentation**: Multiple guides for different needs
✅ **Production Quality**: Statistical rigor, correctness checks
✅ **Easy to Use**: Helper scripts and clear examples
✅ **Extensible**: Clear patterns for adding benchmarks

The benchmarks enable fair performance comparisons while maintaining the separation between Hydroflow's main repository and external framework dependencies. Use this repository to understand performance characteristics, validate optimizations, and make informed framework choices for your use case.
