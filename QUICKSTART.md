# Quick Start Guide

## Running Benchmarks

### All Benchmarks
```bash
cargo bench -p benches
```

### Specific Benchmark
```bash
# Run just the arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run just the reachability benchmark
cargo bench -p benches --bench reachability
```

### Specific Test Within a Benchmark
```bash
# Run only the "pipeline" test in arithmetic
cargo bench -p benches --bench arithmetic -- pipeline
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Pipeline arithmetic operations |
| `fan_in` | Fan-in dataflow patterns |
| `fan_out` | Fan-out dataflow patterns |
| `fork_join` | Fork-join patterns |
| `futures` | Future-based async operations |
| `identity` | Identity transformations |
| `join` | Join operations |
| `micro_ops` | Micro-operations benchmarks |
| `reachability` | Graph reachability algorithms |
| `symmetric_hash_join` | Symmetric hash join operations |
| `upcase` | String case transformations |
| `words_diamond` | Word processing in diamond pattern |

## Viewing Results

Benchmark results are saved in `target/criterion/` with HTML reports at:
```
target/criterion/<benchmark-name>/report/index.html
```

Open these in a browser to see detailed performance graphs and statistics.

## Comparing Performance

### Save a Baseline
```bash
cargo bench -p benches -- --save-baseline baseline-name
```

### Compare Against Baseline
```bash
cargo bench -p benches -- --baseline baseline-name
```

### Example Workflow
```bash
# 1. Run benchmarks and save as "before"
cargo bench -p benches -- --save-baseline before

# 2. Make changes to the main Hydro repository

# 3. Update dependencies to pull in changes
cargo update

# 4. Run benchmarks again and compare
cargo bench -p benches -- --baseline before
```

Criterion will show percentage changes in performance compared to the baseline.

## Troubleshooting

### Slow First Run
The first benchmark run will be slower as it:
- Downloads and compiles dependencies
- Runs warmup iterations
- Collects initial samples

This is normal. Subsequent runs will be faster.

### Network Issues
If you see Git dependency errors, ensure you have:
- Network access to GitHub
- Git configured correctly
- SSH keys set up (if using SSH Git URLs)

### Build Errors
Try:
```bash
cargo clean
cargo update
cargo bench -p benches
```

## More Information

- See [README.md](README.md) for comprehensive documentation
- See [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) for migration details
- See [Criterion documentation](https://bheisler.github.io/criterion.rs/book/) for advanced usage
