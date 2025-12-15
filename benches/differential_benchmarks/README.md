# Differential Dataflow Benchmarks

This directory contains performance benchmarks for differential dataflow operations.

## Benchmarks

- **arrange_bench**: Tests performance of arranging data for indexed access
- **reduce_bench**: Tests performance of reduce operations on grouped data
- **iterate_bench**: Tests performance of iterative graph computations

## Running Benchmarks

```bash
# Run a single benchmark
cargo run --bin arrange_bench --release

# Run with multiple workers
cargo run --bin reduce_bench --release -- -w 4

# Run all benchmarks
for bench in arrange_bench reduce_bench iterate_bench; do
    cargo run --bin $bench --release
done
```
