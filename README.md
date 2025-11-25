# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow). These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain separation of concerns and reduce unnecessary dependencies in the main codebase.

## Overview

The benchmarks in this repository are focused on performance testing of timely and differential-dataflow operations. They provide baseline comparisons and help track performance characteristics across different dataflow patterns.

## Benchmarks

The repository includes the following benchmarks:

### Timely Dataflow Benchmarks

1. **arithmetic** - Tests basic arithmetic operations through dataflow pipelines
   - Compares timely dataflow against raw iterations and threading approaches
   - Measures overhead of dataflow abstractions

2. **fan_in** - Tests concatenation of multiple data streams
   - Benchmarks union/concatenation operations
   - Compares against iterator-based approaches

3. **upcase** - Tests string transformation operations  
   - Benchmarks map operations on strings
   - Tests both in-place and allocating transformations

4. **join** - Tests join operations between two streams
   - Benchmarks hash join implementations
   - Tests with different value types (usize, String)

### Differential Dataflow Benchmarks

5. **reachability** - Tests graph reachability algorithms
   - Includes both timely and differential-dataflow implementations
   - Uses iterative/recursive dataflow patterns
   - Demonstrates incremental computation with differential dataflow

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

To run a specific test within a benchmark:

```bash
cargo bench -p benches --bench reachability -- timely
cargo bench -p benches --bench reachability -- differential
```

## Dependencies

The benchmarks use the following key dependencies:

- `timely` (package: timely-master, version 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version 0.13.0-dev.1)
- `criterion` (version 0.5.0) - for benchmarking framework
- `tokio` (version 1.29.0) - for async runtime support

## Benchmark Data

Some benchmarks use embedded data files:

- `reachability_edges.txt` - Edge list for graph reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Structure

```
benches/
├── Cargo.toml           # Benchmark package configuration
├── README.md            # This file
├── build.rs             # Build script  
└── benches/             # Benchmark source files
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── upcase.rs
    ├── join.rs
    └── reachability.rs
```

## Performance Considerations

These benchmarks are designed to:

1. Measure raw dataflow performance
2. Compare timely/differential-dataflow against baseline implementations
3. Track performance regression across versions
4. Provide insights for optimization opportunities

## Integration

This repository is part of the BigWeaver Canary Zeta IAD project ecosystem. The benchmarks were separated from the main repository to:

- Reduce compile times for the main project
- Avoid unnecessary benchmark dependencies in production code
- Enable focused performance testing
- Maintain clean separation of concerns

## Related Repositories

- `bigweaver-agent-canary-hydro-zeta` - Main project repository

## License

Apache-2.0

## Contributing

When adding new benchmarks:

1. Follow the existing naming conventions
2. Include both dataflow and baseline implementations for comparison
3. Add appropriate documentation  
4. Update this README with benchmark descriptions
5. Ensure benchmarks use `harness = false` in Cargo.toml