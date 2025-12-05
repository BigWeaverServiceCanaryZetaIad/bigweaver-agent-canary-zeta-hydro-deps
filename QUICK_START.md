# Quick Start Guide

## Running Benchmarks

### All Benchmarks
```bash
cargo bench -p benches
```

### Specific Benchmark
```bash
cargo bench -p benches --bench identity
```

### With Filtering
```bash
# Run all "dfir" variants
cargo bench -p benches -- dfir

# Run specific test within a benchmark
cargo bench -p benches --bench identity -- "dfir/identity"
```

## Available Benchmarks

| Benchmark | Description | Key Features |
|-----------|-------------|--------------|
| `arithmetic` | Arithmetic operations | Addition, subtraction, multiplication |
| `fan_in` | Multiple inputs to one output | Stream merging patterns |
| `fan_out` | One input to multiple outputs | Stream splitting patterns |
| `fork_join` | Parallel execution with sync | Generated at build time |
| `futures` | Async/await operations | Tokio integration |
| `identity` | Identity transformations | Baseline performance |
| `join` | Stream join operations | Two-way joins |
| `micro_ops` | Low-level operations | Minimal overhead tests |
| `reachability` | Graph reachability | Uses graph data files |
| `symmetric_hash_join` | Hash-based joins | Symmetric join patterns |
| `upcase` | String transformations | Text processing |
| `words_diamond` | Diamond pipeline | Complex word processing |

## Benchmark Output

Results are saved to:
- `target/criterion/` - Detailed HTML reports
- Console output - Statistical summary

## Tips

- First run establishes a baseline
- Subsequent runs compare against baseline
- Use `[ci-bench]` in commit messages to trigger CI benchmarks
- Check HTML reports for detailed performance graphs

## Troubleshooting

### Build Issues
```bash
# Clean and rebuild
cargo clean
cargo build -p benches

# Update dependencies
cargo update
```

### Performance Issues
- Ensure system is idle during benchmarks
- Close other applications
- Run multiple times for statistical significance
- Check criterion reports for variance

## More Information

See [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) for detailed documentation.
