# Timely and Differential-Dataflow Benchmarks

This directory contains performance comparison benchmarks between Hydro (dfir_rs) and timely/differential-dataflow implementations.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on timely and differential-dataflow packages. This allows for:

- Performance comparison testing without adding these dependencies to the main repository
- Isolated benchmark execution and maintenance
- Historical performance data collection
- Framework comparison analysis

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run micro operations benchmark
cargo bench -p benches --bench micro_ops
```

### Quick Benchmark Run

For faster iteration during development, you can run a subset of iterations:

```bash
cargo bench -p benches -- --quick
```

## Available Benchmarks

### Micro Benchmarks

These benchmarks test individual operations and simple data flow patterns:

- **arithmetic** - Chain of arithmetic operations
- **fan_in** - Multiple inputs merged into a single stream
- **fan_out** - Single input split to multiple streams
- **fork_join** - Parallel processing with join operations
- **identity** - Pass-through operations (baseline)
- **join** - Stream join operations
- **symmetric_hash_join** - Hash join implementations
- **upcase** - String transformation operations

### Macro Benchmarks

These benchmarks test more complex, realistic workloads:

- **reachability** - Graph reachability analysis (uses test data files)
- **words_diamond** - Diamond pattern word processing (uses word list data)

### Async Benchmarks

- **futures** - Async/await pattern benchmarks

### Comparison Benchmarks

- **micro_ops** - Detailed operator-level performance comparisons between implementations

## Benchmark Implementations

Each benchmark typically includes multiple implementations:

1. **timely** - Native timely dataflow implementation
2. **differential** - Differential dataflow implementation
3. **dfir_rs/scheduled** - Hydro scheduled implementation
4. **dfir_rs** - Standard Hydro implementation
5. **dfir_rs/surface** - Hydro surface syntax implementation

This allows for direct performance comparison across different approaches.

## Test Data Files

Some benchmarks use external data files:

- `reachability_edges.txt` - Graph edges for reachability benchmark (~533 KB)
- `reachability_reachable.txt` - Expected reachable nodes (~39 KB)
- `words_alpha.txt` - English word list for word processing benchmarks (~3.9 MB)

These files are embedded in the benchmarks using `include_bytes!()` for consistent performance testing.

## Benchmark Results

Results are generated in `target/criterion/` and include:

- HTML reports with charts
- Statistical analysis
- Performance comparisons over time
- Detailed timing information

To view the results, open `target/criterion/report/index.html` in a web browser after running benchmarks.

## Performance Comparison Methodology

The benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework, which provides:

- Statistical analysis with confidence intervals
- Outlier detection
- Performance trend analysis
- Comparison against previous runs
- HTML report generation

## Build Process

The benchmarks include a build script (`build.rs`) that generates some benchmark code at compile time. This is used for:

- Generating repetitive benchmark patterns (e.g., fork_join operations)
- Preprocessing test data
- Creating optimized benchmark configurations

## Dependencies

The benchmark suite depends on:

- **timely-master** (0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - Hydro dataflow framework (from main repository)
- **criterion** - Benchmarking framework
- **tokio** - Async runtime

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add a corresponding `[[bench]]` section in `Cargo.toml`
3. Implement at least two versions (one Hydro, one timely/differential) for comparison
4. Use appropriate test data sizes for meaningful comparisons
5. Document expected results and validation criteria
6. Update this README with the new benchmark description

## Notes

- These benchmarks are isolated from the main repository to avoid dependency pollution
- Performance results may vary based on hardware and system load
- Benchmarks use `harness = false` to use Criterion's custom harness
- Some benchmarks may take several minutes to run completely

## References

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Timely dataflow: [https://github.com/TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- Differential dataflow: [https://github.com/TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- Criterion: [https://github.com/bheisler/criterion.rs](https://github.com/bheisler/criterion.rs)

## Wordlist Attribution

The word list (`words_alpha.txt`) is from: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
