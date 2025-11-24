# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains performance benchmarks and dependencies for the Hydro project that require external dependencies such as `timely` and `differential-dataflow`. These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency separation and reduce the complexity of the core codebase.

## Purpose

This repository serves to:
- **Isolate External Dependencies**: Keep timely and differential-dataflow dependencies separate from the main repository
- **Enable Performance Comparisons**: Provide infrastructure for comparing Hydro's performance against other dataflow systems
- **Maintain Benchmark History**: Track performance metrics over time
- **Reduce Main Repository Complexity**: Minimize compilation time and dependency tree complexity in the core codebase

## Contents

### Benchmarks

This repository includes 12 comprehensive benchmarks organized by dataflow patterns:

#### Benchmarks Using Timely/Differential-Dataflow Dependencies:
1. **arithmetic.rs** - Arithmetic operation pipeline benchmarks comparing Hydro with timely
2. **fan_in.rs** - Fan-in pattern benchmarks
3. **fan_out.rs** - Fan-out pattern benchmarks
4. **fork_join.rs** - Fork-join pattern benchmarks
5. **identity.rs** - Identity dataflow benchmarks
6. **join.rs** - Join operation benchmarks
7. **reachability.rs** - Graph reachability benchmarks using both timely and differential-dataflow
8. **upcase.rs** - String uppercase transformation benchmarks

#### Other Benchmarks:
9. **futures.rs** - Async futures benchmarks
10. **micro_ops.rs** - Micro-operation benchmarks
11. **symmetric_hash_join.rs** - Symmetric hash join benchmarks
12. **words_diamond.rs** - Word processing diamond pattern benchmarks

### Data Files

- **reachability_edges.txt** (521 KB) - Graph edge data for reachability benchmarks
- **reachability_reachable.txt** (38 KB) - Expected reachable nodes for validation
- **words_alpha.txt** (3.7 MB) - English word list from https://github.com/dwyl/english-words

## Quick Start

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in the main repository)
- Access to the main `bigweaver-agent-canary-hydro-zeta` repository (for path dependencies)

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability

# Run benchmarks matching a pattern
cargo bench arithmetic

# Generate HTML reports (automatically saved to target/criterion)
cargo bench --bench arithmetic
```

### Quick Benchmark Suite

For rapid iteration during development:

```bash
# Run quick versions of benchmarks (if implemented)
cargo bench -- --sample-size 10
```

## Performance Comparison

The benchmarks compare performance across multiple implementations:

- **Hydro (dfir_rs)** - The project's own dataflow system
- **Timely Dataflow** - External streaming dataflow system
- **Differential Dataflow** - Incremental computation framework built on Timely
- **Raw Rust** - Baseline implementations
- **Standard Iterators** - Baseline using Rust iterators

### Interpreting Results

Benchmark results are output in the following format:

```
arithmetic/dfir_rs/compiled  time:   [123.45 µs 124.67 µs 125.89 µs]
arithmetic/timely            time:   [234.56 µs 235.67 µs 236.78 µs]
```

- **Lower times are better**
- The three values represent [lower bound, estimate, upper bound] with 95% confidence
- HTML reports in `target/criterion/` provide detailed visualizations and historical comparisons

## Comparing with Main Repository

To compare performance between this repository and the main repository:

### Option 1: Manual Comparison

1. Run benchmarks in this repository:
   ```bash
   cargo bench --bench arithmetic > results_deps.txt
   ```

2. If the main repository has alternative implementations, run them there:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo test --release --features benchmark_mode
   ```

3. Compare the results manually using the generated reports

### Option 2: Using Criterion's Built-in Comparison

Criterion automatically tracks performance over time:

```bash
# Run initial baseline
cargo bench --bench arithmetic

# Make changes to the main repository
cd ../bigweaver-agent-canary-hydro-zeta
# ... make changes ...

# Re-run benchmarks to see differences
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench arithmetic
```

Criterion will automatically show percentage changes from the previous run.

### Option 3: Export and Analyze

```bash
# Generate detailed JSON output
cargo bench --bench arithmetic -- --output-format json > benchmark_results.json

# Use criterion's HTML reports for visual comparison
open target/criterion/report/index.html
```

## Dependencies

