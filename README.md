# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for performance comparison testing between dfir_rs/Hydro and external dataflow frameworks (timely and differential-dataflow). This repository was created to isolate these dependencies from the main bigweaver-agent-canary-hydro-zeta repository while preserving performance comparison functionality.

## Purpose

The primary goals of this repository are:

1. **Dependency Isolation**: Keep timely and differential-dataflow dependencies separate from the main codebase
2. **Performance Comparison**: Enable data-driven performance evaluation between different dataflow implementations
3. **Benchmark Preservation**: Maintain historical benchmark code that compares dfir_rs against established frameworks
4. **Clean Architecture**: Support the team's architectural principle of separating concerns and managing dependencies proactively

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # This file
└── benches/                      # Benchmark package
    ├── Cargo.toml                # Benchmark dependencies including timely and differential-dataflow
    ├── README.md                 # Detailed benchmark documentation
    ├── build.rs                  # Build script for generated benchmarks
    └── benches/                  # Benchmark implementations
        ├── arithmetic.rs         # Arithmetic operations benchmark
        ├── fan_in.rs            # Fan-in pattern benchmark
        ├── fan_out.rs           # Fan-out pattern benchmark
        ├── fork_join.rs         # Fork-join pattern benchmark
        ├── identity.rs          # Identity operations benchmark
        ├── join.rs              # Join operations benchmark
        ├── reachability.rs      # Graph reachability benchmark
        ├── upcase.rs            # String transformation benchmark
        ├── reachability_edges.txt        # Test data for reachability
        └── reachability_reachable.txt    # Expected results for reachability
```

## Quick Start

### Prerequisites

- Rust toolchain (2024 edition or later)
- Git access to the main bigweaver-agent-canary-hydro-zeta repository

### Installation

Clone this repository:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Graph reachability
cargo bench -p benches --bench reachability

# All timely implementations
cargo bench -p benches -- timely

# All dfir_rs implementations
cargo bench -p benches -- dfir_rs
```

View detailed results:
```bash
# HTML reports are generated in:
open target/criterion/*/report/index.html
```

## Benchmarks Overview

This repository includes 8 comprehensive benchmarks comparing performance across different implementations:

| Benchmark | Purpose | Frameworks Compared |
|-----------|---------|-------------------|
| **arithmetic** | Arithmetic operation pipelines | timely, dfir_rs, raw baseline |
| **fan_in** | Multiple streams merging | timely, dfir_rs |
| **fan_out** | Stream splitting pattern | timely, dfir_rs |
| **fork_join** | Fork-join dataflow | timely, dfir_rs |
| **identity** | Basic data passing | timely, dfir_rs, raw baseline |
| **join** | Keyed join operations | timely, dfir_rs |
| **reachability** | Graph reachability computation | timely, differential, dfir_rs |
| **upcase** | String transformations | timely, dfir_rs |

For detailed documentation on each benchmark, see [`benches/README.md`](benches/README.md).

## Dependencies

### External Framework Dependencies

This repository explicitly includes:
- **timely** (v0.13.0-dev.1): Timely Dataflow framework for comparison benchmarks
- **differential-dataflow** (v0.13.0-dev.1): Differential Dataflow framework for incremental computation benchmarks

### Main Repository Dependencies

The benchmarks reference the main repository for:
- **dfir_rs**: The primary dataflow framework being benchmarked
- **sinktools**: Utility tools for dataflow operations

These are pulled via git from the main bigweaver-agent-canary-hydro-zeta repository.

### Local Development

For local development with both repositories checked out, create `.cargo/config.toml`:

```toml
[patch."https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git"]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

This allows faster iteration without waiting for git operations.

## Performance Comparison

### Methodology

The benchmarks use Criterion.rs for statistical analysis and provide:
- Mean execution time with confidence intervals
- Performance regression detection
- Historical trend tracking
- Detailed HTML reports with graphs

### Interpreting Results

When comparing frameworks:
1. **Baseline measurements**: Raw/pipeline implementations establish minimum overhead
2. **Framework overhead**: Difference between framework and baseline implementations
3. **Relative performance**: Direct comparison between timely, differential, and dfir_rs
4. **Optimization impact**: Compiled vs surface syntax dfir_rs performance

Lower times indicate better performance. Focus on relative comparisons rather than absolute values.

### Example Output

```
arithmetic/raw          time: [245.67 µs 247.23 µs 248.91 µs]
arithmetic/timely       time: [892.45 µs 897.12 µs 902.34 µs]
arithmetic/dfir_rs      time: [654.23 µs 658.90 µs 663.87 µs]
arithmetic/dfir_compiled time: [432.11 µs 435.67 µs 439.45 µs]
```

This shows dfir_compiled achieves performance closer to the raw baseline than timely.

## Architecture

### Separation of Concerns

This repository follows the team's architectural principles:
- **Isolated dependencies**: timely and differential-dataflow are kept out of the main repository
- **Focused benchmarking**: Dedicated repository for performance comparison
- **Clean codebase**: Main repository avoids unnecessary external dependencies
- **Modular design**: Benchmarks can be developed independently

### Repository Relationship

```
Main Repository (bigweaver-agent-canary-hydro-zeta)
    ├── Core dataflow implementation (dfir_rs)
    ├── Supporting libraries (sinktools, lattices, etc.)
    └── Core benchmarks (futures, micro_ops, etc.)

