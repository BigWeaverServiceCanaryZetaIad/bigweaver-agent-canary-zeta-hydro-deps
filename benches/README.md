# Consolidated Benchmark Suite

This directory contains all benchmarks for the Hydro project.

## Overview

All benchmarks are maintained in this dedicated repository to consolidate benchmark infrastructure and dependencies, keeping the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository focused on core implementation.

## Available Benchmarks

All current benchmarks use Hydro-native (dfir_rs) implementations:

- **futures** - Futures-based operations benchmark
  - Tests async future handling and resolution
  - Evaluates defer_tick and resolve_futures operators
  
- **micro_ops** - Micro-operations benchmark
  - Tests fundamental dataflow operations
  - Measures operator overhead and throughput
  
- **symmetric_hash_join** - Symmetric hash join benchmark
  - Tests join operations with symmetric hash algorithm
  - Evaluates join performance characteristics
  
- **words_diamond** - Word processing diamond pattern benchmark
  - Tests complex dataflow patterns (diamond topology)
  - Measures word processing and aggregation performance
  - Uses words_alpha.txt dataset

## Dependencies

This benchmark suite includes:
- `dfir_rs` - Hydro's DFIR implementation (from main repository)
- `criterion` - Benchmarking framework with async support
- `timely-master` (version 0.13.0-dev.1) - Available for future comparison implementations
- `differential-dataflow-master` (version 0.13.0-dev.1) - Available for future comparison implementations
- Supporting libraries (futures, rand, tokio, etc.)

Note: While timely and differential-dataflow dependencies are configured, the current benchmark implementations use Hydro-native code. These dependencies are available for future performance comparison work.

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmarks
```bash
cargo bench --bench futures
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
```

### Run Specific Benchmark Functions
```bash
# Run only specific benchmark functions
cargo bench --bench micro_ops -- filter_by_name
cargo bench --bench words_diamond -- specific_test
```

## Performance Analysis

### Methodology

1. **Run Benchmarks**: Execute `cargo bench` to run all benchmarks
2. **Review Reports**: Check `target/criterion/` for HTML reports with:
   - Performance measurements and statistics
   - Historical performance trends
   - Statistical significance analysis
   - Throughput measurements
   - Outlier detection

3. **Track Performance**: Monitor:
   - Hydro performance characteristics over time
   - Impact of code changes on performance
   - Performance regressions or improvements
   - Baseline performance metrics

### Interpreting Results

Criterion provides:
- **Mean execution time** with confidence intervals
- **Throughput measurements** for applicable benchmarks
- **Performance trends** when benchmarks run repeatedly
- **Statistical outlier detection** for reliable measurements
- **Regression warnings** when performance degrades

## Data Files

- `benches/words_alpha.txt` - English word list
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
  - Used by: words_diamond benchmark

## Directory Structure

```
benches/
├── Cargo.toml           # Package configuration and dependencies
├── README.md            # This file
├── .gitignore           # Ignore patterns
└── benches/
    ├── futures.rs       # Futures benchmark
    ├── micro_ops.rs     # Micro-operations benchmark
    ├── symmetric_hash_join.rs  # Hash join benchmark
    ├── words_diamond.rs        # Diamond pattern benchmark
    └── words_alpha.txt         # Word list data
```

## Development

### Adding New Benchmarks

1. Create benchmark source file in `benches/benches/`
2. Add `[[bench]]` declaration to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Add required dependencies to `Cargo.toml` if needed
4. Update this README with benchmark description
5. Run `cargo bench` to verify

### Benchmark Guidelines

- Use `criterion` framework for consistent measurements
- Document benchmark purpose and methodology
- Use appropriate dataset sizes for meaningful measurements
- Consider warmup iterations for JIT optimization
- Add regression tracking for critical performance paths
- Include both microbenchmarks and realistic workloads

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
   - Investigate unexpected regressions
   - Validate against baseline measurements

## Migration Notes

All benchmarks were migrated from the main repository to this dedicated benchmarks repository on December 18, 2024. This consolidation:
- Reduces main repository complexity
- Speeds up core development builds
- Centralizes benchmark infrastructure
- Maintains all benchmarking capabilities

For complete migration details, see the `BENCHMARK_MIGRATION.md` document in the main repository.

## Future Work

This repository includes infrastructure to support future performance comparison work:

- Adding timely/differential-dataflow comparison implementations alongside Hydro-native benchmarks
- Enabling direct performance comparisons between different dataflow implementations
- Expanding benchmark coverage with additional scenarios

The dependencies are configured to support this future work when needed.

## Related Documentation

- Main Repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Migration Document: `BENCHMARK_MIGRATION.md` in main repository
- Criterion Documentation: https://bheisler.github.io/criterion.rs/book/
