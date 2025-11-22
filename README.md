# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow`. These dependencies have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the main codebase cleaner and avoid unnecessary dependencies.

## Overview

This repository was created to isolate external dataflow system dependencies (timely and differential-dataflow) while maintaining the ability to perform comprehensive performance comparisons with Hydro's dfir_rs implementation.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks between Hydro (dfir_rs) and other dataflow systems:

#### Timely Dataflow Comparisons
- **arithmetic.rs** - Pipeline arithmetic operations comparison with timely
- **fan_in.rs** - Fan-in pattern benchmarks with timely
- **fan_out.rs** - Fan-out pattern benchmarks with timely
- **fork_join.rs** - Fork-join pattern benchmarks with timely
- **identity.rs** - Identity operation benchmarks with timely
- **join.rs** - Join operation benchmarks with timely
- **upcase.rs** - Uppercase transformation benchmarks with timely

#### Differential Dataflow Comparisons
- **reachability.rs** - Graph reachability benchmarks comparing dfir_rs, timely, and differential-dataflow

#### Data Files
- **reachability_edges.txt** - Graph edge data for reachability benchmarks (532KB)
- **reachability_reachable.txt** - Expected reachable nodes for verification (38KB)

## Setup

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in main repository for version)
- Main repository (`bigweaver-agent-canary-hydro-zeta`) available at `../bigweaver-agent-canary-hydro-zeta`

### Local Development Setup

This repository references the main Hydro repository via local path dependencies for development:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

This ensures benchmarks always compare against your local development version of Hydro.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches-timely-differential
```

### Run Specific Benchmark

```bash
# Run reachability benchmark
cargo bench -p benches-timely-differential --bench reachability

# Run arithmetic benchmark
cargo bench -p benches-timely-differential --bench arithmetic

# Run join benchmark
cargo bench -p benches-timely-differential --bench join
```

### Run With Filters

```bash
# Run only timely benchmarks from reachability
cargo bench -p benches-timely-differential --bench reachability -- timely

# Run only differential benchmarks
cargo bench -p benches-timely-differential --bench reachability -- differential

# Run only dfir_rs benchmarks
cargo bench -p benches-timely-differential --bench reachability -- dfir
```

### Quick Benchmark Run

For faster iteration during development:

```bash
# Run benchmarks with reduced sample size
cargo bench -p benches-timely-differential -- --quick
```

## Performance Comparisons

These benchmarks allow for direct performance comparisons between:
- **Hydro (dfir_rs)** - The main Hydro dataflow system
- **Timely Dataflow** - A low-latency data-parallel dataflow system
- **Differential Dataflow** - An implementation of differential dataflow over timely dataflow

### Viewing Results

Benchmark results are generated in HTML format by Criterion:

```bash
# After running benchmarks, open the report
open target/criterion/report/index.html
# or on Linux
xdg-open target/criterion/report/index.html
```

### Comparing Performance Over Time

Criterion automatically compares against previous runs. To compare specific versions:

1. Run benchmarks on the baseline version
2. Make changes to the main repository
3. Run benchmarks again - Criterion will show the comparison

### Performance Analysis

Each benchmark provides:
- **Execution time** - Mean, median, standard deviation
- **Throughput** - Operations per second where applicable
- **Comparison charts** - Visual representation of performance differences
- **Regression detection** - Automatic detection of performance changes

## Benefits of Separation

By maintaining these benchmarks in a separate repository, we achieve:

1. **Clean Dependencies** - Main repository remains free of timely/differential-dataflow dependencies
2. **Reduced Build Time** - Main repository builds faster without external dataflow dependencies
3. **Independent Evolution** - Both repositories can evolve independently
4. **Preserved Capability** - Full performance comparison functionality is retained
5. **Better Organization** - Clear separation between internal and comparison benchmarks
6. **Flexible Testing** - Can benchmark against external systems without coupling main codebase

## Relationship to Main Repository

This repository maintains benchmarks that were originally part of `bigweaver-agent-canary-hydro-zeta`. The benchmarks reference the main repository's code (dfir_rs, sinktools) to ensure comparisons are always against the current version.

### Migration History

These benchmarks were moved from the main repository on 2024-11-22. See the following documents in the main repository for details:
- `REMOVAL_SUMMARY.md` - Complete list of moved files and changes
- `MIGRATION_NOTES.md` - Detailed migration information
- `CHANGES_README.md` - Quick reference guide

## Adding New Benchmarks

To add a new comparison benchmark:

1. Create a new `.rs` file in `benches/benches/` directory
2. Implement benchmark functions using the Criterion framework
3. Add benchmark definition to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
4. Run with `cargo bench -p benches-timely-differential --bench your_benchmark_name`

## Troubleshooting

### Build Issues

If you encounter build issues:

```bash
# Clean and rebuild
cargo clean
cargo build -p benches-timely-differential

# Check dependency tree
cargo tree -p benches-timely-differential
```

### Path Issues

Ensure the main repository is located at the correct relative path:
- Expected: `../bigweaver-agent-canary-hydro-zeta`
- If different, update paths in `benches/Cargo.toml`

### Version Conflicts

If you encounter version conflicts with timely or differential-dataflow:
- Check the main repository's lock file for compatible versions
- Update dependency versions in `benches/Cargo.toml` to match

## CI/CD Integration

To integrate these benchmarks into CI/CD pipelines:

1. Add a workflow that clones both repositories
2. Run benchmarks on PRs or scheduled intervals
3. Compare results against baseline
4. Report performance regressions

Example workflow structure:
```yaml
- name: Checkout deps repo
  uses: actions/checkout@v3
- name: Checkout main repo
  uses: actions/checkout@v3
  with:
    repository: hydro-project/hydro
    path: ../bigweaver-agent-canary-hydro-zeta
- name: Run benchmarks
  run: cargo bench -p benches-timely-differential
```

## Performance Testing Best Practices

1. **Consistent Environment** - Run benchmarks on consistent hardware
2. **Multiple Runs** - Criterion automatically runs multiple iterations
3. **Warm-up** - Criterion includes warm-up iterations
4. **Baseline Comparison** - Always compare against a known baseline
5. **Resource Monitoring** - Monitor CPU and memory during benchmarks
6. **Document Changes** - Record significant performance changes

## References

- Main Repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion Documentation: https://bheisler.github.io/criterion.rs/book/

## Support

For questions about these benchmarks:
1. Review the documentation in this repository
2. Check the main repository's documentation
3. Consult the REMOVAL_SUMMARY.md and MIGRATION_NOTES.md in the main repository
4. Open an issue in the appropriate repository

## License

Apache-2.0 (same as main repository)