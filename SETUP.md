# Setup and Usage Guide

This document explains how to set up and use the Hydro dependencies repository for benchmarking and performance comparison.

## Prerequisites

- Rust toolchain (will be automatically installed based on `rust-toolchain.toml`)
- Git

## Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run benchmarks:
   ```bash
   cd benches
   cargo bench
   ```

## Benchmarks

### Available Benchmarks

The `benches/` directory contains performance comparison benchmarks between Hydro and Timely/Differential Dataflow:

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in patterns
- **fan_out** - Fan-out patterns  
- **fork_join** - Fork-join patterns
- **identity** - Identity/passthrough operations
- **join** - Join operations
- **reachability** - Graph reachability algorithms
- **upcase** - String transformation operations

### Running Benchmarks

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench reachability
```

Run with different parameters:
```bash
cargo bench -- --warm-up-time 5 --measurement-time 10
```

### Viewing Results

Benchmark results are saved in `target/criterion/`. Open the HTML reports for detailed visualizations:

```bash
open target/criterion/report/index.html
```

## Development

### Code Quality

This repository follows the same code quality standards as the main Hydro repository:

- Run formatter: `cargo fmt --check`
- Run linter: `cargo clippy`

### Keeping Benchmarks Up-to-Date

The benchmarks depend on `dfir_rs` and `sinktools` from the main Hydro repository via git dependencies. To update to the latest version:

```bash
cargo update
```

## Performance Comparison Workflow

1. **Baseline**: Run benchmarks in this repository to establish Hydro vs Timely/Differential performance
2. **Development**: Make changes in the main Hydro repository
3. **Comparison**: Re-run these benchmarks to verify performance characteristics are maintained or improved
4. **Analysis**: Use the Criterion HTML reports to analyze detailed performance metrics

## Architecture

The repository is structured to:

- Keep heavy dependencies (timely, differential-dataflow) isolated
- Reference Hydro components via git dependencies
- Allow independent versioning and updates
- Maintain compatibility with the main Hydro development workflow

## Troubleshooting

### Build Issues

If you encounter build issues, ensure:
- Your Rust toolchain is up-to-date (handled by `rust-toolchain.toml`)
- Git dependencies are accessible
- All necessary system dependencies are installed

### Benchmark Failures

If benchmarks fail:
- Check that data files (e.g., `reachability_edges.txt`) are present
- Verify memory and CPU resources are sufficient
- Review benchmark-specific documentation in the source files

## Contributing

When adding new benchmarks:

1. Place benchmark files in `benches/benches/`
2. Add the benchmark entry to `benches/Cargo.toml`
3. Update `benches/README.md` with benchmark description
4. Ensure benchmarks run successfully with `cargo bench`
5. Update this document if new setup steps are required

## Links

- Main Hydro Repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
