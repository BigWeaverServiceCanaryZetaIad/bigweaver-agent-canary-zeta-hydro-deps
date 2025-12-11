# Contributing to bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains performance benchmarks for comparing DFIR with timely-dataflow and differential-dataflow implementations.

## Benchmark Structure

All benchmarks are located in the `benches/` directory and follow the Criterion.rs benchmarking framework.

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Follow the existing benchmark patterns for consistency
4. Ensure both DFIR and timely/differential implementations are included for comparison

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic

# Run with additional criterion options
cargo bench -p benches -- --verbose
```

### Benchmark Guidelines

- Use consistent input sizes across DFIR and timely/differential implementations
- Include multiple variants when testing different patterns (e.g., compiled vs scheduled)
- Document any external data files needed (like reachability_edges.txt)
- Use `black_box()` to prevent compiler optimizations from skipping work
- Add comments explaining what each benchmark variant tests

## Performance Comparison Workflow

1. Run benchmarks in this repository to capture timely/differential-dataflow performance
2. Run DFIR-only benchmarks in the main bigweaver-agent-canary-hydro-zeta repository
3. Compare results using Criterion's HTML reports (found in `target/criterion/`)
4. Look for relative performance differences rather than absolute numbers
5. Document significant findings in benchmark comments or separate documentation

## Dependencies

The benchmarks depend on:
- `dfir_rs` - Pulled from the main bigweaver-agent-canary-hydro-zeta repository
- `timely` (timely-master) - Timely-dataflow for comparison
- `differential-dataflow` (differential-dataflow-master) - Differential-dataflow for comparison
- `criterion` - Benchmarking framework

## Testing

Before submitting changes:
```bash
# Ensure benchmarks compile
cargo check -p benches

# Run benchmarks to verify they work
cargo bench -p benches
```
