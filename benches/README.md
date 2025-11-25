# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks for timely and differential-dataflow implementations.

## Directory Structure

```
benches/
├── Cargo.toml              # Benchmark package configuration
├── build.rs                # Build script for code generation
├── README.md               # This file
└── benches/                # Benchmark implementations
    ├── arithmetic.rs       # Arithmetic operations (timely)
    ├── fan_in.rs           # Fan-in pattern (timely)
    ├── fan_out.rs          # Fan-out pattern (timely)
    ├── fork_join.rs        # Fork-join pattern (timely)
    ├── identity.rs         # Identity operations (timely)
    ├── join.rs             # Join operations (timely)
    ├── upcase.rs           # String transformations (timely)
    ├── reachability.rs     # Graph reachability (differential)
    ├── reachability_edges.txt          # Graph data
    └── reachability_reachable.txt      # Expected results
```

## Running Benchmarks

### From Repository Root

```bash
# Run all benchmarks
cargo bench -p timely-differential-benchmarks

# Run specific benchmark
cargo bench -p timely-differential-benchmarks --bench arithmetic
```

### From This Directory

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

## Benchmark Categories

### Timely Dataflow Benchmarks

- **arithmetic**: Tests arithmetic pipeline performance
- **fan_in**: Tests multi-input merge patterns
- **fan_out**: Tests single-input broadcast patterns
- **fork_join**: Tests fork-join with filtering
- **identity**: Tests pass-through overhead
- **join**: Tests stream join operations
- **upcase**: Tests string transformations

### Differential Dataflow Benchmarks

- **reachability**: Tests iterative graph computation

## Dependencies

All benchmarks use:
- **Criterion** for benchmarking framework
- **Timely** for dataflow operations
- **Differential Dataflow** for incremental computation
- **dfir_rs** for Hydro comparison implementations
- **sinktools** for utility functions

See `Cargo.toml` for complete dependency list.

## Build Script

The `build.rs` script generates optimized code for the `fork_join` benchmark at compile time. It creates a file `benches/fork_join_20.hf` containing the complete pipeline definition.

## Adding New Benchmarks

1. Create a new `.rs` file in `benches/` directory
2. Add benchmark entry to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Run the benchmark to verify:
   ```bash
   cargo bench --bench your_benchmark
   ```

## Results

Benchmark results are saved in:
```
target/criterion/
```

View HTML reports:
```bash
open target/criterion/report/index.html
```

## Troubleshooting

### Build Issues

```bash
# Clean and rebuild
cargo clean
cargo build --all-targets
```

### Missing Dependencies

Ensure you have Rust installed:
```bash
rustc --version
cargo --version
```

### Slow First Build

The first build downloads and compiles all dependencies, which can take several minutes. Subsequent builds are much faster due to caching.

## Documentation

For more information, see:
- [Repository README](../README.md)
- [Quick Start Guide](../QUICKSTART.md)
- [Benchmark Details](../BENCHMARK_DETAILS.md)
