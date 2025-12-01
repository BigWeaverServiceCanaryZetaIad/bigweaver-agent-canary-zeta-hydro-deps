# Contributing to Hydro Deps

This repository contains benchmarks and code that depend on external frameworks like timely and differential-dataflow. These dependencies are separated from the main Hydro repository to keep the main repository lightweight and focused.

## Repository Structure

* `benches/` - Microbenchmarks comparing DFIR with timely and differential-dataflow

## Running Benchmarks

To run benchmarks:

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench arithmetic

# Run with more iterations for more stable results
cargo bench -p benches -- --sample-size 100
```

## Dependencies

The benchmarks depend on packages from the main Hydro repository (dfir_rs, sinktools) which are pulled via git. This ensures:
- The main Hydro repository doesn't need timely/differential-dataflow dependencies
- Benchmarks can still test performance comparisons
- Performance comparison functionality is retained

## Making Changes

When updating benchmarks:
1. Ensure all benchmarks still compile and run
2. Test with `cargo bench -p benches` before committing
3. Follow the Conventional Commits specification for commit messages
4. Consider documenting significant performance changes in commit messages
