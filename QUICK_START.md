# Quick Start Guide

## Overview

This repository contains performance benchmarks for timely and differential-dataflow implementations, allowing comparison with Hydroflow implementations in the main repository.

## Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in main repo for version)
- Main hydro repository cloned at `../bigweaver-agent-canary-hydro-zeta/`

## Quick Commands

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
# Run reachability (differential-dataflow)
cargo bench -p benches --bench reachability

# Run arithmetic (timely)
cargo bench -p benches --bench arithmetic

# Run join (timely)
cargo bench -p benches --bench join
```

### Run Specific Test
```bash
# Run only timely version of arithmetic benchmark
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"

# Run only differential version of reachability
cargo bench -p benches --bench reachability -- "reachability/differential"
```

### Compare with Hydroflow
```bash
# Run automated comparison
./compare_benchmarks.sh

# Or manually:
# 1. Run benchmarks here
cargo bench -p benches

# 2. Run benchmarks in main repo
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# 3. Compare results in target/criterion/ directories
```

## Available Benchmarks

### Timely Dataflow
- **arithmetic** - Pipeline arithmetic operations (20 sequential adds)
- **fan_in** - Multiple streams merging into one
- **fan_out** - One stream splitting into multiple
- **fork_join** - Fork-join with filtering and union
- **identity** - No-op operations (measures framework overhead)
- **join** - Two-stream join operations
- **upcase** - String uppercase transformations

### Differential Dataflow
- **reachability** - Graph reachability with iterative computation

## Benchmark Comparisons

Each benchmark typically includes multiple implementations:

- **timely** or **differential** - The timely/differential-dataflow implementation
- **dfir_rs/surface** - Hydroflow surface syntax (from main repo)
- **dfir_rs/compiled** - Hydroflow compiled API (from main repo)
- **raw** - Baseline Rust implementation
- **iter** - Iterator-based implementation
- **pipeline** - Thread-based pipeline

Use these to compare performance characteristics across different approaches.

## Output

Benchmark results are saved to:
```
target/criterion/<benchmark_name>/<test_name>/
```

Each directory contains:
- `report/index.html` - Visual report
- `base/` - Raw measurement data
- Performance statistics and plots

## Troubleshooting

### Main repository not found
```
error: failed to load manifest for dependency `dfir_rs`
```
**Solution**: Ensure the main hydro repository is at `../bigweaver-agent-canary-hydro-zeta/`

### Compilation errors
```
error: could not compile `timely-master`
```
**Solution**: 
1. Clear cargo cache: `cargo clean`
2. Update dependencies: `cargo update`
3. Check rust version matches main repo

### Benchmark failures
```
thread 'main' panicked at 'assertion failed'
```
**Solution**: Check that data files are present in `benches/benches/`:
- `reachability_edges.txt`
- `reachability_reachable.txt`
- `words_alpha.txt`

## Next Steps

- Read [MIGRATION.md](MIGRATION.md) for detailed migration documentation
- Read [README.md](README.md) for comprehensive repository overview
- Check main repository documentation for Hydroflow details

## Links

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion.rs: https://bheisler.github.io/criterion.rs/book/
