# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for performance comparison between Hydroflow/dfir_rs and timely/differential-dataflow implementations.

## Overview

These benchmarks were moved from the `bigweaver-agent-canary-hydro-zeta` repository to maintain a clear separation of dependencies. The main repository should not depend on timely and differential-dataflow packages, so these comparative benchmarks are maintained here.

## Available Benchmarks

### Dataflow Pattern Benchmarks

| Benchmark | Description | Implementations |
|-----------|-------------|-----------------|
| `arithmetic` | Pipeline arithmetic operations | timely, dfir_rs, raw |
| `fan_in` | Multiple sources to single destination | timely, dfir_rs |
| `fan_out` | Single source to multiple destinations | timely, dfir_rs |
| `fork_join` | Fork data, process independently, then join | timely, dfir_rs |
| `identity` | Pass-through operation (baseline) | timely, dfir_rs |
| `join` | Join two streams | timely, dfir_rs |
| `upcase` | String uppercase transformation | timely, dfir_rs |

### Graph Algorithm Benchmarks

| Benchmark | Description | Implementations |
|-----------|-------------|-----------------|
| `reachability` | Graph reachability computation | differential-dataflow, dfir_rs |

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed. The benchmarks use Criterion for performance measurement.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run reachability benchmark  
cargo bench -p benches --bench reachability

# Run identity benchmark
cargo bench -p benches --bench identity
```

### Run with Specific Filters

```bash
# Run only timely implementations
cargo bench -p benches -- timely

# Run only dfir_rs implementations
cargo bench -p benches -- dfir

# Run a specific test within a benchmark
cargo bench -p benches --bench arithmetic -- pipeline
```

## Benchmark Data Files

Some benchmarks require data files:

- `reachability_edges.txt` - Graph edges for reachability benchmark (536 KB)
- `reachability_reachable.txt` - Expected reachable nodes for verification (41 KB)

These files are included in the repository and will be automatically used by the benchmarks.

## Performance Comparison

The benchmarks are designed to enable direct performance comparison between:

1. **Timely Dataflow**: The original timely-dataflow implementation
2. **Differential Dataflow**: For incremental computation benchmarks
3. **DFIR/Hydroflow**: The Hydro project's dataflow implementation

Each benchmark typically includes multiple implementations to compare:
- Raw/baseline implementation
- Timely dataflow implementation
- DFIR/Hydroflow implementation

## Understanding Results

Criterion generates detailed HTML reports in `target/criterion/`. After running benchmarks:

1. Open `target/criterion/report/index.html` in a browser
2. View detailed statistics, plots, and comparisons
3. Look for throughput measurements and latency distributions

Key metrics to compare:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Scalability**: Performance with varying input sizes

## Dependencies

This package depends on:

- `timely` (timely-master 0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` - Hydroflow dataflow implementation
- `criterion` - Benchmarking framework
- `sinktools` - Utility tools

## Build Configuration

The benchmarks use a custom `build.rs` script to generate optimized code for fork-join patterns. This script creates specialized code based on the `NUM_OPS` constant defined in the benchmarks.

## Notes

- All benchmarks use `harness = false` to use Criterion's custom harness
- Benchmarks are configured to run with async tokio and generate HTML reports
- Some benchmarks generate large amounts of data - ensure sufficient disk space for reports

## Related Documentation

- [Hydroflow Documentation](https://hydro.run/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)

## Migration Notes

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` to maintain clean dependency separation. See the main repository's `REMOVAL_SUMMARY.md` for details on the migration.
