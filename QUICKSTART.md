# Quick Start Guide

Get up and running with Hydroflow performance benchmarks in 5 minutes.

## Prerequisites

- Rust 1.70+ installed
- Git installed
- Terminal access

## 1. Clone Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

## 2. Run Your First Benchmark

```bash
# Run the arithmetic benchmark
cargo bench --bench arithmetic
```

This will:
- Download dependencies (first time only)
- Compile the benchmark
- Run performance tests
- Generate HTML reports

**Expected output:**
```
arithmetic/pipeline     time:   [XXX.XX ms YYY.YY ms ZZZ.ZZ ms]
arithmetic/raw          time:   [XXX.XX ms YYY.YY ms ZZZ.ZZ ms]
arithmetic/timely       time:   [XXX.XX ms YYY.YY ms ZZZ.ZZ ms]
arithmetic/dfir_rs      time:   [XXX.XX ms YYY.YY ms ZZZ.ZZ ms]
```

## 3. View Results

```bash
# Open HTML report in browser (macOS)
open target/criterion/report/index.html

# Linux
xdg-open target/criterion/report/index.html

# Windows
start target/criterion/report/index.html
```

## 4. Try More Benchmarks

```bash
# Simple benchmarks (fast)
cargo bench --bench identity
cargo bench --bench fan_in
cargo bench --bench fan_out

# Complex benchmarks (slower)
cargo bench --bench join
cargo bench --bench reachability
```

## 5. Run All Benchmarks

```bash
# Full benchmark suite (~5-10 minutes)
cargo bench -p timely-differential-benchmarks
```

## Common Commands

### Run Specific Framework

```bash
# Only Timely Dataflow benchmarks
cargo bench -- timely

# Only Hydroflow benchmarks
cargo bench -- dfir_rs

# Only Differential Dataflow benchmarks
cargo bench -- differential
```

### Quick Testing

```bash
# Faster runs for testing (fewer samples)
cargo bench --bench arithmetic -- --sample-size 10

# Just check if it compiles
cargo check --all-targets
```

### Get Help

```bash
# Cargo help
cargo bench --help

# Criterion help
cargo bench --bench arithmetic -- --help
```

## What's Next?

- **Read detailed docs**: `benches/README.md`
- **View benchmark code**: `benches/benches/*.rs`
- **Learn to contribute**: `CONTRIBUTING.md`
- **Understand migration**: `MIGRATION.md`

## Troubleshooting

### Build takes too long?
```bash
# Use more CPU cores
cargo bench -j 8
```

### Dependency errors?
```bash
# Clean and retry
cargo clean
cargo bench --bench arithmetic
```

### Need local Hydroflow?
Edit `benches/Cargo.toml`:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

## Benchmark Overview

| Benchmark | Speed | Complexity | Best For |
|-----------|-------|------------|----------|
| identity | ⚡ Fast | 🟢 Simple | First run |
| arithmetic | ⚡ Fast | 🟢 Simple | Learning |
| fan_in | ⚡ Fast | 🟢 Simple | Patterns |
| fan_out | ⚡ Fast | 🟢 Simple | Patterns |
| fork_join | 🚀 Medium | 🟡 Medium | Patterns |
| upcase | 🚀 Medium | 🟡 Medium | String ops |
| join | 🐌 Slow | 🟡 Medium | Hash joins |
| reachability | 🐌 Slow | 🔴 Complex | Graph algorithms |

## Ready to Contribute?

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run benchmarks to verify
5. Submit a pull request

See `CONTRIBUTING.md` for detailed guidelines.

## Questions?

- **Documentation**: Check README.md
- **Benchmarks**: Check benches/README.md
- **Issues**: Create a GitHub issue
- **Discussions**: Use GitHub discussions

Happy benchmarking! 🚀
