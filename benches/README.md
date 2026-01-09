# Timely and Differential Dataflow Benchmarks

This directory contains benchmark implementations using timely-dataflow and differential-dataflow.

## Benchmarks

### arithmetic.rs
Performance benchmarks for arithmetic operations (map operations) using timely-dataflow.

### fan_in.rs
Benchmarks for fan-in patterns (multiple inputs merging into one) using timely-dataflow.

### reachability.rs
Graph reachability benchmarks using both:
- timely-dataflow (using feedback loops)
- differential-dataflow (using iterate operator)

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench reachability
```

## Dependencies

- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)
- `criterion` for benchmark harness

## Performance Comparison

These benchmarks are designed to enable performance comparisons with the Hydro/DFIR implementations that remain in the bigweaver-agent-canary-hydro-zeta repository.
