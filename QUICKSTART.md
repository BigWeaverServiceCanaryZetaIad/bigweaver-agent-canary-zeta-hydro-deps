# Quick Start Guide

## Welcome to Hydro Benchmarks Repository

This repository contains all Hydro performance benchmarks, migrated from the main repository for dedicated performance testing and analysis.

## 🚀 Quick Start

### 1. Run All Benchmarks
```bash
cd benches
cargo bench
```

### 2. Run Specific Benchmark
```bash
cd benches
cargo bench --bench micro_ops
```

### 3. View Results
```bash
firefox target/criterion/report/index.html
```

## 📊 Available Benchmarks

| Benchmark | Description | What It Tests |
|-----------|-------------|---------------|
| `micro_ops` | Micro-operations | Basic dataflow operations (map, filter, fold, etc.) |
| `symmetric_hash_join` | Hash join | Join performance and hash strategies |
| `words_diamond` | Diamond pattern | Complex dataflow with real-world data |
| `futures` | Async operations | Futures handling and async overhead |

## 🛠️ Setup Requirements

### Path Dependencies

This repository requires two local dependencies:
- `dfir_rs` - Should be at `../dfir_rs`
- `sinktools` - Should be at `../sinktools`

If these aren't available, you'll need to:
1. Clone them to the parent directory, OR
2. Adjust paths in `benches/Cargo.toml`, OR
3. Contact the repository maintainer for workspace setup

### System Requirements
- Rust toolchain (stable)
- Cargo
- ~4GB disk space (for word data and compiled artifacts)

## 📖 Documentation

- **README.md** - Repository overview and structure
- **benches/README.md** - Detailed benchmark documentation
- **MIGRATION.md** - Migration history from main repository
- **COMPARISON_GUIDE.md** - How to compare performance results

## 🎯 Common Tasks

### Run Quick Test (Faster)
```bash
cd benches
cargo bench -- --quick
```

### Run with Script (Organized Output)
```bash
./scripts/run_benchmarks.sh
```

### Compare with Baseline
```bash
cd benches
cargo bench -- --save-baseline my_baseline
# Make changes...
cargo bench -- --baseline my_baseline
```

### Check Compilation Only
```bash
cd benches
cargo build --benches
```

## 🔍 Understanding Results

### Criterion Output Example
```
micro/ops/identity      time:   [123.45 µs 124.56 µs 125.67 µs]
                        change: [-2.5% -1.2% +0.3%] (p = 0.15 > 0.05)
```

- **time**: [lower_bound average upper_bound]
- **change**: Performance difference from previous run
- **p-value**: Statistical significance

### Result Colors
- 🟢 Green = Performance improved
- 🔴 Red = Performance regressed  
- 🟡 Yellow = No significant change

## 🏗️ Repository Structure

```
.
├── benches/                    # Benchmark package
│   ├── Cargo.toml             # Dependencies
│   ├── README.md              # Benchmark details
│   └── benches/               # Benchmark code
│       ├── micro_ops.rs
│       ├── symmetric_hash_join.rs
│       ├── words_diamond.rs
│       ├── futures.rs
│       └── words_alpha.txt    # Test data (3.7MB)
├── scripts/
│   └── run_benchmarks.sh      # Automated runner
├── README.md                  # Repository overview
├── QUICKSTART.md              # This file
├── MIGRATION.md               # Migration history
└── COMPARISON_GUIDE.md        # Performance comparison guide
```

## ⚠️ Troubleshooting

### "Cannot find dfir_rs"
- Ensure dfir_rs is in parent directory: `../dfir_rs`
- Or adjust path in `benches/Cargo.toml`

### "Benchmarks take too long"
- Use `--quick` flag for faster iterations
- Or run specific benchmarks only

### "Results vary widely"
- Close background applications
- Run multiple times
- Check CPU thermal throttling
- See COMPARISON_GUIDE.md for best practices

## 🔗 Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
  - Core Hydro implementation
  - No benchmark dependencies
  - Optimized for fast development builds

## 💡 Tips

1. **First run is slower**: Criterion establishes baseline
2. **Use HTML reports**: Much more detail than terminal output
3. **Save baselines**: For comparing across branches
4. **Run consistently**: Same hardware, minimal background processes
5. **Check p-values**: < 0.05 means statistically significant change

## 🎓 Learning More

- Read `COMPARISON_GUIDE.md` for performance analysis techniques
- Check `benches/README.md` for detailed benchmark descriptions
- See [Criterion.rs docs](https://bheisler.github.io/criterion.rs/book/) for framework details

## 📞 Need Help?

Check the documentation files or refer to the main repository for support.

---

**Ready to benchmark? Start with:** `cd benches && cargo bench`
