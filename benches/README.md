# Benchmarks

This directory contains performance benchmarks comparing timely-dataflow, differential-dataflow, and Hydroflow implementations.

## Available Benchmarks

### Stream Processing Patterns

- **arithmetic**: Chain of arithmetic operations across different frameworks
- **identity**: Pass-through benchmark measuring framework overhead  
- **fan_in**: Multiple streams merging into one
- **fan_out**: Single stream splitting into multiple outputs
- **fork_join**: Fork-join parallelism patterns
- **join**: Stream join operations
- **upcase**: String transformation operations

### Graph Processing

- **reachability**: Graph reachability using timely and differential-dataflow

## Running Benchmarks

### Run all benchmarks
```bash
cargo bench
```

### Run a specific benchmark
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

### Run benchmarks matching a pattern
```bash
# Run only timely benchmarks
cargo bench timely

# Run only hydroflow benchmarks  
cargo bench dfir_rs

# Run arithmetic benchmarks
cargo bench arithmetic
```

## Benchmark Structure

Each benchmark file typically contains multiple test functions comparing:

1. **Raw implementations**: Baseline Rust without dataflow frameworks
2. **Iterator-based**: Using Rust's iterator chains
3. **Timely Dataflow**: Using timely-dataflow framework
4. **Differential Dataflow**: Using differential-dataflow (where applicable)
5. **Hydroflow variants**: Both compiled and surface syntax

## Output

Benchmarks use Criterion.rs which provides:
- Statistical analysis of performance
- HTML reports in `target/criterion/`
- Performance regression detection
- Comparison with previous runs

## Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `Cargo.toml`
3. Follow the existing benchmark patterns
4. Use `criterion::criterion_group!` and `criterion::criterion_main!` macros
5. Set `harness = false` in the Cargo.toml entry
