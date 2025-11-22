# Quick Start Guide

## Running Benchmarks

### Prerequisites
- Rust toolchain (see `rust-toolchain.toml`)
- Network access (for git dependencies)

### Quick Test
```bash
# Test that benchmarks compile and run
cargo bench --bench arithmetic -- --test
```

### Run All Benchmarks
```bash
cargo bench -p timely-differential-benches
```

### Run Specific Benchmark
```bash
cargo bench --bench reachability
cargo bench --bench identity
cargo bench --bench arithmetic
```

### View Results
After running benchmarks:
```bash
# HTML reports are in:
open target/criterion/report/index.html
```

## Available Benchmarks

| Benchmark | Description | Frameworks Compared |
|-----------|-------------|-------------------|
| arithmetic | Arithmetic operations | Hydro, Timely, Baseline |
| fan_in | Fan-in patterns | Hydro, Timely, Differential |
| fan_out | Fan-out patterns | Hydro, Timely, Differential |
| fork_join | Fork-join patterns | Hydro, Timely |
| identity | Identity transforms | Hydro, Timely, Baseline |
| join | Join operations | Hydro, Timely, Differential |
| reachability | Graph reachability | Hydro, Differential |
| upcase | String processing | Hydro, Timely |

## Common Commands

```bash
# Check compilation
cargo check

# Build benchmarks
cargo build --benches

# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Run single benchmark in test mode (fast)
cargo bench --bench BENCHMARK_NAME -- --test

# Run full benchmark suite (slow, accurate)
cargo bench -p timely-differential-benches

# Run specific test within a benchmark
cargo bench --bench arithmetic -- pipeline

# List available benchmarks
cargo bench --benches -- --list
```

## Troubleshooting

### Compilation Fails
```bash
cargo clean
cargo check
```

### Git Dependencies Not Resolving
Check network connection and access to:
- https://github.com/hydro-project/hydro

### Benchmarks Run Slowly
This is normal. Benchmarks run multiple iterations for statistical accuracy.
Use `--test` flag for quick validation:
```bash
cargo bench --bench arithmetic -- --test
```

## More Information

- Full documentation: See [README.md](README.md)
- Testing guide: See [TESTING.md](TESTING.md)
- Migration details: See [MIGRATION_NOTES.md](MIGRATION_NOTES.md)
- Changelog: See [CHANGES.md](CHANGES.md)
