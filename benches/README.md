# Timely Dataflow and Differential Dataflow Benchmarks

This directory contains performance benchmarks comparing Hydro (DFIR) with Timely Dataflow and Differential Dataflow implementations.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on `timely` and `differential-dataflow` packages. This separation allows the main repository to remain lightweight while still maintaining the ability to run performance comparisons.

## Available Benchmarks

- **arithmetic**: Arithmetic operations pipeline benchmark
- **fan_in**: Fan-in dataflow pattern benchmark
- **fan_out**: Fan-out dataflow pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercase transformation benchmark

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

To run a specific test within a benchmark:

```bash
cargo bench --bench arithmetic -- dfir_rs
cargo bench --bench reachability -- timely
```

## Benchmark Structure

Each benchmark typically contains multiple implementations:

1. **DFIR (Hydro)** - The Hydro framework implementation
2. **Timely** - Timely Dataflow implementation  
3. **Differential** - Differential Dataflow implementation (where applicable)

This allows for direct performance comparisons between frameworks.

## Output

Benchmarks use the Criterion framework and generate:
- Console output with performance statistics
- HTML reports in `target/criterion/`
- Historical comparison data for tracking performance over time

## Notes

- Wordlist data (for string benchmarks) is from https://github.com/dwyl/english-words
- Graph data files (e.g., `reachability_edges.txt`) are included in this directory
- Some benchmarks may require specific input data files located in `benches/benches/`

## Migration Context

These benchmarks were previously located in the main `bigweaver-agent-canary-hydro-zeta` repository under the `dfir_rs/benches` directory. They were moved to this separate repository to:

- Remove timely/differential-dataflow dependencies from the main repo
- Improve build times for the main repository
- Maintain the ability to run comparative benchmarks
- Keep the main repository focused on Hydro/DFIR development

For more details on the migration, see [BENCHMARK_MIGRATION.md](../BENCHMARK_MIGRATION.md) in the root of this repository.
