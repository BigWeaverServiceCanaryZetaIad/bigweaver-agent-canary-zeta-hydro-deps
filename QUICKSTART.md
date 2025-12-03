# Quick Start Guide

## Running Benchmarks

To quickly get started with the benchmarks in this repository:

### Prerequisites
- Rust toolchain (nightly recommended, see rust-toolchain.toml in main repo)
- Cargo (comes with Rust)

### Run All Benchmarks
```bash
cargo bench -p benches
```

This will run all 12 benchmark suites and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark
```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run identity benchmark
cargo bench -p benches --bench identity

# Run join benchmark
cargo bench -p benches --bench join
```

### View Results
After running benchmarks, open the HTML reports:
```bash
# Open in browser (macOS)
open target/criterion/report/index.html

# Open in browser (Linux)
xdg-open target/criterion/report/index.html
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Arithmetic operations benchmarks |
| `fan_in` | Fan-in pattern benchmarks |
| `fan_out` | Fan-out pattern benchmarks |
| `fork_join` | Fork-join pattern benchmarks |
| `futures` | Async futures benchmarks |
| `identity` | Identity operation benchmarks |
| `join` | Join operation benchmarks |
| `micro_ops` | Micro-operation benchmarks |
| `reachability` | Graph reachability benchmarks |
| `symmetric_hash_join` | Symmetric hash join benchmarks |
| `upcase` | String uppercase benchmarks |
| `words_diamond` | Word processing diamond pattern benchmarks |

## What Gets Compared

Each benchmark typically compares:
1. **Raw Rust** - Hand-written implementation
2. **Hydro DFIR** - Using Hydro's dataflow IR
3. **Timely** - Using Timely dataflow
4. **Differential** - Using Differential dataflow (where applicable)

This allows you to see how Hydro performs relative to existing dataflow frameworks.

## Understanding Results

Criterion will show:
- **Time per iteration** - How long each benchmark takes
- **Throughput** - Operations per second (for applicable benchmarks)
- **Change from baseline** - Performance change from previous runs
- **Statistical confidence** - How reliable the measurements are

## Troubleshooting

### Build Errors
If you encounter build errors:
1. Ensure you're using the correct Rust version (check rust-toolchain.toml)
2. Run `cargo clean` and try again
3. Check that all dependencies are available

### Missing Data Files
Some benchmarks use data files (e.g., reachability, words_diamond):
- These should be included in the `benches/benches/` directory
- If missing, clone the repository again to ensure all files are present

### Performance Variance
If benchmark results vary significantly:
1. Ensure no other heavy processes are running
2. Run benchmarks multiple times to establish baseline
3. Consider running on a dedicated machine for consistent results

## Next Steps

- Review detailed documentation in [README.md](README.md)
- Check migration guide in [MIGRATION.md](MIGRATION.md)
- Explore individual benchmark implementations in `benches/benches/`
- Compare results across different Hydro versions
