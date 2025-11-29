# Benchmark Guide

This repository contains performance benchmarks for comparing Hydro/DFIR implementations with timely and differential-dataflow implementations.

## Purpose

These benchmarks allow for:
1. **Performance comparison** between Hydro and alternative dataflow systems
2. **Regression detection** when making changes to the Hydro codebase
3. **Performance profiling** to identify bottlenecks

## Repository Structure

The benchmarks have been moved to this separate repository (`bigweaver-agent-canary-zeta-hydro-deps`) to maintain a clean dependency structure in the main Hydro repository while preserving the ability to run comprehensive performance comparisons.

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/          # Individual benchmark implementations
│   │   ├── reachability.rs        # Graph reachability benchmark
│   │   ├── arithmetic.rs          # Arithmetic operations benchmark
│   │   ├── join.rs               # Join operations benchmark
│   │   ├── fan_in.rs             # Fan-in pattern benchmark
│   │   ├── fan_out.rs            # Fan-out pattern benchmark
│   │   ├── micro_ops.rs          # Micro-operations benchmark
│   │   └── ...                   # Other benchmarks
│   ├── Cargo.toml        # Benchmark dependencies
│   └── README.md         # Benchmark-specific documentation
├── Cargo.toml            # Workspace configuration
└── README.md             # This file
```

## Running Benchmarks

### Prerequisites

1. Ensure both repositories are cloned as siblings:
   ```bash
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. The benchmarks reference the main Hydro repository for `dfir_rs` and `sinktools` packages.

### Running All Benchmarks

From the root of this repository:

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run join benchmark
cargo bench -p benches --bench join

# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic
```

### Benchmark Output

Benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework, which:
- Generates detailed reports in `target/criterion/`
- Provides HTML visualizations
- Tracks performance over time
- Detects performance regressions

## Available Benchmarks

### Graph Reachability (`reachability.rs`)
Compares graph reachability implementations across:
- Hydro/DFIR
- Timely Dataflow
- Differential Dataflow

Tests transitive closure computation on a directed graph.

### Arithmetic Operations (`arithmetic.rs`)
Benchmarks basic arithmetic operations in different dataflow systems.

### Join Operations (`join.rs`)
Compares join operation performance between implementations.

### Fan-in/Fan-out (`fan_in.rs`, `fan_out.rs`)
Tests message routing patterns:
- **Fan-in**: Multiple sources to single destination
- **Fan-out**: Single source to multiple destinations

### Micro Operations (`micro_ops.rs`)
Fine-grained benchmarks of basic dataflow operations.

### Other Benchmarks
- `fork_join.rs` - Fork-join pattern performance
- `symmetric_hash_join.rs` - Symmetric hash join operations
- `words_diamond.rs` - Diamond pattern with word processing
- `identity.rs` - Identity transformation overhead
- `upcase.rs` - String transformation operations
- `futures.rs` - Async futures integration

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Implement benchmark using Criterion framework
3. Add benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

## Dependencies

The benchmarks depend on:
- **timely-master**: Timely Dataflow system
- **differential-dataflow-master**: Differential Dataflow system
- **dfir_rs**: From main Hydro repository (via path dependency)
- **sinktools**: From main Hydro repository (via path dependency)
- **criterion**: Benchmarking framework

## Performance Comparison Workflow

1. **Baseline Measurement**: Run benchmarks on current main branch
2. **Make Changes**: Implement changes in the main Hydro repository
3. **Re-run Benchmarks**: Compare new results against baseline
4. **Analysis**: Review Criterion reports for performance impact

## CI/CD Integration

These benchmarks can be integrated into CI/CD pipelines to:
- Track performance trends over time
- Automatically detect regressions
- Generate performance reports for PRs

## Troubleshooting

### Path Dependency Issues

If you encounter errors about missing dependencies:
1. Verify repository layout (siblings as shown above)
2. Check that paths in `benches/Cargo.toml` are correct
3. Ensure main repository is on a compatible commit/branch

### Build Errors

The benchmarks require:
- Rust toolchain version specified in `rust-toolchain.toml`
- All dependencies from both repositories

### Performance Variance

Benchmark results can vary due to:
- System load
- CPU frequency scaling
- Background processes
- Memory pressure

For consistent results:
- Close unnecessary applications
- Run benchmarks multiple times
- Use dedicated hardware when possible

## Maintenance

When updating the main Hydro repository:
1. Check if API changes affect benchmarks
2. Update benchmark implementations if needed
3. Update this documentation
4. Re-run benchmarks to establish new baselines

## Contributing

When contributing benchmarks:
1. Follow existing code style and patterns
2. Include documentation in benchmark files
3. Add appropriate test data files
4. Update this guide with new benchmarks
5. Ensure benchmarks run successfully

## References

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Main Hydro Repository](https://github.com/hydro-project/hydro)
