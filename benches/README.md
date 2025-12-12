# Hydro Performance Comparison Benchmarks

This repository contains benchmarks that compare Hydro/DFIR performance against `timely-dataflow` and `differential-dataflow`. These benchmarks have been separated from the main Hydro repository to avoid dependency overhead in the core codebase.

## Purpose

These benchmarks enable performance comparisons between Hydro and established dataflow frameworks. By keeping them in a separate repository, we:

- Avoid adding timely and differential-dataflow dependencies to the main Hydro repository
- Maintain the ability to run comprehensive performance comparisons
- Keep the main repository's dependencies minimal and focused
- Enable independent versioning of benchmark suites

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| **arithmetic** | Basic arithmetic operations across dataflow implementations |
| **fan_in** | Multiple inputs converging to a single operator |
| **fan_out** | Single input distributed to multiple operators |
| **fork_join** | Fork-join pattern performance |
| **identity** | Baseline performance for data passthrough |
| **join** | Join operation performance comparison |
| **reachability** | Graph reachability algorithm performance |
| **upcase** | String transformation operations |

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed with a recent version (1.70+).

### Run All Benchmarks

```bash
# From this repository root
cargo bench
```

### Run Specific Benchmark

```bash
# Run only the reachability benchmark
cargo bench --bench reachability

# Run only join benchmarks
cargo bench --bench join

# Run with specific test filter
cargo bench identity
```

### Generate Performance Reports

Criterion automatically generates detailed HTML reports:

```bash
cargo bench
# Open target/criterion/report/index.html in your browser
```

## Benchmark Structure

Each benchmark typically includes implementations for:

1. **Hydro/DFIR** - The Hydro implementation
2. **Timely-dataflow** - Timely implementation for comparison
3. **Differential-dataflow** - Differential implementation for comparison (where applicable)

## Cross-Repository Performance Comparison

To compare performance with Hydro-native benchmarks:

1. Clone the main Hydro repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   ```

2. Run Hydro-native benchmarks:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare results from both repositories using Criterion's HTML reports

## Adding New Benchmarks

When adding new comparison benchmarks:

1. Add the benchmark file to `benches/benches/<name>.rs`
2. Add a `[[bench]]` section to `Cargo.toml`
3. Implement variants for Hydro, timely, and differential (as applicable)
4. Update this README with the benchmark description
5. Document any special setup or data requirements

## Related Documentation

- Main Hydro repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Hydro-native benchmarks (no external dependencies): See `benches/` directory in main repository
- Timely-dataflow: [https://github.com/TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- Differential-dataflow: [https://github.com/TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Performance Considerations

- Benchmarks are configured to run with optimized builds
- Each benchmark runs multiple iterations for statistical significance
- Criterion provides confidence intervals and detects performance regressions
- Results may vary based on system configuration and load

## Contributing

When contributing benchmarks:

- Ensure fair comparison (similar algorithm implementations)
- Document any implementation differences
- Include comments explaining benchmark setup
- Verify benchmarks compile and run successfully
- Follow Rust and Criterion best practices for accurate measurements
