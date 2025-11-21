# bigweaver-agent-canary-zeta-hydro-deps

Comprehensive benchmarks for timely-dataflow and differential-dataflow frameworks.

## Overview

This repository contains performance benchmarks for:
- **Timely Dataflow**: A low-latency data-parallel dataflow system
- **Differential Dataflow**: An incremental computation framework built on timely dataflow

## Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── timely-benchmarks/          # Timely dataflow benchmarks
│   └── benches/
│       ├── barrier.rs          # Barrier synchronization performance
│       ├── exchange.rs         # Data exchange patterns
│       ├── dataflow_construction.rs  # Dataflow graph construction overhead
│       ├── progress_tracking.rs      # Progress tracking performance
│       └── unary_operators.rs        # Basic operator performance
├── differential-benchmarks/    # Differential dataflow benchmarks
│   └── benches/
│       ├── arrange.rs          # Data arrangement performance
│       ├── join.rs             # Join operations
│       ├── count.rs            # Counting/aggregation
│       ├── consolidate.rs      # Data consolidation
│       └── distinct.rs         # Distinct operations
└── Cargo.toml                  # Workspace configuration
```

## Getting Started

For detailed installation instructions, see [INSTALLATION.md](INSTALLATION.md).

For comprehensive benchmarking guide, see [BENCHMARKING.md](BENCHMARKING.md).

For performance comparison methodology, see [COMPARISON.md](COMPARISON.md).

## Running Benchmarks

### Prerequisites
- Rust 1.70 or later
- Cargo

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Package Benchmarks
```bash
# Timely benchmarks only
cargo bench --package timely-benchmarks

# Differential benchmarks only
cargo bench --package differential-benchmarks
```

### Run Specific Benchmark
```bash
# Run a specific benchmark file
cargo bench --package timely-benchmarks --bench barrier

# Run specific test within a benchmark
cargo bench --package differential-benchmarks --bench join -- simple_join
```

## Benchmark Categories

### Timely Dataflow Benchmarks

1. **Barrier**: Tests synchronization overhead with varying data sizes
2. **Exchange**: Measures data exchange patterns and partitioning strategies
3. **Dataflow Construction**: Evaluates the overhead of building dataflow graphs
4. **Progress Tracking**: Analyzes progress tracking mechanisms
5. **Unary Operators**: Basic operator performance (map, filter, flat_map)

### Differential Dataflow Benchmarks

1. **Arrange**: Performance of data arrangement by key
2. **Join**: Join operation performance with various selectivities
3. **Count**: Aggregation and counting operations
4. **Consolidate**: Data consolidation and compaction
5. **Distinct**: Duplicate elimination performance

## Performance Comparisons

These benchmarks enable:
- Performance regression testing
- Comparison across different data sizes
- Analysis of various operational patterns
- Identification of performance bottlenecks

## Benchmark Results

Results are generated in `target/criterion/` directory with:
- HTML reports for visualization
- Statistical analysis of performance
- Historical comparison data

## Configuration

Benchmarks use Criterion.rs with:
- HTML report generation enabled
- Multiple iterations for statistical significance
- Warm-up periods for JIT compilation
- Configurable sample sizes

## Contributing

When adding new benchmarks:
1. Follow the existing pattern in benchmark files
2. Use appropriate sample sizes (avoid excessive runtime)
3. Add clear documentation for what is being measured
4. Update this README with new benchmark descriptions

## License

Apache-2.0

## References

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)