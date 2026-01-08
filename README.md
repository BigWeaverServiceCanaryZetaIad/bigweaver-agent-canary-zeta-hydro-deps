# bigweaver-agent-canary-zeta-hydro-deps

Consolidated benchmarks repository for Hydro performance evaluation.

## Overview

This repository contains all benchmarks for the Hydro project. By maintaining all benchmarks in a dedicated repository, we:

1. **Reduce Main Repository Complexity**: The core Hydro repository focuses on implementation
2. **Consolidate Dependencies**: All benchmark-related dependencies are in one place
3. **Faster Core Builds**: Main development builds are faster without benchmark infrastructure
4. **Maintain Complete Functionality**: All benchmarking capabilities are preserved
5. **Improve Maintainability**: Clear separation between implementation and benchmarking

## Structure

- `benches/` - Complete benchmark suite
  - `benches/benches/` - Individual benchmark files
  - `benches/Cargo.toml` - Package configuration with all benchmark dependencies
  - `benches/README.md` - Detailed benchmark documentation

## Available Benchmarks

All current benchmarks use Hydro-native (dfir_rs) implementations:

- **futures** - Futures-based operations benchmark
- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark

## Dependencies

### Hydro Components
- `dfir_rs` - Hydro's DFIR implementation (referenced from main repository)

### Benchmarking Framework
- `criterion` - Benchmarking framework with async support and HTML reports

### Supporting Libraries
- `futures` - Futures and async utilities
- `rand`, `rand_distr` - Random number generation
- `tokio` - Async runtime
- `nameof`, `seq-macro`, `static_assertions` - Macro utilities

### Performance Comparison Dependencies
- `timely-master` (version 0.13.0-dev.1) - Available for future comparison implementations
- `differential-dataflow-master` (version 0.13.0-dev.1) - Available for future comparison implementations

Note: While timely and differential-dataflow are included as dependencies, the current benchmarks use Hydro-native implementations. These dependencies are available to support future work on performance comparison implementations.

## Running Benchmarks

### Run All Benchmarks
```bash
cd benches
cargo bench
```

### Run Specific Benchmarks
```bash
cargo bench -p benches --bench futures
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

### Run Specific Benchmark Functions
```bash
# Run only specific benchmark functions within a benchmark
cargo bench --bench micro_ops -- filter_by_name
cargo bench --bench words_diamond -- specific_test
```

## Performance Analysis

### 1. Run Benchmarks
From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### 2. Analyze Results
Criterion generates HTML reports in `target/criterion/` that provide:
- Performance measurements and statistics
- Historical performance trends
- Statistical analysis with confidence intervals
- Throughput measurements
- Outlier detection

### 3. Track Performance
The repository enables:
- Tracking Hydro performance over time
- Identifying performance regressions
- Validating optimization improvements
- Establishing performance baselines

## Benefits

1. **Consolidated Benchmark Infrastructure**: All benchmarks in one location
2. **Complete Dependency Isolation**: Benchmark dependencies don't affect core development
3. **Faster Main Repository Builds**: Core Hydro development is faster
4. **Preserved Functionality**: All benchmarking capabilities maintained
5. **Clear Organization**: Focused benchmark repository
6. **Simplified Maintenance**: Single location for benchmark updates

## Data Files

- `benches/benches/words_alpha.txt` - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
  - Used by the words_diamond benchmark

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with core DFIR implementations

## Migration

All benchmarks were migrated from the main repository on December 18, 2024 to consolidate benchmark infrastructure. For complete migration details, see the `BENCHMARK_MIGRATION.md` document in the main repository.

## Development

### Adding New Benchmarks

1. Add benchmark source file to `benches/benches/`
2. Update `benches/Cargo.toml` with `[[bench]]` declaration:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Add any required dependencies
4. Update this README with benchmark description
5. Run `cargo bench` to verify

### Benchmark Guidelines

- Use `criterion` framework for consistent measurements
- Document benchmark purpose and methodology
- Use appropriate dataset sizes for meaningful measurements
- Consider warmup iterations for optimization
- Add regression tracking for critical performance paths

## Performance Testing Best Practices

For reliable benchmark results:

1. **System Preparation**:
   - Close unnecessary applications
   - Run on a quiet system
   - Disable CPU frequency scaling if possible
   - Ensure consistent thermal conditions

2. **Benchmark Execution**:
   - Let benchmarks complete warmup iterations
   - Run multiple iterations for statistical significance
   - Use `cargo bench` which builds with optimizations
   - Review outliers in Criterion reports

3. **Result Analysis**:
   - Compare mean times with confidence intervals
   - Look for performance trends over time
   - Investigate unexpected changes
   - Validate against baseline measurements

## Future Work

This repository includes infrastructure for future performance comparison work:

- **Timely/Differential-Dataflow Comparisons**: Dependencies are included to support adding comparison implementations alongside Hydro-native benchmarks
- **Direct Performance Validation**: Enable side-by-side performance comparisons within the same benchmark suite
- **Extended Benchmark Coverage**: Add more comprehensive benchmark scenarios

The infrastructure is in place to support this work when needed.
