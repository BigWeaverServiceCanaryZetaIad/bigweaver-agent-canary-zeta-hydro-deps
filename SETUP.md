# Setup Instructions

## Overview

This repository contains benchmarks migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. The benchmarks are designed for performance evaluation and comparison.

## Prerequisites

To run the benchmarks, you need:

1. Rust toolchain (stable or nightly)
2. Access to the main `bigweaver-agent-canary-hydro-zeta` repository (for dependencies)

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md           # Repository overview
├── SETUP.md           # This file
└── benches/           # Benchmark package
    ├── Cargo.toml     # Package configuration
    ├── README.md      # Benchmark documentation
    └── benches/       # Benchmark implementations
        ├── futures.rs
        ├── micro_ops.rs
        ├── symmetric_hash_join.rs
        ├── words_diamond.rs
        └── words_alpha.txt
```

## Dependency Configuration

The `benches/Cargo.toml` references path dependencies from the main repository:
- `dfir_rs` - Hydro's DFIR implementation
- `sinktools` - Utility tools

### Option 1: Clone Both Repositories Side-by-Side

```bash
# Clone both repositories in the same parent directory
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# The path dependencies in benches/Cargo.toml should work with this structure
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo build
```

### Option 2: Adjust Path Dependencies

If you have a different directory structure, update the paths in `benches/Cargo.toml`:

```toml
dfir_rs = { path = "/path/to/bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "/path/to/bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Option 3: Use a Cargo Workspace

Create a `Cargo.toml` workspace file in the parent directory:

```toml
[workspace]
members = [
    "bigweaver-agent-canary-hydro-zeta/dfir_rs",
    "bigweaver-agent-canary-hydro-zeta/sinktools",
    "bigweaver-agent-canary-zeta-hydro-deps/benches",
]
```

## Running Benchmarks

Once dependencies are configured:

```bash
cd benches

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench micro_ops
cargo bench --bench words_diamond
cargo bench --bench symmetric_hash_join
cargo bench --bench futures

# View results
# HTML reports are generated in target/criterion/ (if criterion's html_reports feature is enabled)
```

## Benchmark Output

Criterion generates detailed reports including:
- Execution time measurements
- Statistical analysis
- HTML reports with graphs (in `target/criterion/`)
- Comparison with previous runs

## Troubleshooting

### Path Dependency Not Found

If you get errors about `dfir_rs` or `sinktools` not being found:
1. Verify the main repository is cloned in the expected location
2. Update the path dependencies in `benches/Cargo.toml`
3. Ensure the main repository is on a compatible branch/commit

### Build Errors

If benchmarks fail to build:
1. Ensure you have the latest Rust toolchain: `rustup update`
2. Check that all path dependencies are accessible
3. Verify the main repository builds successfully first

## Future Enhancements

This repository is designed to support future additions:
- Timely/differential-dataflow comparison implementations
- Additional benchmark scenarios
- Performance regression testing
- Cross-framework comparative analysis

## Migration History

These benchmarks were migrated on December 19, 2024. See the BENCHMARK_MIGRATION.md file in the main repository for complete migration history.
