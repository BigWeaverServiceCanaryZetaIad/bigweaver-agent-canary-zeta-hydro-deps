# Timely/Differential-Dataflow Benchmarks

This directory contains benchmarks for comparing performance implementations using Timely Dataflow and Differential Dataflow frameworks.

## Overview

These benchmarks were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to provide a standalone environment for running performance comparisons with Timely and Differential Dataflow implementations, separate from the main Hydro-native codebase.

## Purpose

The primary goals of this benchmark suite are:

1. **Performance Comparison**: Compare execution characteristics between Timely/Differential implementations
2. **Reduced Build Dependencies**: Keep the main repository free from Timely/Differential dependencies
3. **Isolated Testing**: Provide a dedicated environment for dataflow framework benchmarking

## Available Benchmarks

### Core Timely/Differential Benchmarks

These benchmarks use only Timely Dataflow and Differential Dataflow:

- **`arithmetic.rs`** - Sequential arithmetic operations on data streams
- **`fan_in.rs`** - Multiple input streams merging into a single output (fan-in pattern)
- **`fan_out.rs`** - Single input stream splitting to multiple outputs (fan-out pattern)
- **`fork_join.rs`** - Fork-join parallel execution pattern with generated code
- **`identity.rs`** - Pass-through transformation to measure overhead
- **`join.rs`** - Stream join operations with different key types
- **`reachability.rs`** - Graph reachability computation using differential dataflow
- **`upcase.rs`** - String transformation operations

### Additional Benchmarks

These benchmarks were added for future comparative implementations:

- **`futures.rs`** - Futures-based async operations
- **`micro_ops.rs`** - Micro-benchmark for basic operations
- **`symmetric_hash_join.rs`** - Symmetric hash join implementation
- **`words_diamond.rs`** - Diamond-pattern word processing workflow

**Note**: Some benchmarks contain commented-out Hydro/dfir_rs implementations since those dependencies are not available in this repository. Only the Timely/Differential implementations are active.

## Data Files

- **`reachability_edges.txt`** - Graph edge data for reachability benchmark
- **`reachability_reachable.txt`** - Expected reachable nodes for validation
- **`words_alpha.txt`** - Word list for string processing benchmarks

## Dependencies

The benchmarks depend on:

- `timely-master` (version 0.13.0-dev.1) - Timely Dataflow framework
- `differential-dataflow-master` (version 0.13.0-dev.1) - Differential Dataflow framework
- `criterion` - Benchmarking framework with statistics
- `tokio` - Async runtime
- Various utility crates (`rand`, `futures`, etc.)

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
```

### Run Specific Test Within a Benchmark

```bash
cargo bench -p benches --bench arithmetic -- timely
cargo bench -p benches --bench join -- "join/String"
```

### With Additional Criterion Options

```bash
# Generate detailed HTML reports
cargo bench -p benches -- --verbose

# Save baseline for comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

## Build Process

### Code Generation

The `build.rs` script generates code for certain benchmarks at build time:

- **Fork-Join Benchmark**: Generates `fork_join_20.hf` with expanded fork-join patterns
  - Configurable via `NUM_OPS` constant in `build.rs`
  - Generated files are gitignored (see `.gitignore`)

### Build Command

```bash
# Build benchmarks without running
cargo build -p benches --release

# Clean generated files
cargo clean -p benches
```

## Benchmark Results

### Output Location

Benchmark results are stored in:
- `target/criterion/` - Detailed criterion reports
- HTML reports can be viewed by opening `target/criterion/report/index.html`

### Understanding Results

Each benchmark reports:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second (where applicable)
- **Change**: Performance comparison vs previous runs

Example output:
```
arithmetic/timely        time: [1.234 s 1.240 s 1.246 s]
                         change: [-2.3% -1.1% +0.2%]
```

## Performance Comparison Workflow

### Comparing with Hydro-Native Implementations

1. **Run benchmarks in this repository** (Timely/Differential):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches --bench arithmetic
   ```

2. **Run corresponding benchmarks in main repository** (Hydro-native):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches --bench arithmetic
   ```

3. **Compare results** from both `target/criterion/` directories

### Baseline Comparisons

```bash
# Save baseline from this run
cargo bench -p benches -- --save-baseline timely-baseline

# After making changes, compare
cargo bench -p benches -- --baseline timely-baseline
```

## Configuration

### Benchmark Parameters

Key parameters are defined as constants in each benchmark file:

- `NUM_OPS`: Number of operations (typically 20)
- `NUM_INTS`: Data volume (typically 1,000,000)
- Other benchmark-specific parameters

To modify these, edit the respective `.rs` file and rebuild.

### Criterion Configuration

Criterion is configured in the `[dev-dependencies]` section with:
- `async_tokio`: Support for async benchmarks
- `html_reports`: Generate HTML visualization

## Troubleshooting

### Build Errors

**Issue**: Missing dependencies
```
error: failed to resolve: use of undeclared crate or module `dfir_rs`
```

**Solution**: This is expected. Some benchmark functions reference dfir_rs but are commented out. Ensure they're not included in `criterion_group!` macros.

**Issue**: Timely/Differential version conflicts
```
error: failed to select a version for `timely`
```

**Solution**: Update `Cargo.toml` to use compatible versions or run `cargo update`.

### Runtime Errors

**Issue**: Data files not found
```
Error: Os { code: 2, kind: NotFound, message: "No such file or directory" }
```

**Solution**: Ensure you're running from the repository root and data files exist in `benches/benches/`.

### Performance Issues

**Issue**: Benchmarks take too long

**Solution**: 
- Reduce `NUM_INTS` or `NUM_OPS` constants
- Use `--sample-size` flag: `cargo bench -- --sample-size 10`
- Run specific benchmarks instead of the full suite

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Implement benchmark using Criterion API and Timely/Differential
3. Add `[[bench]]` entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
4. Run: `cargo bench -p benches --bench my_benchmark`

### Updating Dependencies

To update Timely/Differential versions:

1. Edit `benches/Cargo.toml`
2. Update version numbers or git revisions
3. Run `cargo update`
4. Test: `cargo bench -p benches`

## Architecture Notes

### Why a Separate Repository?

The benchmark suite was separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Reduce Build Time**: Main repository builds faster without Timely/Differential dependencies
2. **Clear Separation**: Distinct architectural boundary between implementations
3. **Maintain Comparison**: Preserve ability to compare against Timely/Differential baselines
4. **Focused Dependencies**: Each repository has a specific dependency scope

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── README.md               # Repository overview
└── benches/
    ├── Cargo.toml          # Benchmark package configuration
    ├── README.md           # This file
    ├── build.rs            # Build script for code generation
    └── benches/
        ├── .gitignore      # Ignore generated files
        ├── *.rs            # Benchmark implementations
        └── *.txt           # Test data files
```

## References

- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Migration History

- **December 17, 2024**: Initial migration of core Timely/Differential benchmarks
- **December 18, 2024**: Added Hydro-native benchmark files for future implementations
- **December 19, 2024**: Finalized standalone configuration and documentation

For detailed migration information, see `BENCHMARK_MIGRATION.md` in the main repository.
