# Timely/Differential-Dataflow Comparison Benchmarks

This directory contains benchmarks for comparing Hydro implementations with timely and differential-dataflow implementations.

## Overview

This repository is designed to hold benchmarks that use timely and differential-dataflow dependencies for performance comparison with the Hydro-native implementations in the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Available Benchmarks

The following benchmarks are available for implementing timely/differential-dataflow comparison versions:

- **micro_ops** - Micro-operations benchmark (currently Hydro-native, ready for timely/differential implementations)
- **symmetric_hash_join** - Symmetric hash join benchmark (currently Hydro-native, ready for timely/differential implementations)
- **words_diamond** - Word processing diamond pattern benchmark (currently Hydro-native, ready for timely/differential implementations)
- **futures** - Futures-based operations benchmark (currently Hydro-native, ready for timely/differential implementations)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench futures
```

## Performance Comparison Workflow

### Step 1: Run Hydro-Native Benchmarks
From the main repository:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

Results will be saved in `target/criterion/` directory.

### Step 2: Run Timely/Differential-Dataflow Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

Results will be saved in `target/criterion/` directory.

### Step 3: Compare Results
Use Criterion's built-in comparison tools or manually compare the results from both repositories to evaluate performance characteristics.

## Dependencies

This package includes the following key dependencies:
- **differential-dataflow-master** (version 0.13.0-dev.1) - For differential dataflow implementations
- **timely-master** (version 0.13.0-dev.1) - For timely dataflow implementations
- **criterion** - Benchmarking framework with statistical analysis
- **tokio** - Async runtime
- **futures** - Futures and async utilities
- **rand** - Random number generation for test data

## Data Files

- **words_alpha.txt** - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt, used by the words_diamond benchmark

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Implement both Hydro-native and timely/differential versions for comparison
3. Add a `[[bench]]` entry in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```

## Architecture

This repository is part of a split architecture:
- **Main Repository** ([bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)) - Contains core Hydro implementations without external dataflow dependencies
- **Deps Repository** (this repository) - Contains benchmarks with timely/differential-dataflow dependencies for performance comparison

This separation:
- Reduces build dependencies and improves build times for the main repository
- Maintains the ability to run performance comparisons
- Provides a clear architectural boundary between implementations
- Enables independent evolution of benchmarking strategies

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native implementations and benchmarks
