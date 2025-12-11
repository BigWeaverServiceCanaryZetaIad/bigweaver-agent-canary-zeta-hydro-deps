# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

December 11, 2024

## Rationale

The benchmarks were moved to achieve the following goals:

1. **Clean Dependency Graph**: Remove timely and differential-dataflow dependencies from the main Hydro repository
2. **Modular Architecture**: Separate core functionality from external comparison benchmarks
3. **Performance Comparison**: Maintain the ability to compare Hydro/DFIR performance with other dataflow systems
4. **Repository Focus**: Keep the main repository focused on Hydro development without external framework dependencies

## Migrated Benchmarks

### Timely-Dataflow Benchmarks
The following benchmarks compare Hydro/DFIR with timely-dataflow:

- `arithmetic.rs` - Sequential arithmetic operations
- `fan_in.rs` - Multiple inputs merging into single output
- `fan_out.rs` - Single input splitting to multiple outputs
- `fork_join.rs` - Fork-join pattern with filtering
- `identity.rs` - Pass-through/identity operations
- `join.rs` - Join operations on streams
- `upcase.rs` - String transformation operations

### Differential-Dataflow Benchmarks
The following benchmarks compare Hydro/DFIR with differential-dataflow:

- `reachability.rs` - Graph reachability computation with iterative queries
  - Supporting files: `reachability_edges.txt`, `reachability_reachable.txt`

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # Repository documentation
├── MIGRATION.md                  # This file
├── rust-toolchain.toml           # Rust version pinning
├── rustfmt.toml                  # Code formatting configuration
├── clippy.toml                   # Linting configuration
└── benches/
    ├── Cargo.toml                # Benchmark package with dependencies
    ├── README.md                 # Benchmark usage documentation
    ├── build.rs                  # Build script for code generation
    └── benches/                  # Benchmark implementations
        ├── .gitignore
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Dependencies

The benchmarks depend on:

### From Main Repository (via Git)
- `dfir_rs` - Core DFIR runtime with debugging features
- `sinktools` - Utility crate for sink operations

### External Crates
- `timely-master` (v0.13.0-dev.1) - Timely-dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential-dataflow framework
- `criterion` (v0.5.0) - Benchmarking framework with async support
- `tokio` (v1.29.0) - Async runtime for multi-threaded benchmarks

### Supporting Crates
- `futures`, `rand`, `rand_distr`, `seq-macro`, `nameof`, `static_assertions`

## Running Benchmarks

### Quick Start
```bash
cd benches
cargo bench
```

### Run Specific Benchmark
```bash
cd benches
cargo bench --bench arithmetic
cargo bench --bench reachability
```

### Run with Custom Workers
```bash
cd benches
cargo bench --bench reachability -- --workers 4
```

### View Results
Benchmark results are saved as HTML reports in:
```
target/criterion/<benchmark_name>/report/index.html
```

## Performance Comparison Workflow

To compare Hydro/DFIR performance with timely/differential-dataflow:

1. **Run External Framework Benchmarks** (this repository):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench
   ```

2. **Run Equivalent Hydro Benchmarks** (main repository):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   # Run equivalent benchmarks if available
   cargo test --release --package dfir_rs --example <equivalent_example>
   ```

3. **Compare Results**:
   - View Criterion HTML reports in `target/criterion/`
   - Compare throughput, latency, and resource usage
   - Document findings for optimization work

## Changes to Main Repository

The following changes were made to `bigweaver-agent-canary-hydro-zeta`:

1. **Removed**: `benches/` directory and all its contents
2. **Updated**: `CONTRIBUTING.md` with documentation about the benchmark migration
3. **Cleaned**: `Cargo.lock` to remove timely/differential-dataflow dependencies (requires `cargo update`)

## Maintenance

### Keeping Dependencies in Sync

The `dfir_rs` and `sinktools` dependencies point to the main repository via git. To update to the latest version:

```bash
cd benches
cargo update
```

### Adding New Benchmarks

To add a new benchmark comparing with timely/differential-dataflow:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Implement the benchmark using Criterion
4. Update `benches/README.md` with benchmark description
5. Run the benchmark to verify it works

### Version Updates

When updating timely or differential-dataflow versions:

1. Update version in `benches/Cargo.toml`
2. Test all benchmarks to ensure compatibility
3. Document any API changes in this file
4. Update README with any new instructions

## Integration with CI/CD

Currently, benchmarks are run manually. For CI/CD integration:

1. Consider adding GitHub Actions workflow for benchmark regression testing
2. Set up performance tracking over time
3. Configure notifications for significant performance changes
4. Use `cargo bench -- --save-baseline <name>` for baseline comparisons

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion.rs: https://github.com/bheisler/criterion.rs

## Contact

For questions about the benchmarks or migration, refer to the main repository's CONTRIBUTING.md or open an issue.
