# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that have been isolated from the main repository to maintain clean separation of concerns.

## Purpose

This repository serves as a dedicated location for:

1. **Performance Comparison Benchmarks** - Comparing Hydro (dfir_rs) implementations against timely and differential-dataflow
2. **Dependency Isolation** - Keeping timely and differential-dataflow dependencies separate from the main repository
3. **Historical Performance Tracking** - Maintaining benchmark results over time
4. **Framework Evaluation** - Enabling objective performance comparisons

## Quick Start

### Prerequisites

- Rust toolchain (stable or nightly)
- Git
- Sufficient disk space for dependencies (~2-3 GB)

### Running Benchmarks

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Quick run (fewer iterations)
cargo bench -p benches -- --quick
```

### Viewing Results

After running benchmarks, view the HTML reports:

```bash
# Open in your default browser (Linux)
xdg-open target/criterion/report/index.html

# Open in your default browser (macOS)
open target/criterion/report/index.html

# Open in your default browser (Windows)
start target/criterion/report/index.html
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                 # Workspace configuration
├── README.md                  # This file
├── QUICKSTART.md              # Quick start guide
├── TESTING_GUIDE.md           # Comprehensive testing documentation
└── benches/                   # Benchmark package
    ├── Cargo.toml             # Benchmark dependencies and configuration
    ├── README.md              # Benchmark documentation
    ├── build.rs               # Build script for code generation
    └── benches/               # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_diamond.rs
        ├── reachability_edges.txt       # Test data
        ├── reachability_reachable.txt   # Test data
        └── words_alpha.txt              # Test data
```

## Available Benchmarks

### Micro Benchmarks
- **arithmetic** - Arithmetic operation chains
- **fan_in** - Multiple input merging
- **fan_out** - Single input splitting
- **fork_join** - Parallel processing with joins
- **identity** - Pass-through operations (baseline)
- **join** - Stream join operations
- **symmetric_hash_join** - Hash join implementations
- **upcase** - String transformations

### Macro Benchmarks
- **reachability** - Graph reachability analysis
- **words_diamond** - Diamond pattern word processing

### Async Benchmarks
- **futures** - Async/await patterns

### Comparison Benchmarks
- **micro_ops** - Operator-level performance comparisons

## Performance Comparison Functionality

This repository is specifically designed to retain and enhance performance comparison capabilities:

### 🎯 Key Features

✅ **Multi-Implementation Benchmarks** - Each benchmark includes multiple implementations:
   - Timely dataflow
   - Differential dataflow
   - Hydro scheduled
   - Hydro standard
   - Hydro surface syntax

✅ **Statistical Analysis** - Using Criterion framework for:
   - Confidence intervals
   - Outlier detection
   - Performance trend tracking
   - Regression detection

✅ **Visual Reports** - HTML reports with:
   - Performance charts
   - Historical comparisons
   - Statistical summaries
   - Detailed timing breakdown

✅ **Automated Comparison** - Side-by-side execution of:
   - Different framework implementations
   - Different optimization levels
   - Different data sizes

### 📊 Understanding Results

Benchmark results show:
- **Time per iteration** - How long each operation takes
- **Throughput** - Operations per second
- **Comparison ratios** - Relative performance between implementations
- **Variance** - Stability of performance
- **Trends** - Performance changes over time

### 🔍 Interpreting Comparisons

When comparing implementations:
- Lower times are better
- Higher throughput is better
- Lower variance indicates more stable performance
- Check confidence intervals for statistical significance

## Dependencies

This repository includes dependencies on:

- **timely-master** - Timely dataflow framework
- **differential-dataflow-master** - Differential dataflow framework
- **dfir_rs** - Hydro dataflow (from main repository)
- **sinktools** - Utilities (from main repository)
- **criterion** - Benchmarking framework

## Why a Separate Repository?

The benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Eliminate Unwanted Dependencies** - Keep timely and differential-dataflow out of the main repository
2. **Reduce Compilation Time** - Main repository builds faster without these dependencies
3. **Clean Separation** - Follow architectural patterns for dependency isolation
4. **Maintain Comparison Capability** - Still enable performance comparisons without polluting main repo

See the main repository's `REMOVAL_SUMMARY.md` and `MIGRATION_NOTES.md` for more details.

## Building

```bash
# Build all benchmarks
cargo build --workspace --release

# Build specific benchmark
cargo build --release -p benches

# Check without building
cargo check --workspace
```

## Testing

While these are benchmarks rather than tests, you can verify they compile and run:

```bash
# Compile all benchmarks
cargo bench --no-run

# Run benchmarks with minimal iterations (faster)
cargo bench -- --test
```

## Contributing

When contributing benchmarks:

1. Implement multiple framework versions for fair comparison
2. Use appropriate test data sizes
3. Include validation/assertions to ensure correctness
4. Document expected behavior and results
5. Update relevant documentation
6. Follow the existing benchmark structure

### Adding a New Benchmark

1. Create `benches/benches/your_benchmark.rs`
2. Add `[[bench]]` entry in `benches/Cargo.toml`
3. Implement benchmark using Criterion
4. Add implementations for multiple frameworks
5. Document in `benches/README.md`
6. Test the benchmark runs successfully

## Documentation

- **[README.md](README.md)** - This file (overview)
- **[QUICKSTART.md](QUICKSTART.md)** - Quick start guide
- **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - Comprehensive testing guide
- **[benches/README.md](benches/README.md)** - Benchmark-specific documentation

## Maintenance

### Updating Dependencies

```bash
# Update all dependencies
cargo update

# Update specific dependency
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

### Cleaning Build Artifacts

```bash
# Clean all build artifacts
cargo clean

# Clean only benchmark results
rm -rf target/criterion
```

## Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Timely Dataflow**: [https://github.com/TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow**: [https://github.com/TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## License

Apache-2.0

## Support and Questions

For questions about:
- **Benchmark results** - See `benches/README.md` and `TESTING_GUIDE.md`
- **Adding benchmarks** - See Contributing section above
- **Performance issues** - Check Criterion documentation
- **Framework comparisons** - Review existing benchmark implementations

## Version History

- **v0.0.0** (November 2025) - Initial repository creation with benchmarks migrated from main repository

## Acknowledgments

- Wordlist from [dwyl/english-words](https://github.com/dwyl/english-words)
- Built with [Criterion.rs](https://github.com/bheisler/criterion.rs)
- Benchmarks originally developed in the main Hydro repository