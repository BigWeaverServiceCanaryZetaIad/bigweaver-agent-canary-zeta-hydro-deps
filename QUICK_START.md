# Quick Start Guide

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify Rust toolchain**:
   ```bash
   rustup show
   # Should automatically install the correct toolchain from rust-toolchain.toml
   ```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

### List Available Benchmarks
```bash
cargo bench --benches --no-run 2>&1 | grep "Compiling benches"
```

The available benchmarks are:
- `arithmetic` - Arithmetic operations comparison
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `identity` - Identity transformation
- `join` - Join operations
- `reachability` - Graph reachability
- `upcase` - String uppercase

## Understanding Results

After running benchmarks, results are saved in:
```
target/criterion/
```

View HTML reports:
```bash
# Open the main report
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Common Commands

### Check Compilation (Fast)
```bash
cargo check --benches
```

### Clean Build
```bash
cargo clean
cargo bench
```

### Update Dependencies
```bash
cargo update
```

## What Gets Compared

Each benchmark typically includes implementations for:

1. **Timely Dataflow** - The timely dataflow framework
2. **Differential Dataflow** - Incremental computation framework
3. **Hydro (dfir_rs)** - Multiple variants:
   - Scheduled runtime
   - Surface syntax
   - Compiled optimizations

## Example Output

```
reachability/timely      time:   [10.234 ms 10.456 ms 10.678 ms]
reachability/differential time:   [8.123 ms 8.234 ms 8.345 ms]
reachability/dfir_rs     time:   [9.012 ms 9.123 ms 9.234 ms]
```

Lower times are better. The report shows:
- Minimum time (left)
- Average time (middle)
- Maximum time (right)

## Troubleshooting

### "Failed to fetch repository"
If you see errors fetching dfir_rs or sinktools:
```bash
# Verify git access to main repository
git ls-remote https://github.com/hydro-project/hydro
```

### "Compilation takes too long"
This is normal - first build includes:
- Timely and Differential Dataflow (large crates)
- Fetching and building dfir_rs from git
- Fetching and building sinktools from git

Subsequent builds will be much faster.

### "Out of memory during compilation"
Try reducing parallel compilation:
```bash
cargo bench -j 2  # Use only 2 parallel jobs
```

## Tips

1. **First run is slow**: Initial compilation takes time, subsequent runs are faster
2. **Close other apps**: For accurate benchmarks, minimize background processes
3. **Multiple runs**: Run benchmarks multiple times to account for variance
4. **Baseline comparisons**: Use criterion's baseline feature for tracking performance over time

## More Information

- Full testing guide: [TESTING.md](TESTING.md)
- Repository README: [README.md](README.md)
- Changelog: [CHANGELOG.md](CHANGELOG.md)

## Getting Help

If you encounter issues:
1. Check the [TESTING.md](TESTING.md) troubleshooting section
2. Verify your Rust toolchain matches `rust-toolchain.toml`
3. Try `cargo clean` and rebuild
4. Check that you have network access for git dependencies
