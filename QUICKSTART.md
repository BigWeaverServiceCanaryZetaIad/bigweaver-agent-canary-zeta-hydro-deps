# Quick Start Guide

## Prerequisites

Ensure you have Rust installed with the correct toolchain (specified in `rust-toolchain.toml`).

## Running Benchmarks

### Run all benchmarks
```bash
cargo bench -p benches
```

### Run a specific benchmark
```bash
cargo bench -p benches --bench <benchmark_name>
```

Examples:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

### List available benchmarks
```bash
ls benches/benches/*.rs
```

## Benchmark Output

Benchmark results are generated in HTML format and can be found in:
```
target/criterion/
```

Open `target/criterion/report/index.html` in a browser to view detailed results.

## Development

### Check code formatting
```bash
cargo fmt --check
```

### Run linting
```bash
cargo clippy
```

### Format code
```bash
cargo fmt
```

## Notes

- The benchmarks depend on the main hydro repository for `dfir_rs` and `sinktools`
- Large data files (e.g., `words_alpha.txt`, `reachability_edges.txt`) are included for benchmarks
- Benchmark execution may take several minutes depending on your hardware
