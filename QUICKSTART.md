# Quick Start Guide

Get started with the hydro-deps benchmarks in 5 minutes!

## What is This Repository?

This repository contains benchmarks that compare dfir_rs/Hydro implementations against timely and differential-dataflow. It exists separately to keep the main repository fast to build.

## Prerequisites

- Rust toolchain
- Git access to the main hydro repository (for dfir_rs dependency)

## Quick Commands

### Run All Benchmarks
```bash
cargo bench -p hydro-deps-benches
```

### Run One Benchmark
```bash
cargo bench -p hydro-deps-benches --bench reachability
```

### Run Fast (Quick Mode)
```bash
cargo bench -p hydro-deps-benches -- --quick
```

### View Results
Results are in: `target/criterion/<benchmark_name>/report/index.html`

## Available Benchmarks

| Benchmark | Description | Speed |
|-----------|-------------|-------|
| identity | Baseline (minimal operations) | ⚡ Fast |
| arithmetic | Basic arithmetic ops | ⚡ Fast |
| fan_in | Multiple inputs merge | ⚡ Fast |
| fan_out | One input splits | ⚡ Fast |
| fork_join | Split and rejoin | ⚡ Fast |
| join | Binary join operation | ⚡⚡ Medium |
| upcase | String transformation | ⚡⚡ Medium |
| reachability | Graph algorithms | ⚡⚡⚡ Slow (most comprehensive) |

## Common Workflows

### 1. Quick Check
```bash
# Run just the fast benchmarks
cargo bench -p hydro-deps-benches --bench identity
cargo bench -p hydro-deps-benches --bench arithmetic
```

### 2. Full Performance Analysis
```bash
# Run all benchmarks
cargo bench -p hydro-deps-benches

# View comprehensive results
open target/criterion/index.html
```

### 3. Compare Before/After Changes
```bash
# Before changes - save baseline
cargo bench -p hydro-deps-benches -- --save-baseline before

# Make your changes in main repo...

# After changes - compare
cargo bench -p hydro-deps-benches -- --baseline before
```

### 4. Test Specific Implementation
```bash
# Run only timely implementations
cargo bench -p hydro-deps-benches -- "timely"

# Run only dfir_rs implementations
cargo bench -p hydro-deps-benches -- "dfir_rs"
```

## Understanding Results

Criterion output shows:
- **time**: Average execution time
- **change**: Performance change from previous run
- **thrpt**: Throughput (if applicable)

Example:
```
reachability/timely     time:   [15.234 ms 15.456 ms 15.678 ms]
                        change: [-5.2% -3.1% -1.0%] (faster!)
```

Lower time = better performance

## First Time Setup

1. **Clone this repository**:
   ```bash
   git clone <repo-url> bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Build** (may take 5-7 minutes first time):
   ```bash
   cargo build
   ```

3. **Run verification**:
   ```bash
   ./verify_benchmarks.bash
   ```

4. **Run a quick benchmark**:
   ```bash
   cargo bench -p hydro-deps-benches --bench identity
   ```

## Troubleshooting

### Build Takes Forever
- First build includes timely/differential (heavy dependencies)
- Subsequent builds are faster
- Use `cargo build --release` if `cargo build` is slow

### Cannot Find dfir_rs
- Requires network access to fetch from git
- Check git credentials
- Verify main repository URL in `benches/Cargo.toml`

### Inconsistent Results
- Close other applications
- Run multiple times for stability
- Check system isn't under load

## Next Steps

- 📖 Read [MIGRATION.md](MIGRATION.md) for detailed guide
- 📖 Read [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) for what each benchmark tests
- 📖 Read [CONTRIBUTING.md](CONTRIBUTING.md) to add new benchmarks
- 📖 Read [benches/README.md](benches/README.md) for benchmark-specific info

## Help

- **Question about benchmarks?** See [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md)
- **Want to add a benchmark?** See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Migration questions?** See [MIGRATION.md](MIGRATION.md)
- **Quick reference?** See [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)

## One-Liner Examples

```bash
# Fastest benchmark
cargo bench -p hydro-deps-benches --bench identity

# Most comprehensive benchmark
cargo bench -p hydro-deps-benches --bench reachability

# All benchmarks, minimal output
cargo bench -p hydro-deps-benches --quiet

# Specific pattern
cargo bench -p hydro-deps-benches --bench reachability -- "differential"
```

---

**Ready to go!** Start with: `cargo bench -p hydro-deps-benches --bench identity`
