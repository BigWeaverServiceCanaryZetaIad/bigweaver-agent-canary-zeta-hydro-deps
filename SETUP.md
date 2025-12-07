# Setup and Usage Guide

This repository contains benchmarks for Hydro that depend on `timely` and `differential-dataflow`.

## Prerequisites

- Rust (stable or nightly, matching the version used in the main Hydro repository)
- Cargo

## Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. The repository will automatically fetch dependencies from the main Hydro repository via git dependencies.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run a Specific Benchmark

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Fan-in dataflow pattern
- `fan_out` - Fan-out dataflow pattern
- `fork_join` - Fork-join pattern
- `identity` - Identity operation
- `join` - Join operations
- `reachability` - Graph reachability
- `upcase` - String uppercase transformation

### Example

```bash
cargo bench --bench arithmetic
```

## Performance Comparisons

Criterion automatically tracks performance over time. To explicitly work with baselines:

### Save a Baseline

```bash
cargo bench -- --save-baseline <baseline_name>
```

### Compare Against a Baseline

```bash
cargo bench -- --baseline <baseline_name>
```

### Example

```bash
# Save current performance as "before"
cargo bench -- --save-baseline before

# Make changes...

# Compare against saved baseline
cargo bench -- --baseline before
```

## Troubleshooting

### Build Failures

If you encounter build failures related to dependencies:

1. Ensure you have the latest version of Rust:
   ```bash
   rustup update
   ```

2. Clean the build cache:
   ```bash
   cargo clean
   ```

3. Rebuild:
   ```bash
   cargo bench
   ```

### Dependency Issues

The repository depends on components from the main Hydro repository via git dependencies. If you encounter issues:

1. Check that the git dependencies point to the correct repository and branch
2. Update dependencies:
   ```bash
   cargo update
   ```

## Development

When making changes to benchmarks:

1. Follow the same coding style as existing benchmarks
2. Test your changes:
   ```bash
   cargo bench --bench <your_benchmark>
   ```

3. Verify that benchmarks compile without warnings:
   ```bash
   cargo bench --no-run
   ```

## Additional Information

For more information about the benchmark split and why these benchmarks are in a separate repository, see the README.md file.

For information about the main Hydro project, visit the main repository at:
https://github.com/hydro-project/hydro
