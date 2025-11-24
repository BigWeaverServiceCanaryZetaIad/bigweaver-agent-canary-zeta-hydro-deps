# Quick Start Guide

This guide will help you get started with running the Hydro benchmarks quickly.

## Prerequisites

- Rust 1.91.1 (will be automatically installed via rustup)
- Git

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify setup (optional but recommended):**
   ```bash
   bash verify_setup.sh
   ```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```
⚠️ **Note:** This will take a considerable amount of time as it runs all 12 benchmarks with full sample sizes.

### Run a Single Benchmark
```bash
# Run just the identity benchmark
cargo bench -p benches --bench identity

# Other available benchmarks:
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench futures
cargo bench -p benches --bench join
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench reachability
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench upcase
cargo bench -p benches --bench words_diamond
```

### Run Specific Benchmark Functions
```bash
# Run only dfir_rs benchmarks from identity
cargo bench -p benches --bench identity -- dfir

# Run only timely benchmarks
cargo bench -p benches --bench identity -- timely

# Run only differential-dataflow benchmarks
cargo bench -p benches --bench identity -- differential
```

### Quick Test Run (Faster)
```bash
# Reduce sample size for faster testing
cargo bench -p benches --bench identity -- --sample-size 10
```

## Understanding Results

Benchmark results show timing comparisons between:
- **timely** - Timely dataflow implementation
- **differential** - Differential dataflow implementation  
- **dfir** / **hydro** - Hydro (dfir_rs) implementation

Example output:
```
identity/timely         time:   [125.3 ms 126.8 ms 128.5 ms]
identity/differential   time:   [142.1 ms 143.9 ms 145.8 ms]
identity/dfir           time:   [118.2 ms 119.5 ms 120.9 ms]
```

Lower times are better. Look for the middle value (median).

## Common Commands

### Build Without Running
```bash
cargo build --workspace --release
```

### Check Code Quality
```bash
# Check formatting
cargo fmt --all -- --check

# Run linter
cargo clippy --all

# Fix formatting automatically
cargo fmt --all
```

### Update Dependencies
```bash
cargo update
```

### View Benchmark Results
Results are stored in `target/criterion/`:
```bash
# Open the HTML report
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Troubleshooting

### Build Fails
```bash
# Clean and rebuild
cargo clean
cargo build --workspace
```

### Git Dependencies Fail
Ensure you have network access to:
- https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
- https://github.com/TimelyDataflow/timely-dataflow.git
- https://github.com/TimelyDataflow/differential-dataflow.git

### Benchmarks Take Too Long
Use smaller sample sizes:
```bash
cargo bench -p benches --bench identity -- --sample-size 10
```

Or run individual benchmarks instead of all at once.

### Permission Issues
If you see permission errors:
```bash
sudo chown -R $USER:$USER .
```

## What's What

### Key Files
- `benches/benches/*.rs` - Individual benchmark implementations
- `benches/Cargo.toml` - Benchmark dependencies
- `Cargo.toml` - Workspace configuration
- `verify_setup.sh` - Validation script

### Key Directories
- `benches/benches/` - Benchmark source code and test data
- `target/` - Build outputs (created after first build)
- `target/criterion/` - Benchmark results and reports

## Next Steps

- Read [README.md](README.md) for comprehensive documentation
- Check [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) for migration history
- Review [CONTRIBUTING.md](CONTRIBUTING.md) to contribute
- Explore individual benchmark files in `benches/benches/`

## Benchmark Descriptions

Quick reference for what each benchmark tests:

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Basic arithmetic operations in dataflow |
| `fan_in` | Multiple streams merging into one |
| `fan_out` | One stream splitting into multiple |
| `fork_join` | Parallel fork-join patterns |
| `futures` | Asynchronous future operations |
| `identity` | Identity transformation (baseline) |
| `join` | Stream join operations |
| `micro_ops` | Individual micro-operations |
| `reachability` | Graph reachability algorithms |
| `symmetric_hash_join` | Symmetric hash join implementation |
| `upcase` | String transformation operations |
| `words_diamond` | Diamond pattern word processing |

## Getting Help

- Open an issue: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/issues
- Check the main Hydro repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta

## Performance Tips

1. **Close other applications** before running benchmarks
2. **Plug in your laptop** - CPU throttling affects results
3. **Run benchmarks multiple times** for consistency
4. **Use release builds** - Debug builds are much slower
5. **Don't run all benchmarks at once** if you're in a hurry

Happy benchmarking! 🚀