### External Dependencies

- **timely** - Timely dataflow system (v0.13.0-dev.1)
- **differential-dataflow** - Incremental computation framework (v0.13.0-dev.1)
- **criterion** - Benchmarking framework with statistical analysis
- **tokio** - Async runtime for async benchmarks

### Path Dependencies

These benchmarks depend on crates from the main repository:

- **dfir_rs** - Core Hydro dataflow functionality
- **sinktools** - Utility tools for sinks

**Note**: The benchmarks expect the main `bigweaver-agent-canary-hydro-zeta` repository to be located at `../bigweaver-agent-canary-hydro-zeta` relative to this repository.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Package configuration with dependencies
├── build.rs                      # Build script for code generation
├── README.md                     # This file
├── BENCHMARK_GUIDE.md           # Detailed benchmark usage guide
├── PERFORMANCE_COMPARISON.md    # Guide for comparing performance
└── benches/                      # Benchmark source files
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── futures.rs
    ├── identity.rs
    ├── join.rs
    ├── micro_ops.rs
    ├── reachability.rs
    ├── reachability_edges.txt
    ├── reachability_reachable.txt
    ├── symmetric_hash_join.rs
    ├── upcase.rs
    ├── words_alpha.txt
    └── words_diamond.rs
```

## Development Workflow

### Adding New Benchmarks

1. Create a new benchmark file in `benches/`:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_benchmark", |b| {
           b.iter(|| {
               // benchmark code
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. Add the benchmark to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Run the new benchmark:
   ```bash
   cargo bench --bench my_benchmark
   ```

### Updating Dependencies

When the main repository updates:

1. Ensure path dependencies are still valid
2. Update version numbers if needed
3. Test that all benchmarks still compile:
   ```bash
   cargo check --benches
   cargo bench --no-run
   ```

## Continuous Integration

For CI/CD integration:

```bash
# Check that benchmarks compile
cargo check --benches

# Compile benchmarks without running (faster for CI)
cargo bench --no-run

# Run benchmarks with limited iterations for quick feedback
cargo bench -- --sample-size 10 --measurement-time 1
```

## Troubleshooting

### Path Dependencies Not Found

If you see errors about missing `dfir_rs` or `sinktools`:

1. Ensure the main repository is cloned at `../bigweaver-agent-canary-hydro-zeta`
2. Verify the main repository is up to date:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   git pull
   ```

### Benchmark Compilation Errors

If benchmarks fail to compile:

1. Check that you're using the correct Rust toolchain (see main repo's `rust-toolchain.toml`)
2. Ensure all dependencies are up to date:
   ```bash
   cargo update
   ```

### Performance Regression

If benchmarks show significant performance regression:

1. Check recent changes in the main repository
2. Review the HTML reports in `target/criterion/` for detailed analysis
3. Run benchmarks multiple times to confirm results are consistent
4. Consider environmental factors (system load, CPU throttling, etc.)

## Migration History

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` on November 24, 2024:

- **Original Location**: `bigweaver-agent-canary-hydro-zeta/benches/`
- **Reason**: Isolate timely and differential-dataflow dependencies from main repository
- **Migration Details**: See `BENCHMARK_REMOVAL.md` in the main repository

## Related Documentation

- **BENCHMARK_GUIDE.md** - Comprehensive guide to using and understanding benchmarks
- **PERFORMANCE_COMPARISON.md** - Detailed guide for performance analysis and comparison
- Main Repository Documentation: `../bigweaver-agent-canary-hydro-zeta/README.md`

## Contributing

When contributing benchmarks:

1. Ensure benchmarks are meaningful and test realistic scenarios
2. Include comparisons with at least one baseline (timely, raw Rust, or iterators)
3. Document what the benchmark measures and why it's important
4. Keep benchmarks focused on specific patterns or operations
5. Add appropriate comments explaining non-obvious benchmark logic

## License

Apache-2.0

## Contact

For questions or issues related to these benchmarks, please refer to the main repository or contact the BigWeaverServiceCanaryZetaIad team.

---

**Repository**: bigweaver-agent-canary-zeta-hydro-deps  
**Owner**: BigWeaverServiceCanaryZetaIad  
**Last Updated**: November 24, 2024  
**Status**: Active