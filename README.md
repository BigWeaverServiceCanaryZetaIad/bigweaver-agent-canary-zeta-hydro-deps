# bigweaver-agent-canary-zeta-hydro-deps

## Timely and Differential Dataflow Benchmarks

This repository contains comprehensive benchmarks for [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow), including performance comparison utilities.

### Overview

The benchmarks are designed to:
- Measure performance of core operations in Timely and Differential Dataflow
- Compare performance across different workload sizes
- Provide independent execution capabilities for each benchmark suite
- Generate detailed performance reports

### Benchmark Categories

1. **Timely Basic Operations** (`timely_basic_ops`)
   - Map operations
   - Filter operations
   - Exchange operations
   - Concatenate operations

2. **Timely Reachability** (`timely_reachability`)
   - Graph reachability using iterative computation
   - Tests streaming graph algorithms

3. **Differential Basic Operations** (`differential_basic_ops`)
   - Map operations on collections
   - Filter operations
   - Join operations
   - Count operations

4. **Differential Reachability** (`differential_reachability`)
   - Incremental graph reachability
   - Tests differential computation

5. **Performance Comparison** (`comparison`)
   - Side-by-side comparison of similar operations
   - Statistical analysis of performance differences

### Running Benchmarks

#### Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

#### Run specific benchmark suites:
```bash
# Timely benchmarks only
cargo bench -p timely-differential-benches --bench timely_basic_ops
cargo bench -p timely-differential-benches --bench timely_reachability

# Differential benchmarks only
cargo bench -p timely-differential-benches --bench differential_basic_ops
cargo bench -p timely-differential-benches --bench differential_reachability

# Performance comparison
cargo bench -p timely-differential-benches --bench comparison
```

#### Run benchmarks with specific filters:
```bash
# Run only map operations
cargo bench -p timely-differential-benches -- map

# Run only large workloads
cargo bench -p timely-differential-benches -- large
```

### Benchmark Results

Results are saved in `target/criterion/` directory with:
- HTML reports for detailed visualization
- CSV data for custom analysis
- Statistical comparisons across runs

### Performance Comparison

The `comparison` benchmark provides direct performance comparisons between Timely and Differential Dataflow for equivalent operations. This helps identify:
- Performance characteristics of each framework
- Optimal use cases for each system
- Scaling behavior differences

### Structure

```
.
├── benches/
│   ├── Cargo.toml
│   └── benches/
│       ├── timely_basic_ops.rs
│       ├── timely_reachability.rs
│       ├── differential_basic_ops.rs
│       ├── differential_reachability.rs
│       ├── comparison.rs
│       └── common/
│           └── mod.rs (shared utilities)
├── Cargo.toml
└── README.md
```

### Dependencies

- `timely`: 0.12
- `differential-dataflow`: 0.12
- `criterion`: 0.5 (for benchmarking)

### Contributing

When adding new benchmarks:
1. Place them in the appropriate category
2. Use consistent naming conventions
3. Add documentation for the benchmark purpose
4. Update this README

### License

Apache-2.0