# Setup and Usage Guide

## Overview

This repository contains performance benchmarks that compare Hydro implementations with timely and differential-dataflow. The benchmarks were separated from the main Hydro repository to keep the main codebase free from these specific dependencies.

## Prerequisites

- Rust toolchain (recommended: rustc 1.70 or later)
- Cargo
- Git

## Initial Setup

1. Clone this repository:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

2. The first build will fetch dependencies from the main Hydro repository:
```bash
cargo build
```

This may take some time as it downloads and compiles:
- dfir_rs from the main Hydro repository
- sinktools from the main Hydro repository
- timely-master and differential-dataflow-master packages
- Other benchmark dependencies

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

This will run all benchmark suites and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark

```bash
cargo bench --bench <benchmark-name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in data flow patterns
- `fan_out` - Fan-out data flow patterns
- `fork_join` - Fork-join patterns
- `futures` - Async futures handling
- `identity` - Identity transformations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability (uses data files)
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String case transformations
- `words_diamond` - Diamond pattern word processing (uses data files)

### Example Commands

```bash
# Run reachability benchmark
cargo bench --bench reachability

# Run arithmetic and join benchmarks
cargo bench --bench arithmetic --bench join

# Run with verbose output
cargo bench --verbose
```

## Viewing Results

Benchmark results are saved in HTML format:

```bash
# Results are in target/criterion/
ls -la target/criterion/

# Open reports in browser (example for Linux)
xdg-open target/criterion/report/index.html

# Or for macOS
open target/criterion/report/index.html
```

## Performance Comparison Workflow

To compare performance between different implementations:

1. Run benchmarks to establish baseline:
```bash
cargo bench
```

2. Make changes to the main Hydro repository (if testing changes)

3. Update the git dependency in Cargo.toml to point to your branch:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", branch = "your-branch", features = [ "debugging" ] }
```

4. Clear previous results and re-run:
```bash
rm -rf target/criterion
cargo bench
```

5. Compare the new results with the baseline in the HTML reports

## Troubleshooting

### Build Failures

If you encounter build failures:

1. Ensure you have the latest Rust toolchain:
```bash
rustup update
```

2. Clean the build directory:
```bash
cargo clean
cargo build
```

3. Check that you have network access to download dependencies

### Benchmark Failures

If benchmarks fail to run:

1. Check that data files are present in `benches/`:
   - `reachability_edges.txt`
   - `reachability_reachable.txt`
   - `words_alpha.txt`

2. Verify that dependencies compiled successfully:
```bash
cargo check
```

## Updating Dependencies

To update to the latest version of the main Hydro repository:

```bash
cargo update
```

This will fetch the latest commits from the main repository's git dependencies.

## Development

To work on the benchmarks:

1. Benchmark files are located in `benches/`
2. Each benchmark uses the Criterion framework
3. Follow the existing patterns when adding new benchmarks
4. Ensure new benchmarks include both Hydro and timely/differential implementations for comparison

## Contributing

When contributing new benchmarks:

1. Follow the existing code structure and patterns
2. Include both Hydro and timely/differential implementations
3. Add appropriate documentation in code comments
4. Update the README.md with the new benchmark name and description
5. Test that benchmarks run successfully before submitting

## Notes

- Large data files (like `words_alpha.txt`) are included in the repository
- Benchmarks use the Criterion library for reliable performance measurements
- HTML reports include statistical analysis and historical comparisons
- The `build.rs` script generates some benchmark code at compile time
