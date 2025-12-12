# Benchmarks Directory

This directory contains benchmark crates for performance testing that require external dataflow dependencies.

## Structure

- **dataflow_benchmarks/** - Benchmarks using timely and differential-dataflow
- **integration_benchmarks/** - Cross-system performance tests

## Adding a New Benchmark

1. Create a new crate in this directory:
   ```bash
   cargo new --lib benchmarks/my_benchmark
   ```

2. Add it to the workspace in the root `Cargo.toml`:
   ```toml
   members = [
       "benchmarks/my_benchmark",
   ]
   ```

3. Configure the benchmark's Cargo.toml with necessary dependencies

4. Implement your benchmarks in `benches/` directory within the crate

5. Document the benchmark in the main `BENCHMARKS.md` file

## Current Status

No benchmark crates have been created yet. This repository is ready to receive benchmark code when timely or differential-dataflow dependencies are needed for performance testing.

Benchmark files from the main repository (bigweaver-agent-canary-hydro-zeta) can be migrated here when they require these external dependencies.
