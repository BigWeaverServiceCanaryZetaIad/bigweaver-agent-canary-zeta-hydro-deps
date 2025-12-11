# Timely/Differential-Dataflow Benchmarks

This directory contains benchmarks that compare DFIR performance with timely-dataflow and differential-dataflow. These benchmarks have been separated from the main Hydro repository to avoid adding unnecessary dependencies to the core project.

## Available Benchmarks

The following benchmarks compare DFIR implementations with timely-dataflow and differential-dataflow:

- **arithmetic**: Tests arithmetic operations through a pipeline
- **fan_in**: Tests fan-in dataflow patterns
- **fan_out**: Tests fan-out dataflow patterns  
- **fork_join**: Tests fork-join patterns
- **identity**: Tests identity operations (pass-through)
- **join**: Tests join operations
- **reachability**: Tests graph reachability algorithms
- **upcase**: Tests string uppercase transformations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench arithmetic
```

## Performance Comparison

These benchmarks allow comparing the performance of DFIR against timely-dataflow and differential-dataflow. Each benchmark typically includes implementations for:
- Raw/baseline implementation
- DFIR implementation  
- Timely-dataflow implementation
- Differential-dataflow implementation (where applicable)

## Dependencies

These benchmarks depend on:
- `dfir_rs` - The DFIR runtime (fetched from main Hydro repository)
- `timely-dataflow` - Timely dataflow system
- `differential-dataflow` - Differential dataflow system
- `criterion` - Benchmarking framework

## Benchmark Results

Benchmark results are generated in the `target/criterion` directory and include:
- HTML reports with visualizations
- Statistical analysis
- Performance comparisons over time
