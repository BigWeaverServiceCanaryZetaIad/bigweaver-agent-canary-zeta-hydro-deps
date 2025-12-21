# bigweaver-agent-canary-zeta-hydro-deps

This repository contains timely and differential-dataflow benchmark implementations that were extracted from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for cleaner dependency management and facilitates performance comparisons between different dataflow systems.

## Purpose

This repository serves as a reference implementation for performance benchmarking of timely and differential-dataflow. It allows comparison with the Hydroflow, Babyflow, and Spinachflow implementations in the main repository without requiring those projects to maintain timely/differential-dataflow as dependencies.

## Repository Structure

```
timely-differential-benches/
├── benches/
│   ├── arithmetic_timely.rs          # Arithmetic operations benchmark
│   ├── fan_in_timely.rs               # Fan-in (merge) benchmark
│   ├── fan_out_timely.rs              # Fan-out (split) benchmark
│   ├── fork_join_timely.rs            # Fork-join pattern benchmark
│   ├── identity_timely.rs             # Identity mapping benchmark
│   ├── join_timely.rs                 # Hash join benchmark
│   ├── reachability_timely_differential.rs  # Graph reachability (both timely & differential)
│   ├── upcase_timely.rs               # String transformation benchmark
│   ├── reachability_edges.txt         # Test data for reachability
│   └── reachability_reachable.txt     # Expected results for reachability
├── Cargo.toml
└── README.md
```

## Running Benchmarks

To run all benchmarks:

```bash
cd timely-differential-benches
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench arithmetic_timely
cargo bench --bench reachability_timely_differential
```

## Cross-Repository Performance Comparison

### Quick Comparison

Use the provided comparison script to run benchmarks across both repositories and generate a comparison report:

```bash
./scripts/compare_benchmarks.sh
```

This will:
1. Run benchmarks in the main hydro-zeta repository
2. Run benchmarks in this deps repository
3. Generate a consolidated performance report
4. Compare results across implementations

### Manual Comparison

If you prefer manual comparison:

1. Run benchmarks in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench --bench <benchmark_name> > ../results_hydro.txt
   ```

2. Run benchmarks in this repository:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
   cargo bench --bench <benchmark_name>_timely > ../results_timely.txt
   ```

3. Compare the results using the criterion reports in `target/criterion/`

## Benchmark Details

Each benchmark has been extracted to include only the timely/differential-dataflow implementations while maintaining the same test parameters and data as the original benchmarks in the main repository.

### Available Benchmarks

- **arithmetic_timely**: Tests arithmetic operations on data streams
- **fan_in_timely**: Tests merging multiple streams into one
- **fan_out_timely**: Tests splitting one stream to multiple consumers
- **fork_join_timely**: Tests forking and joining data streams
- **identity_timely**: Tests identity mapping (no-op transformations)
- **join_timely**: Tests hash join operations (both usize and String types)
- **reachability_timely_differential**: Tests graph reachability using both timely and differential-dataflow
- **upcase_timely**: Tests string transformations (in-place, allocating, and concatenating)

## Dependencies

This repository uses:
- `timely` version 0.12
- `differential-dataflow` version 0.12
- `criterion` for benchmarking

## Performance Considerations

When comparing results:

1. **Ensure consistent environment**: Run both sets of benchmarks on the same machine with similar system load
2. **Multiple runs**: Consider running benchmarks multiple times to account for variance
3. **Warm-up**: Criterion automatically handles warm-up, but be aware of cold vs. hot performance
4. **Data scale**: Some benchmarks use large data sets (e.g., 1,000,000 items) which may stress different aspects of the implementations

## Contributing

When adding new benchmarks:

1. Ensure they match the parameters used in the main repository
2. Include both timely and differential-dataflow implementations where applicable
3. Update this README with benchmark descriptions
4. Add the benchmark to the comparison script

## Related Repositories

- Main repository: `bigweaver-agent-canary-hydro-zeta` - Contains Hydroflow, Babyflow, and Spinachflow implementations
