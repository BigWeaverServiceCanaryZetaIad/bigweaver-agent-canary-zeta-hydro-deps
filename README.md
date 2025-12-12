# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external dataflow libraries (timely-dataflow and differential-dataflow) for performance comparison purposes.

## Purpose

The benchmarks in this repository were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- Keep the main repository free from unnecessary dependencies
- Improve build performance of the core codebase
- Maintain the ability to run performance comparisons between DFIR and timely/differential-dataflow

## Structure

- `benches/` - Benchmark suite comparing DFIR with timely-dataflow and differential-dataflow

## Running Benchmarks

To run the benchmarks:

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability

# Generate benchmark reports (HTML)
# Reports will be available in target/criterion/
```

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark  
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark
- **join** - Join operation benchmark
- **reachability** - Graph reachability using differential-dataflow
- **upcase** - Uppercase transformation benchmark

## Performance Comparison

These benchmarks allow you to compare the performance characteristics of:
- DFIR (native implementation)
- timely-dataflow 
- differential-dataflow

Results are generated using the [Criterion](https://github.com/bheisler/criterion.rs) benchmarking framework, which provides statistical analysis and HTML reports.

## Dependencies

This repository depends on:
- `timely-dataflow` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)

These dependencies are only used for benchmarking and are not part of the main DFIR codebase.

## Contributing

When adding new benchmarks:

1. Ensure benchmarks test comparable functionality across implementations
2. Use realistic workloads when possible
3. Document any data files or setup requirements
4. Follow the existing benchmark structure

## License

Apache-2.0