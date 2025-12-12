# bigweaver-agent-canary-zeta-hydro-deps

## Purpose

This repository is designed to house benchmarks and performance testing code that require additional dataflow processing dependencies (such as `timely` and `differential-dataflow`). By separating these benchmarks from the main [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta) repository, we:

1. **Reduce main repository complexity** - Keep the core framework free from unnecessary benchmark dependencies
2. **Improve build times** - Avoid compiling heavy dependencies when working on core functionality
3. **Maintain performance testing capability** - Preserve the ability to run comprehensive performance comparisons
4. **Manage technical debt** - Separate concerns between production code and performance testing infrastructure

## Repository Structure

This repository follows a Cargo workspace structure to organize benchmarks by category:

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                      # This file
├── BENCHMARKS.md                  # Detailed benchmark documentation
└── benchmarks/                    # Benchmark implementations
    ├── dataflow_benchmarks/       # Benchmarks using timely/differential-dataflow
    └── integration_benchmarks/    # Cross-system performance tests
```

## Current Status

**Note**: As of the latest migration, no timely or differential-dataflow dependencies have been identified in the main repository. This repository is structured and ready to receive benchmark code when such dependencies are introduced.

The main repository currently uses standard Rust benchmarking tools (criterion) for performance testing. See the main repository's README for information about running those benchmarks.

## Adding Benchmarks

When adding benchmarks that require external dataflow dependencies:

1. Create a new crate under `benchmarks/` directory
2. Add the crate to the workspace members in the root `Cargo.toml`
3. Include necessary dependencies (timely, differential-dataflow, etc.) in the benchmark crate's `Cargo.toml`
4. Document the benchmark's purpose and usage in `BENCHMARKS.md`

### Example Benchmark Structure

```toml
# benchmarks/example_bench/Cargo.toml
[package]
name = "example_bench"
version = "0.1.0"
edition = "2024"

[dependencies]
timely = "0.12"
differential-dataflow = "0.12"
# Add other necessary dependencies from main repo
```

## Running Performance Comparisons

### Prerequisites

Ensure you have Rust and Cargo installed:

```bash
rustc --version
cargo --version
```

### Running Benchmarks

```bash
# Run all benchmarks in the workspace
cargo bench

# Run a specific benchmark crate
cd benchmarks/dataflow_benchmarks
cargo bench

# Run with specific features
cargo bench --features "full"
```

### Comparing with Main Repository

To compare performance between the main repository and benchmarks here:

1. **Run main repository benchmarks**:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench --package dfir_rs > main_results.txt
   ```

2. **Run deps repository benchmarks**:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo bench > deps_results.txt
   ```

3. **Compare results**:
   Use tools like `criterion-compare` or manual analysis of the output files.

## Migration History

This repository was created to separate benchmark dependencies from the main Hydro framework repository. The separation allows:

- **Main Repository**: Focus on core functionality without heavyweight benchmark dependencies
- **Deps Repository**: Comprehensive performance testing with all necessary tooling

### Files That May Be Migrated Here

When timely or differential-dataflow benchmarks are created, consider moving:

- Benchmark source files using these dependencies
- Performance test harnesses requiring these libraries
- Integration tests that measure dataflow performance

## Development

### Setting Up

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Build all benchmarks
cargo build --all

# Run tests
cargo test --all
```

### Code Quality

This repository follows the same code quality standards as the main repository:

- Run `cargo fmt` to format code
- Run `cargo clippy` to check for common mistakes
- Ensure all tests pass before committing

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta)**: Main Hydro framework repository
  - Contains core functionality, standard benchmarks, and production code
  - Uses criterion for built-in performance testing

## Documentation

- See [BENCHMARKS.md](BENCHMARKS.md) for detailed benchmark documentation
- For contributing guidelines, refer to the main repository's CONTRIBUTING.md

## Contact

For questions about benchmark infrastructure or performance testing, please refer to the main repository's development team documentation.