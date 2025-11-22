# Hydro Microbenchmarks

Comprehensive benchmarks for Hydro dataflow system, including comparative benchmarks with timely-dataflow and differential-dataflow.

## Quick Start

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Individual benchmark
cargo bench -p benches --bench reachability

# Pattern matching
cargo bench -p benches -- join

# Quick run for development
cargo bench -p benches -- --quick
```

## Available Benchmarks

### Core Hydro Benchmarks

- **arithmetic** - Basic arithmetic operations
- **fork_join** - Fork-join pattern execution
- **futures** - Async futures-based operations
- **join** - Join operations
- **micro_ops** - Micro-level operations
- **symmetric_hash_join** - Symmetric hash join implementation
- **upcase** - String transformation operations
- **words_diamond** - Diamond-shaped dataflow pattern with text processing

### Comparative Benchmarks (Hydro vs Timely)

These benchmarks compare Hydro's performance with timely-dataflow:

- **fan_in** - Fan-in dataflow pattern
- **fan_out** - Fan-out dataflow pattern
- **identity** - Identity transformation (baseline comparison)

### Comparative Benchmarks (Hydro vs Differential-Dataflow)

- **reachability** - Graph reachability computation and incremental updates

## Benchmark Data Files

Test data files included in this directory:

- **words_alpha.txt** - English word list for text processing benchmarks
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edges for reachability testing
- **reachability_reachable.txt** - Expected reachable nodes

## Understanding Results

Benchmark results are generated in `../../target/criterion/`:

```bash
# Open results in browser
open ../../target/criterion/report/index.html  # macOS
xdg-open ../../target/criterion/report/index.html  # Linux
```

Results include:
- Execution time statistics (mean, median, std dev)
- Comparison with previous runs (if baseline exists)
- HTML reports with graphs and detailed analysis
- Statistical confidence intervals

## Advanced Usage

### Baseline Comparisons

Save a baseline for comparison:

```bash
cargo bench -p benches -- --save-baseline before-changes
```

Compare against baseline:

```bash
cargo bench -p benches -- --baseline before-changes
```

### Filtering Tests

Run benchmarks matching a pattern:

```bash
# All benchmarks with "hydro" in the name
cargo bench -p benches -- hydro

# All benchmarks with specific size
cargo bench -p benches -- "1000"

# Specific benchmark function
cargo bench -p benches -- "reachability/hydro"
```

### Development Mode

For faster iterations during development:

```bash
# Fewer samples, faster execution
cargo bench -p benches -- --quick

# Even faster with specific benchmark
cargo bench -p benches --bench identity -- --quick
```

## Dependencies

This benchmark suite depends on:

- **criterion** - Statistical benchmarking framework
- **dfir_rs** - Hydro DFIR runtime
- **timely** - Timely dataflow (for comparative benchmarks)
- **differential-dataflow** - Differential dataflow (for comparative benchmarks)
- **tokio** - Async runtime
- **futures** - Async primitives
- **rand** - Random number generation

For local development, update paths in `Cargo.toml` to point to your local Hydro repository.

## Adding New Benchmarks

1. Create a new `.rs` file in the `benches/` directory
2. Implement using Criterion.rs API
3. Add benchmark entry to `Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

4. Run and verify:

```bash
cargo bench -p benches --bench my_benchmark
```

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.

## Performance Tips

### Writing Good Benchmarks

- **Isolate measurement**: Only measure the operation you're testing
- **Use black_box**: Prevent compiler optimizations that would be unrealistic
- **Appropriate input sizes**: Test with realistic data sizes
- **Multiple iterations**: Let Criterion determine optimal iteration count

### Interpreting Results

- **Look for trends**: How does performance scale with input size?
- **Statistical significance**: Check confidence intervals and p-values
- **Comparative analysis**: Compare Hydro with timely/differential when relevant
- **Regression detection**: Use baseline comparisons to catch performance issues

## Troubleshooting

### Compilation Issues

```bash
# Clean build
cargo clean

# Update dependencies
cargo update
```

### Unstable Results

- Close other applications
- Increase sample size: `--sample-size 100`
- Increase measurement time: `--measurement-time 10`
- Check system load

### Memory Issues

- Run benchmarks individually
- Reduce input sizes
- Monitor memory usage: `htop` or `top`

## Related Documentation

- [Repository README](../README.md) - Main repository documentation
- [PERFORMANCE_COMPARISON.md](../PERFORMANCE_COMPARISON.md) - Detailed performance testing guide
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/) - Benchmarking framework docs

## Support

For benchmark-related questions:
- Open an issue in this repository
- Check existing issues for similar problems
- Refer to Criterion.rs documentation

For Hydro-specific questions:
- Visit the [main Hydro repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
