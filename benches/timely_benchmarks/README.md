# Timely Dataflow Benchmarks

This directory contains performance benchmarks for timely dataflow operations.

## Benchmarks

- **fanout_bench**: Tests fan-out performance for distributing data across workers
- **join_bench**: Tests join operation performance on keyed streams
- **reachability_bench**: Tests graph reachability computation performance

## Running Benchmarks

```bash
# Run a single benchmark
cargo run --bin fanout_bench --release

# Run with multiple workers
cargo run --bin join_bench --release -- -w 4

# Run all benchmarks
for bench in fanout_bench join_bench reachability_bench; do
    cargo run --bin $bench --release
done
```
