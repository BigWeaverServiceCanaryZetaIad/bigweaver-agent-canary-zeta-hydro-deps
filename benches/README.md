# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks comparing Hydro/DFIR performance with timely-dataflow and differential-dataflow.

## Benchmarks

- **arithmetic** - Basic arithmetic operations across different frameworks
- **fan_in** - Multiple inputs merging into a single stream
- **fan_out** - Single input splitting into multiple streams
- **fork_join** - Fork-join patterns with parallel processing
- **identity** - Identity transformation (baseline performance)
- **join** - Join operations between streams
- **reachability** - Graph reachability algorithms
- **upcase** - String transformation benchmarks

## Running

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench arithmetic
```

## Results

Benchmark results are saved in `target/criterion/` with HTML reports for visualization.
