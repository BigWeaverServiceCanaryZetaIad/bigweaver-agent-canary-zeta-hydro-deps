# Quick Start Guide

## Running Benchmarks

### Prerequisites
- Rust toolchain installed (`rustc` and `cargo`)
- Git configured for repository access

### Run All Benchmarks
```bash
cd benches
cargo bench -p benches
```

### Run Specific Benchmark
```bash
# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Graph reachability (uses differential-dataflow)
cargo bench -p benches --bench reachability

# Join operations
cargo bench -p benches --bench join

# Pattern benchmarks
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join

# Transformation benchmarks
cargo bench -p benches --bench identity
cargo bench -p benches --bench upcase
```

### Build Only (No Execution)
```bash
cd benches
cargo build --benches
```

## Available Benchmarks

| Benchmark | Library | Description |
|-----------|---------|-------------|
| `arithmetic` | timely | Arithmetic operations in pipeline |
| `fan_in` | timely | Multiple sources to single sink |
| `fan_out` | timely | Single source to multiple sinks |
| `fork_join` | timely | Fork-join pattern with filters |
| `identity` | timely | Identity transformation |
| `join` | timely | Join operations |
| `reachability` | differential | Graph reachability computation |
| `upcase` | timely | String transformation (uppercase) |

## What Gets Generated

During build, the following files are automatically generated:
- `benches/fork_join_20.hf` - Generated DFIR code for fork_join benchmark

These files are excluded from version control via `.gitignore`.

## Comparing with Hydro-Native Benchmarks

### This Repository (with timely/differential)
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -p benches
```

### Main Repository (Hydro-native only)
```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta/benches
cargo bench -p benches
```

Results can be compared to evaluate:
- Performance differences between implementations
- Overhead of external dataflow libraries
- Optimization opportunities

## Troubleshooting

### Build Fails
- Ensure Rust toolchain is installed: `rustc --version`
- Ensure cargo is available: `cargo --version`
- Check network connectivity for fetching dependencies

### Missing Dependencies
- Dependencies are automatically fetched by Cargo
- `dfir_rs` and `sinktools` are fetched from main repository via Git

### Generated Files Not Found
- The build script automatically runs before compilation
- If `fork_join_20.hf` is missing, cargo will regenerate it

## Documentation

- [README.md](README.md) - Repository overview
- [benches/README.md](benches/README.md) - Detailed benchmark documentation
- [MIGRATION_VERIFICATION.md](MIGRATION_VERIFICATION.md) - Migration checklist
- [BENCHMARK_VERIFICATION_REPORT.md](BENCHMARK_VERIFICATION_REPORT.md) - Comprehensive verification

## Repository Purpose

This repository contains benchmarks that were separated from the main Hydro repository to:
1. Reduce build dependencies in the main repository
2. Improve build times for core development
3. Maintain performance comparison capabilities
4. Create clear architectural boundaries

For core Hydro development without these dependencies, see [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).
