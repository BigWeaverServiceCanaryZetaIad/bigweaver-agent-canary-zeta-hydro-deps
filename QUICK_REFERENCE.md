# Quick Reference Guide

## Essential Commands

### Verify Setup
```bash
bash verify_setup.sh
```

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

### Quick Test (Fast)
```bash
cargo bench -- --test
```

### Save Baseline
```bash
cargo bench -- --save-baseline my-baseline
```

### Compare Against Baseline
```bash
cargo bench -- --baseline my-baseline
```

---

## Benchmark List

| Benchmark | Framework | Purpose |
|-----------|-----------|---------|
| arithmetic | Timely | Pipeline arithmetic operations |
| fan_in | Timely | Stream concatenation |
| fan_out | Timely | Stream distribution |
| fork_join | Timely | Parallel fork-join patterns |
| identity | Timely | Framework overhead |
| join | Timely | Two-stream joins |
| upcase | Timely | String operations |
| reachability | Differential | Graph reachability |

---

## File Locations

### Documentation
- **Main Guide**: `README.md`
- **Benchmark Details**: `benches/README.md`
- **Performance Comparison**: `BENCHMARK_GUIDE.md`
- **Contributing**: `CONTRIBUTING.md`
- **Migration Info**: `MIGRATION_SUMMARY.md`

### Benchmarks
- **Source Files**: `benches/benches/*.rs`
- **Data Files**: `benches/benches/*.txt`
- **Build Script**: `benches/build.rs`

### Configuration
- **Workspace**: `Cargo.toml`
- **Benchmarks**: `benches/Cargo.toml`
- **Rust Version**: `rust-toolchain.toml`

---

## Common Tasks

### View HTML Reports
```bash
open target/criterion/report/index.html
# Or navigate to specific benchmark:
# target/criterion/<benchmark-name>/report/index.html
```

### Check Compilation
```bash
cargo check
```

### Clean Build
```bash
cargo clean
cargo build --release
```

### Run Single Test
```bash
cargo bench --bench arithmetic -- timely
```

### Profile with Flamegraph
```bash
cargo install flamegraph
cargo flamegraph --bench arithmetic
```

---

## Dependencies

### Core
- `timely-master = "0.13.0-dev.1"`
- `differential-dataflow-master = "0.13.0-dev.1"`
- `criterion = "0.5.0"`

### Runtime
- `tokio = "1.29.0"`
- `futures = "0.3"`

---

## Help

### Documentation
- Quick Start: See `README.md`
- Detailed Guide: See `benches/README.md`
- Performance Analysis: See `BENCHMARK_GUIDE.md`
- Contributing: See `CONTRIBUTING.md`

### Troubleshooting
- Check `benches/README.md` → Troubleshooting section
- Check `BENCHMARK_GUIDE.md` → Troubleshooting section
- Run `bash verify_setup.sh` to verify setup

### Issues
- Verify all files with: `bash verify_setup.sh`
- Check compilation with: `cargo check`
- Try clean build: `cargo clean && cargo build`

---

## Typical Workflow

### 1. Initial Setup
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
bash verify_setup.sh
```

### 2. Establish Baseline
```bash
cargo bench -- --save-baseline initial
```

### 3. Make Changes
```bash
# Edit benchmark files or make changes
```

### 4. Compare Performance
```bash
cargo bench -- --baseline initial
```

### 5. Review Results
```bash
# Check console output or HTML reports
open target/criterion/report/index.html
```

---

## Performance Tips

### Quick Test
Use `--test` for fast validation:
```bash
cargo bench -- --test
```

### Specific Benchmarks
Run only what you need:
```bash
cargo bench --bench arithmetic
```

### Filter Tests
Filter by name:
```bash
cargo bench -- timely
cargo bench -- dfir_rs
```

### Adjust Duration
Modify measurement time:
```bash
cargo bench -- --measurement-time 10
```

---

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace config
├── README.md               # Main guide
├── BENCHMARK_GUIDE.md      # Performance guide
├── QUICK_REFERENCE.md      # This file
├── verify_setup.sh         # Verification script
└── benches/                # Benchmarks
    ├── Cargo.toml          # Dependencies
    ├── README.md           # Benchmark docs
    ├── build.rs            # Build script
    └── benches/            # Implementations
        ├── *.rs            # 8 benchmarks
        └── *.txt           # 2 data files
```

---

## Exit Codes

### verify_setup.sh
- `0` - All checks passed
- `1` - Some checks failed

### cargo bench
- `0` - Success
- `101` - Benchmark failed
- Other - Compilation or runtime error

---

## Links

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Project](https://github.com/hydro-project/hydro)

---

**For Complete Information**: See `README.md` and `BENCHMARK_GUIDE.md`
