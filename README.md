# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains performance benchmarks that depend on external dataflow frameworks (timely and differential-dataflow). These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean separation between core functionality and external framework comparisons.

## Purpose

This repository enables:
- **Performance comparisons** between dfir_rs and industry-standard dataflow frameworks
- **Reference implementations** using timely and differential-dataflow
- **Independent dependency management** for external benchmark dependencies
- **Continued performance evaluation** without bloating the main repository

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark suite
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operations comparison
│   │   ├── fan_in.rs          # Fan-in pattern benchmarks
│   │   ├── fan_out.rs         # Fan-out pattern benchmarks
│   │   ├── fork_join.rs       # Fork-join pattern benchmarks
│   │   ├── identity.rs        # Identity operation benchmarks
│   │   ├── join.rs            # Join operation benchmarks
│   │   ├── reachability.rs    # Graph reachability benchmarks
│   │   ├── upcase.rs          # String transformation benchmarks
│   │   ├── reachability_edges.txt         # Test data (524KB)
│   │   ├── reachability_reachable.txt     # Expected results (40KB)
│   │   └── words_alpha.txt                # Word list (3.7MB)
│   ├── Cargo.toml             # Benchmark dependencies
│   ├── build.rs               # Build configuration
│   └── README.md              # Benchmark documentation
├── BENCHMARKS.md              # Detailed benchmark guide
├── QUICKSTART.md              # Quick start guide
└── README.md                  # This file
```

## Benchmarks Included

### 1. Arithmetic Operations (`arithmetic.rs`)
Performance comparison benchmarks for arithmetic operations across different implementations:
- Pipeline pattern
- Raw copy approach
- Iterator-based processing
- Timely dataflow implementation

### 2. Fan-In Pattern (`fan_in.rs`)
Benchmarks for fan-in dataflow patterns using timely operators.

### 3. Fan-Out Pattern (`fan_out.rs`)
Benchmarks for fan-out dataflow patterns using timely operators.

### 4. Fork-Join Pattern (`fork_join.rs`)
Benchmarks for fork-join concurrency patterns using timely dataflow.

### 5. Identity Operations (`identity.rs`)
Benchmarks for identity transformations using timely operators.

### 6. Join Operations (`join.rs`)
Benchmarks for join operations using timely dataflow.

### 7. Graph Reachability (`reachability.rs`)
Complex graph reachability benchmarks using both timely and differential-dataflow:
- Uses real graph data (524KB edge data)
- Tests incremental computation capabilities
- Compares performance with dfir_rs implementations

### 8. String Transformations (`upcase.rs`)
String uppercase transformation benchmarks using timely operators:
- Uses large word list (3.7MB)
- Tests text processing performance

## Dependencies

This repository requires:
- **Rust toolchain** - See `rust-toolchain.toml` in the main repository
- **timely-master** (0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework
- **criterion** (0.5.0) - Benchmarking framework
- **dfir_rs** - From the main bigweaver-agent-canary-hydro-zeta repository
- **sinktools** - From the main bigweaver-agent-canary-hydro-zeta repository

## Prerequisites

Before running these benchmarks, you need:

1. The main `bigweaver-agent-canary-hydro-zeta` repository cloned at the same level:
   ```
   /projects/sandbox/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Rust toolchain installed (see main repository for version requirements)

## Quick Start

### Running All Benchmarks

```bash
cd benches
cargo bench
```

### Running Specific Benchmarks

```bash
# Run arithmetic comparisons
cargo bench --bench arithmetic

# Run graph reachability
cargo bench --bench reachability

# Run join operations
cargo bench --bench join
```

### Running with Filters

```bash
# Run only specific test cases within a benchmark
cargo bench --bench arithmetic -- pipeline

# Run all benchmarks matching a pattern
cargo bench -- identity
```

## Performance Comparison Workflow

### 1. Comparing with dfir_rs

The benchmarks in this repository can be compared with the core dfir_rs benchmarks in the main repository:

```bash
# Run dfir_rs benchmarks (in main repository)
cd ../bigweaver-agent-canary-hydro-zeta/benches
cargo bench

# Run comparison benchmarks (in this repository)
cd ../../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### 2. Analyzing Results

Benchmark results are saved in `target/criterion/` and include:
- HTML reports with charts
- Statistical analysis
- Performance comparisons between runs

View results:
```bash
open target/criterion/report/index.html
```

## Migration Information

### Why Were These Benchmarks Moved?

These benchmarks were moved from the main repository to:
1. **Reduce dependencies** - Remove timely/differential-dataflow from the main build
2. **Improve build times** - Faster compilation for core development
3. **Separate concerns** - Keep core functionality separate from external comparisons
4. **Maintain flexibility** - Run comparison benchmarks independently when needed

### Related Documentation

For more information about the migration:
- See `REMOVAL_SUMMARY.md` in the main repository
- See `MIGRATION_NOTES.md` in the main repository
- See `CHANGES_README.md` in the main repository

## Development

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       // Your benchmark code
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. Add the benchmark declaration to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Run your benchmark:
   ```bash
   cargo bench --bench my_benchmark
   ```

### Updating Dependencies

When updating timely or differential-dataflow versions:

1. Update versions in `benches/Cargo.toml`
2. Test all benchmarks compile and run
3. Document any API changes needed
4. Update this README if behavior changes

## Troubleshooting

### Path Errors

If you see errors about missing dfir_rs or sinktools:
- Ensure the main repository is cloned at the same level
- Check that relative paths in `Cargo.toml` are correct
- Verify the main repository structure matches expectations

### Build Errors

If benchmarks fail to build:
- Check Rust version matches the main repository requirements
- Ensure all dependencies are available
- Try `cargo clean && cargo build` to rebuild from scratch

### Performance Issues

If benchmarks run slowly:
- Use release mode: `cargo bench` (automatically uses release mode)
- Check system resources are available
- Close other applications that might interfere

## Benchmark Results Interpretation

### Understanding Criterion Output

Criterion provides:
- **Time measurements** - Mean, median, standard deviation
- **Throughput** - Items processed per second
- **Comparison** - Changes from previous runs
- **Outlier detection** - Statistical anomalies

### Comparing Implementations

When comparing dfir_rs with timely/differential-dataflow:
- Focus on relative performance, not absolute numbers
- Consider scalability characteristics
- Evaluate memory usage alongside execution time
- Test with realistic data sizes

## Contributing

When contributing benchmarks:
1. Follow existing code structure and patterns
2. Include meaningful test data
3. Document benchmark purpose and methodology
4. Ensure benchmarks run reliably
5. Add documentation to this README

## License

This repository follows the same license as the main bigweaver-agent-canary-hydro-zeta repository.

## Contact and Support

For questions about:
- **Benchmark methodology** - See `benches/README.md`
- **dfir_rs functionality** - See main repository documentation
- **Migration process** - See `MIGRATION_NOTES.md` in main repository
- **Performance issues** - Open an issue with benchmark results

## Additional Resources

- **Main Repository**: `bigweaver-agent-canary-hydro-zeta`
- **Timely Dataflow**: [GitHub](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow**: [GitHub](https://github.com/TimelyDataflow/differential-dataflow)
- **Criterion**: [Documentation](https://bheisler.github.io/criterion.rs/book/)

## Version History

- **Initial Release** - Benchmarks moved from main repository
  - 8 benchmark suites included
  - Full test data included
  - Dependencies on timely and differential-dataflow v0.13.0-dev.1