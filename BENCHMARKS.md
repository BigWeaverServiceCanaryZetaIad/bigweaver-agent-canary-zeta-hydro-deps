# Benchmark Documentation

## Overview

This repository contains performance benchmarks comparing DFIR (Dataflow Intermediate Representation) with Timely and Differential Dataflow implementations. These benchmarks were separated from the main Hydro repository to isolate dependencies on `timely` and `differential-dataflow` packages.

## Available Benchmarks

### Core Operations
- **arithmetic.rs** - Tests basic arithmetic operations across different dataflow implementations
- **identity.rs** - Measures overhead of identity transformations
- **micro_ops.rs** - Comprehensive micro-operation benchmarks (map, filter, join, unique, etc.)

### Pattern Benchmarks
- **fork_join.rs** - Fork/join parallelism patterns
- **fan_in.rs** - Multiple input streams converging to single output
- **fan_out.rs** - Single input stream splitting to multiple outputs
- **words_diamond.rs** - Diamond-shaped dataflow graph with word processing

### Join Operations
- **join.rs** - Basic join operation benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join implementation comparison

### Complex Workloads
- **reachability.rs** - Graph reachability computation (uses large graph dataset)
- **futures.rs** - Async futures and tokio integration benchmarks
- **upcase.rs** - String transformation benchmarks

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed and the repository cloned:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Run All Benchmarks

```bash
cargo bench --package benches
```

This will run all benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark

```bash
# Run only reachability benchmarks
cargo bench --package benches --bench reachability

# Run only micro-operation benchmarks
cargo bench --package benches --bench micro_ops

# Run arithmetic benchmarks
cargo bench --package benches --bench arithmetic
```

### Run With Filtering

Criterion supports filtering by benchmark name:

```bash
# Run only join-related benchmarks
cargo bench --package benches -- join

# Run identity benchmarks only
cargo bench --package benches -- identity
```

## Understanding Results

### Criterion Output

Benchmarks use the Criterion framework which provides:
- **Time per iteration** - Average execution time
- **Throughput** - Operations per second (when applicable)
- **Standard deviation** - Measure of consistency
- **Change detection** - Comparison with previous runs

### HTML Reports

After running benchmarks, detailed HTML reports are available in:
```
target/criterion/<benchmark_name>/report/index.html
```

These reports include:
- Violin plots showing distribution
- Comparison charts (if previous results exist)
- Statistical analysis
- Raw measurement data

## Performance Comparison Workflow

### Initial Baseline

First run establishes baseline:
```bash
cargo bench --package benches
```

### After Code Changes

Run benchmarks again to see performance impact:
```bash
# In the main hydro repository, make changes to dfir_rs
cd ../bigweaver-agent-canary-hydro-zeta
# ... make changes ...
git commit -am "perf: optimize operator implementation"

# Return to benchmarks and re-run
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo update  # Update to latest main repo changes
cargo bench --package benches
```

Criterion will automatically compare against baseline and show:
- Performance improvements (green)
- Performance regressions (red)
- No significant change (white)

### Comparing Branches

```bash
# Benchmark baseline branch
cargo bench --package benches -- --save-baseline main

# Switch main repo to experimental branch
# (update Cargo.toml if needed)
cargo update

# Benchmark experimental changes
cargo bench --package benches -- --baseline main
```

## Benchmark Data Files

Some benchmarks use large data files:
- `benches/benches/reachability_edges.txt` - Graph edges for reachability benchmark
- `benches/benches/reachability_reachable.txt` - Expected reachable nodes
- `benches/benches/words_alpha.txt` - Word list for string processing benchmarks

These files are included in the repository and loaded at runtime.

## Customizing Benchmarks

### Benchmark Parameters

Many benchmarks accept parameters that can be adjusted in the source code:

```rust
// In micro_ops.rs
const NUM_INTS: usize = 10_000;  // Adjust workload size
```

### Adding New Benchmarks

1. Create a new file in `benches/benches/your_benchmark.rs`
2. Add benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Run with `cargo bench --bench your_benchmark`

## Troubleshooting

### Compilation Errors

If you encounter errors about missing dependencies:
```bash
# Clean and rebuild
cargo clean
cargo bench --package benches
```

### Timely/Differential Version Mismatches

Ensure the versions in `benches/Cargo.toml` are compatible:
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

### Long Running Benchmarks

Some benchmarks (especially reachability) take significant time. To run quickly during development:

```bash
# Run with reduced sample size
cargo bench --package benches -- --sample-size 10
```

## Integration with CI/CD

These benchmarks can be integrated into CI pipelines:

```bash
# Run benchmarks and save results
cargo bench --package benches -- --save-baseline ci-baseline

# Compare against baseline in future runs
cargo bench --package benches -- --baseline ci-baseline
```

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
