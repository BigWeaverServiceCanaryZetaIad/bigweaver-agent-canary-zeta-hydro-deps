# Comparison Benchmarks

This directory contains benchmarks comparing DFIR with timely-dataflow and differential-dataflow.

## Overview

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a clean separation of dependencies. The main repository now contains only DFIR-native benchmarks.

## Benchmarks

- **arithmetic.rs** - Basic arithmetic operations comparison
- **fan_in.rs** - Fan-in dataflow patterns
- **fan_out.rs** - Fan-out dataflow patterns  
- **fork_join.rs** - Fork-join patterns
- **identity.rs** - Identity transformation benchmarks
- **join.rs** - Join operation benchmarks
- **reachability.rs** - Graph reachability algorithms
- **upcase.rs** - String transformation benchmarks

## Running Benchmarks

### Prerequisites

This repository depends on the main repository for DFIR implementation. Ensure both repositories are cloned in the same parent directory:

```
parent-dir/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run a specific benchmark file
cargo bench -p benches --bench arithmetic

# Run benchmarks matching a pattern
cargo bench -p benches -- dfir_rs
cargo bench -p benches -- timely
cargo bench -p benches -- differential
```

### Benchmark Options

Criterion provides various options:

```bash
# Run faster (fewer iterations)
cargo bench -p benches -- --quick

# Save baseline for comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

## Performance Comparison Workflow

To compare DFIR performance changes against timely-dataflow and differential-dataflow:

1. **Establish a baseline** (before changes):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches -- --save-baseline before
   ```

2. **Make changes** in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   # ... make your changes to DFIR ...
   ```

3. **Run comparison benchmarks**:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches -- --baseline before
   ```

The benchmarks will use your local DFIR changes via the path dependency and show performance differences.

## Understanding Results

Each benchmark typically includes implementations for:
- **dfir_rs/compiled** - DFIR's compiled (push-based) execution
- **dfir_rs/scheduled** - DFIR's scheduled execution  
- **timely** - Timely-dataflow implementation
- **differential** - Differential-dataflow implementation

Results show throughput (ops/sec) for each implementation, allowing direct comparison.

## Adding New Benchmarks

To add a new comparison benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Implement comparison functions for DFIR, timely, and differential-dataflow
3. Add a `[[bench]]` entry in `Cargo.toml`
4. Follow the existing benchmark structure for consistency

## Notes

- Benchmark results can vary significantly based on hardware and system load
- Run benchmarks multiple times for statistical significance
- Use `--save-baseline` to track performance over time
- The benchmarks use criterion for detailed statistical analysis
