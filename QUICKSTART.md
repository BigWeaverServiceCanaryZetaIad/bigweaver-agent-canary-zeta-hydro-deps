# Quick Start Guide

## Run All Benchmarks

```bash
cargo bench -p benches
```

## Run Specific Benchmark

```bash
cargo bench -p benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `futures`
- `identity`
- `join`
- `micro_ops`
- `reachability`
- `symmetric_hash_join`
- `upcase`
- `words_diamond`

## Quick Run (Fewer Samples)

```bash
cargo bench -p benches -- --quick
```

## Build Without Running

```bash
cargo build --release -p benches
```

## View Results

Results are saved in `target/criterion/` with HTML reports.

## Common Commands

```bash
# Test compilation
cargo check -p benches

# Run tests
cargo test -p benches

# Clean build artifacts
cargo clean

# Update dependencies
cargo update
```