Dependencies Repository (bigweaver-agent-canary-zeta-hydro-deps)
    └── Comparison benchmarks
        ├── Uses dfir_rs from main repository
        ├── Includes timely and differential-dataflow
        └── Compares performance across frameworks
```

### Design Decisions

**Q: Why separate repositories?**
A: To prevent timely and differential-dataflow dependencies from affecting the main repository's build times and dependency tree. This follows the team's principle of proactive dependency management.

**Q: Why keep these benchmarks?**
A: Performance comparison against established frameworks provides valuable data for optimization decisions and helps validate that dfir_rs remains competitive.

**Q: Why use git dependencies instead of local paths?**
A: Git dependencies ensure the benchmarks use the latest main repository code and work in CI environments. Local paths can be used for development via cargo patches.

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Benchmark

on:
  push:
    branches: [ main ]
  pull_request:

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install Rust
        uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
          
      - name: Run Benchmarks
        run: cargo bench -p benches --output-format bencher | tee output.txt
        
      - name: Store Results
        uses: benchmark-action/github-action-benchmark@v1
        with:
          tool: 'cargo'
          output-file-path: output.txt
          github-token: ${{ secrets.GITHUB_TOKEN }}
          auto-push: true
```

### Regression Detection

Configure Criterion for automated regression alerts:
```rust
Criterion::default()
    .significance_level(0.05)  // 5% significance level
    .noise_threshold(0.03)      // 3% noise threshold
```

## Contributing

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   
   fn my_benchmark(c: &mut Criterion) {
       // Implementation
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. Register in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Document in `benches/README.md`

### Best Practices

1. **Fair comparisons**: Ensure all implementations solve the exact same problem
2. **Realistic data**: Use data sizes and distributions representative of real workloads
3. **Black box**: Use `black_box()` to prevent compiler optimizations
4. **Documentation**: Clearly document what each benchmark measures and why
5. **Baselines**: Include raw/pipeline baselines where applicable

### Code Review

When submitting benchmarks for review:
- Verify all implementations produce identical results
- Include assertions to validate correctness
- Document performance expectations
- Explain any surprising results

## Troubleshooting

### Build Issues

**Dependencies not found:**
```bash
# Clean and rebuild
cargo clean
cargo build -p benches
```

**Git dependency issues:**
```bash
# Update dependencies
cargo update -p benches

# Force refetch
rm -rf ~/.cargo/git/checkouts/
cargo build -p benches
```

### Performance Issues

**Benchmarks too slow:**
```bash
# Quick benchmarks with reduced samples
cargo bench -p benches -- --quick --sample-size 10

# Run specific benchmarks only
cargo bench -p benches --bench micro_ops
```

**Inconsistent results:**
- Close other applications
- Disable CPU frequency scaling
- Run multiple iterations
- Check for thermal throttling

### Verification

Verify benchmark integrity:
```bash
# All benchmarks should build
cargo build -p benches

# All tests should pass (if any)
cargo test -p benches

# Benchmarks should run without errors
cargo bench -p benches --no-run
```

## Maintenance

### Updating Dependencies

```bash
# Update all dependencies
cargo update

# Update specific dependencies
cargo update -p timely
cargo update -p differential-dataflow
```

### Synchronizing with Main Repository

When the main repository changes:
```bash
# Force cargo to fetch latest version
cargo update -p dfir_rs
cargo update -p sinktools

# Rebuild
cargo clean
cargo build -p benches
```

### Cleaning Old Results

```bash
# Remove old benchmark results
rm -rf target/criterion/

# Full clean
cargo clean
```

## Related Resources

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Timely Dataflow**: [GitHub](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow**: [GitHub](https://github.com/TimelyDataflow/differential-dataflow)
- **Criterion.rs**: [Book](https://bheisler.github.io/criterion.rs/book/)

## Migration History

These benchmarks were migrated from the main repository to:
1. Reduce dependency complexity in the main repository
2. Isolate timely and differential-dataflow dependencies
3. Maintain performance comparison capability
4. Follow clean architecture principles

For migration details, see the main repository's `MIGRATION_NOTES.md`.

## License

Apache-2.0

## Support

For questions or issues:
1. Check this README and `benches/README.md`
2. Review benchmark code for examples
3. Consult main repository documentation
4. Open an issue for specific problems

---

**Note**: This repository is specifically designed to maintain benchmarks with external framework dependencies (timely and differential-dataflow) that are intentionally kept separate from the main codebase. The performance comparison functionality enables data-driven optimization decisions.