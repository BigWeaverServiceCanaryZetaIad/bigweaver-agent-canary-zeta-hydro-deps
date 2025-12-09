# Quick Start Guide

This guide provides quick instructions for running comparative benchmarks between Hydro and other dataflow frameworks.

## Prerequisites

```bash
# Ensure Rust is installed
rustc --version

# Ensure you have the correct toolchain (specified in rust-toolchain.toml)
rustup show
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all benchmarks comparing Hydro (DFIR), Timely Dataflow, and Differential Dataflow implementations.

### Run Specific Benchmark

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run join benchmark
cargo bench -p benches --bench join

# Run identity benchmark
cargo bench -p benches --bench identity
```

### Filter by Framework

You can filter to run only specific framework implementations:

```bash
# Run only Hydro (DFIR) benchmarks
cargo bench -p benches --bench reachability -- dfir

# Run only Timely Dataflow benchmarks
cargo bench -p benches --bench reachability -- timely

# Run only Differential Dataflow benchmarks
cargo bench -p benches --bench reachability -- differential
```

## Understanding Results

Benchmark results are saved to `target/criterion/` with:

- **HTML reports**: Open `target/criterion/report/index.html` in a browser
- **Terminal output**: Statistical summary printed during benchmark execution
- **Comparison data**: If you run benchmarks multiple times, Criterion will show performance changes

### Example Output

```
reachability/dfir       time:   [1.2345 ms 1.2456 ms 1.2567 ms]
reachability/timely     time:   [2.3456 ms 2.3567 ms 2.3678 ms]
reachability/differential time: [3.4567 ms 3.4678 ms 3.4789 ms]
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Basic arithmetic operations |
| `fan_in` | Multiple inputs converging to single operator |
| `fan_out` | Single input distributing to multiple operators |
| `fork_join` | Fork-join patterns with filtering |
| `futures` | Async/futures-based operations |
| `identity` | Simple pass-through operations |
| `join` | Join operations between streams |
| `micro_ops` | Various micro-operations |
| `reachability` | Graph reachability computations |
| `symmetric_hash_join` | Symmetric hash join implementations |
| `upcase` | String transformation operations |
| `words_diamond` | Diamond-shaped dataflow graphs |

## Building Without Running

```bash
# Build all benchmarks
cargo build --release -p benches

# Check that code compiles
cargo check -p benches
```

## Common Issues

### Compilation Errors

If you encounter compilation errors:

1. Check that you have the correct Rust version: `rustup show`
2. Update dependencies: `cargo update`
3. Clean build artifacts: `cargo clean`

### Missing Dependencies

The benchmarks automatically pull `dfir_rs` and `sinktools` from the main Hydro repository via git dependencies. Ensure you have:

- Internet connection for git dependencies
- Git configured correctly
- Access to the main Hydro repository

## Next Steps

- See [README.md](README.md) for comprehensive documentation
- Check [Main Hydro Repository](https://github.com/hydro-project/hydro) for core framework details
- Review [BENCHMARKS_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARKS_MIGRATION.md) in the main repository for migration context
