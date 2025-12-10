# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including these heavy dependencies in the main codebase.

## Purpose

The benchmarks in this repository allow for performance comparison between:
- Hydro/DFIR implementations
- Timely-dataflow implementations
- Differential-dataflow implementations

By separating these benchmarks into a dedicated repository, the main Hydro codebase remains lightweight and free from timely/differential dependencies, while still maintaining the ability to perform comprehensive performance comparisons.

## Structure

- `benches/` - Contains microbenchmarks comparing different dataflow implementations
  - All benchmark files (`.rs`)
  - Associated data files (`.txt`)
  - Build configuration (`build.rs`)
  - Package manifest (`Cargo.toml`)

## Getting Started

### Prerequisites

- Rust toolchain 1.91.1 or later (specified in `rust-toolchain.toml`)
- Cargo build system

### Building the Benchmarks

```bash
cargo build --release -p hydro-timely-differential-benches
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches --bench reachability
cargo bench -p hydro-timely-differential-benches --bench arithmetic
cargo bench -p hydro-timely-differential-benches --bench join
```

See the [benches/README.md](benches/README.md) for detailed information about individual benchmarks.

## Performance Comparison Workflow

To perform a complete performance comparison across different dataflow implementations:

1. **Run DFIR-only benchmarks** from the main Hydro repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run timely/differential benchmarks** from this repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-timely-differential-benches
   ```

3. **Compare results**: Criterion saves benchmark results in `target/criterion/` within each repository. You can:
   - View the HTML reports generated in `target/criterion/*/report/index.html`
   - Compare raw data in the JSON files
   - Use Criterion's built-in comparison features for analyzing performance differences

## Benchmarks Included

The following benchmarks have been migrated to this repository:

- **arithmetic.rs** - Arithmetic operations benchmarks (timely + DFIR comparisons)
- **fan_in.rs** - Fan-in pattern benchmarks (timely + DFIR comparisons)
- **fan_out.rs** - Fan-out pattern benchmarks (timely + DFIR comparisons)
- **fork_join.rs** - Fork-join pattern benchmarks (timely + DFIR comparisons)
- **identity.rs** - Identity operation benchmarks (timely + DFIR comparisons)
- **join.rs** - Join operation benchmarks (timely only)
- **reachability.rs** - Graph reachability benchmarks (timely, differential + DFIR comparisons)
- **upcase.rs** - String uppercase transformation benchmarks (timely only)

### Associated Data Files

- **reachability_edges.txt** - Test data for reachability benchmarks
- **reachability_reachable.txt** - Expected results for reachability benchmarks

## Dependencies

This repository depends on:
- **timely-master** (0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - Referenced from the main Hydro repository via git dependency
- **sinktools** - Referenced from the main Hydro repository via git dependency
- **criterion** (0.5.0) - Benchmarking framework

## Code Quality

This repository follows the same code quality standards as the main Hydro repository:

- Code formatting: Run `cargo fmt` to format code
- Linting: Run `cargo clippy` to check for common issues
- Configuration files: `rustfmt.toml` and `clippy.toml` are kept in sync with the main repository

## Related Documentation

- See [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository for details about the migration process
- See [benches/README.md](benches/README.md) in this repository for detailed benchmark information
