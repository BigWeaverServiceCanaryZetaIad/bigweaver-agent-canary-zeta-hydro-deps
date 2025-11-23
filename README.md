# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for comparing Hydro implementations with Timely and Differential-Dataflow. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a cleaner separation of concerns and reduce dependency complexity in the main codebase.

## Purpose

The benchmarks in this repository enable performance comparison testing between:
- **Hydro (DFIR)** - The Distributed Flow Intermediate Representation framework
- **Timely Dataflow** - A low-latency data-parallel dataflow system
- **Differential Dataflow** - An implementation of differential dataflow over timely dataflow

## Benchmarks

### Timely-Based Benchmarks

These benchmarks compare Hydro implementations against Timely dataflow:

- **`arithmetic.rs`** - Arithmetic operations pipeline benchmark
  - Compares pipeline, raw copy, Timely, and DFIR implementations
  - Tests sequential arithmetic operations on large datasets
  - Useful for measuring operator overhead

- **`fan_in.rs`** - Fan-in pattern benchmark
  - Tests multiple input streams converging to a single output
  - Compares Timely and DFIR implementations

- **`fan_out.rs`** - Fan-out pattern benchmark
  - Tests single input stream splitting to multiple outputs
  - Compares Timely and DFIR implementations

- **`fork_join.rs`** - Fork-join pattern benchmark
  - Tests splitting and rejoining of data streams
  - Compares Timely and DFIR implementations
  - Includes output verification

- **`identity.rs`** - Identity operation benchmark
  - Minimal overhead benchmark passing data through unchanged
  - Compares pipeline, raw copy, Timely, and DFIR implementations
  - Useful for measuring framework baseline overhead

- **`join.rs`** - Join operation benchmark
  - Tests stream join operations
  - Compares Timely and DFIR implementations
  - Critical for relational operator performance

- **`upcase.rs`** - String uppercase benchmark
  - Tests string transformation operations
  - Compares pipeline, raw, Timely, and DFIR implementations

### Differential-Dataflow Benchmarks

- **`reachability.rs`** - Graph reachability computation benchmark
  - Uses Differential Dataflow for iterative reachability computation
  - Compares against DFIR implementation
  - Includes test data files:
    - `reachability_edges.txt` (521KB) - Graph edge data
    - `reachability_reachable.txt` (38KB) - Expected reachable nodes
  - Tests incremental computation and fixed-point iteration

## Running Benchmarks

### Prerequisites

- Rust toolchain 1.91.1 (automatically configured via `rust-toolchain.toml`)
- Cargo

### Run All Benchmarks

```bash
cargo bench
```

### Run a Specific Benchmark

```bash
cargo bench --bench <benchmark_name>
```

Examples:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

### Run a Specific Test Within a Benchmark

```bash
cargo bench --bench arithmetic -- arithmetic/dfir
cargo bench --bench reachability -- reachability/dfir
```

## Performance Comparison Methodology

Each benchmark typically includes multiple implementations:

1. **Baseline** - Raw Rust or pipeline-based implementation for reference
2. **Timely** - Timely dataflow implementation
3. **DFIR** - Hydro DFIR implementation
4. **Differential** - Differential dataflow implementation (for iterative benchmarks)

This allows direct performance comparison between frameworks on identical workloads.

### Understanding Results

Benchmark results are generated using [Criterion.rs](https://github.com/bheisler/criterion.rs) and include:
- Mean execution time
- Standard deviation
- Confidence intervals
- Throughput measurements (where applicable)
- HTML reports in `target/criterion/`

Lower execution times indicate better performance. The `overhead` measurements show the performance difference relative to baseline implementations.

## Quick vs Full Benchmark Suites

For rapid iteration:
```bash
# Run quick benchmarks with reduced sample sizes
cargo bench -- --quick
```

For comprehensive results:
```bash
# Run full benchmark suite (takes longer)
cargo bench
```

## Benchmark Output

Results are stored in:
- `target/criterion/` - HTML reports with charts and statistical analysis
- Terminal output - Summary statistics and comparisons

View detailed HTML reports by opening `target/criterion/report/index.html` in a browser.

## Integration with Main Repository

These benchmarks are designed to work independently but reference the main Hydro repository:

- `dfir_rs` - Core DFIR implementation (from main repository)
- `sinktools` - Utility tools (from main repository)

Dependencies are configured to pull from the main repository via Git, ensuring benchmarks always test against the current implementation.

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in the `benches/` directory
2. Add a `[[bench]]` entry in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Use the Criterion framework for consistent benchmark structure
4. Include multiple implementations for comparison where applicable

## Dependencies

Key dependencies:
- `criterion` - Benchmark framework with statistical analysis
- `timely` - Timely dataflow (timely-master 0.13.0-dev.1)
- `differential-dataflow` - Differential dataflow (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` - Hydro DFIR implementation
- `tokio` - Async runtime support

## Migration Information

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Reduce dependency complexity in the main codebase
- Maintain cleaner separation between core functionality and performance testing
- Simplify builds and CI/CD pipelines for the main repository
- Preserve the ability to run comprehensive performance comparisons

For migration details, see:
- [Main repository REMOVAL_SUMMARY.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/REMOVAL_SUMMARY.md)
- [Main repository MIGRATION_NOTES.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/MIGRATION_NOTES.md)

## Verification

To verify benchmarks are working correctly:

```bash
# Check that all benchmarks compile
cargo check --benches

# Run a quick smoke test
cargo bench -- --quick

# Verify specific benchmark output
cargo bench --bench reachability
```

## License

Apache-2.0 (consistent with the main Hydro repository)

## Contributing

When contributing benchmarks:
- Follow existing benchmark patterns for consistency
- Include both baseline and framework implementations for comparison
- Document what the benchmark measures and why
- Ensure benchmarks are reproducible
- Add appropriate test data files if needed (keep them reasonably sized)

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository