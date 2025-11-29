# Quick Start Guide

## Prerequisites

Both repositories must be cloned side-by-side:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Basic Commands

### Run All Benchmarks
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

### Run Benchmarks Matching Pattern
```bash
cargo bench -p benches -- dfir
cargo bench -p benches -- micro/ops/
```

### Check Build
```bash
cargo check -p benches
```

### Clean Build Artifacts
```bash
cargo clean
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| arithmetic | Arithmetic operation benchmarks |
| fan_in | Fan-in pattern benchmarks |
| fan_out | Fan-out pattern benchmarks |
| fork_join | Fork-join pattern benchmarks |
| futures | Futures integration benchmarks |
| identity | Identity transformation benchmarks |
| join | Join operation benchmarks |
| micro_ops | Micro-operation benchmarks |
| reachability | Graph reachability benchmarks |
| symmetric_hash_join | Symmetric hash join benchmarks |
| upcase | String uppercase benchmarks |
| words_diamond | Word processing diamond pattern |

## Viewing Results

Benchmark results are saved in `target/criterion/` with HTML reports.

Open in browser:
```bash
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Performance Comparison

Save a baseline:
```bash
cargo bench -p benches -- --save-baseline my-baseline
```

Compare against baseline:
```bash
cargo bench -p benches -- --baseline my-baseline
```

## Troubleshooting

**Error: "no such file or directory"**
- Ensure main repository is cloned alongside this one
- Check paths in `benches/Cargo.toml`

**Error: "failed to compile"**
- Check Rust toolchain version (see main repo's `rust-toolchain.toml`)
- Try: `cargo clean && cargo build -p benches`

**Slow benchmark execution**
- This is normal for comprehensive benchmarks
- Use specific benchmarks to reduce time
- Criterion runs multiple iterations for statistical accuracy

## Documentation

- `README.md` - Repository overview
- `BENCHMARK_GUIDE.md` - Comprehensive benchmark guide
- `MIGRATION_SUMMARY.md` - Migration details from main repository
- `benches/README.md` - Basic benchmark usage

## Support

For issues or questions:
1. Check documentation files above
2. Review error messages for path/dependency issues
3. Verify repository structure matches prerequisites
