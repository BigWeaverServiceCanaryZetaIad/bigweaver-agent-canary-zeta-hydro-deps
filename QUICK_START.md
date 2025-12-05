# Quick Start Guide

## Prerequisites
- Rust toolchain installed
- Git access to the main repository

## Basic Usage

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench reachability
```

### Run with Baseline Comparison
```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline before

# Make changes in main repo, update dependencies, then:
cargo bench -p benches -- --baseline before
```

## Available Benchmarks

| Command | Description |
|---------|-------------|
| `cargo bench -p benches --bench arithmetic` | Arithmetic operations |
| `cargo bench -p benches --bench fan_in` | Fan-in pattern |
| `cargo bench -p benches --bench fan_out` | Fan-out pattern |
| `cargo bench -p benches --bench fork_join` | Fork-join pattern |
| `cargo bench -p benches --bench futures` | Futures operations |
| `cargo bench -p benches --bench identity` | Identity baseline |
| `cargo bench -p benches --bench join` | Join operations |
| `cargo bench -p benches --bench micro_ops` | Micro-operations |
| `cargo bench -p benches --bench reachability` | Graph reachability |
| `cargo bench -p benches --bench symmetric_hash_join` | Hash join |
| `cargo bench -p benches --bench upcase` | String operations |
| `cargo bench -p benches --bench words_diamond` | Word processing |

## View Results

Benchmark results are saved in `target/criterion/`. Open HTML reports:
```bash
open target/criterion/report/index.html
```

## Update Dependencies

To test against a specific version of the main repository:

1. Edit `benches/Cargo.toml`
2. Update git dependency with specific commit:
   ```toml
   dfir_rs = { git = "...", rev = "abc123", features = [ "debugging" ] }
   ```
3. Run `cargo update`
4. Run benchmarks

## More Information

- See [README.md](README.md) for detailed documentation
- See [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) for migration details
- See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
