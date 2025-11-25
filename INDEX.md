# Documentation Index

This document provides an organized index of all documentation in this repository.

## Getting Started

Start here if you're new to this repository:

1. **[README.md](README.md)** - Repository overview and main documentation
2. **[QUICKSTART.md](QUICKSTART.md)** - Get up and running quickly
3. **[benches/README.md](benches/README.md)** - Benchmark directory overview

## Reference Documentation

### Benchmarks

- **[BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md)** - Comprehensive benchmark documentation
  - Individual benchmark descriptions
  - Performance characteristics
  - Implementation details
  - Interpreting results

### Migration

- **[MIGRATION.md](MIGRATION.md)** - Migration history and guide
  - What was migrated
  - Changes made
  - Running benchmarks after migration
  - Comparing performance across repositories

### Version History

- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes
  - Release notes
  - Dependency updates
  - Migration history

## Quick Reference

### Running Benchmarks

```bash
# All benchmarks
cargo bench -p timely-differential-benchmarks

# Specific benchmark
cargo bench -p timely-differential-benchmarks --bench arithmetic
```

### Benchmark List

| Benchmark | Type | File | Description |
|-----------|------|------|-------------|
| arithmetic | Timely | [benches/benches/arithmetic.rs](benches/benches/arithmetic.rs) | Arithmetic operations |
| fan_in | Timely | [benches/benches/fan_in.rs](benches/benches/fan_in.rs) | Fan-in pattern |
| fan_out | Timely | [benches/benches/fan_out.rs](benches/benches/fan_out.rs) | Fan-out pattern |
| fork_join | Timely | [benches/benches/fork_join.rs](benches/benches/fork_join.rs) | Fork-join pattern |
| identity | Timely | [benches/benches/identity.rs](benches/benches/identity.rs) | Identity operations |
| join | Timely | [benches/benches/join.rs](benches/benches/join.rs) | Join operations |
| upcase | Timely | [benches/benches/upcase.rs](benches/benches/upcase.rs) | String transformations |
| reachability | Differential | [benches/benches/reachability.rs](benches/benches/reachability.rs) | Graph reachability |

## Configuration Files

- **[Cargo.toml](Cargo.toml)** - Workspace configuration
- **[benches/Cargo.toml](benches/Cargo.toml)** - Benchmark package configuration
- **[benches/build.rs](benches/build.rs)** - Build script
- **[rust-toolchain.toml](rust-toolchain.toml)** - Rust toolchain specification
- **[rustfmt.toml](rustfmt.toml)** - Code formatting rules
- **[clippy.toml](clippy.toml)** - Linting configuration

## Scripts

- **[verify_benchmarks.sh](verify_benchmarks.sh)** - Verification script to ensure benchmarks are executable

## Data Files

- **[benches/benches/reachability_edges.txt](benches/benches/reachability_edges.txt)** - Graph edges for reachability benchmark (521 KB)
- **[benches/benches/reachability_reachable.txt](benches/benches/reachability_reachable.txt)** - Expected reachable nodes (38 KB)

## Documentation by Topic

### For New Users

1. [README.md](README.md) - Start here
2. [QUICKSTART.md](QUICKSTART.md) - Quick setup guide
3. [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md#running-benchmarks) - How to run benchmarks

### For Developers

1. [benches/README.md](benches/README.md#adding-new-benchmarks) - Adding benchmarks
2. [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md#extending-benchmarks) - Extending benchmarks
3. [Cargo.toml](Cargo.toml) - Dependencies and configuration

### For Performance Analysis

1. [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md#performance-characteristics) - Performance characteristics
2. [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md#interpreting-results) - Interpreting results
3. [MIGRATION.md](MIGRATION.md#comparing-performance) - Cross-repository comparison

### For Maintenance

1. [MIGRATION.md](MIGRATION.md) - Migration history
2. [CHANGELOG.md](CHANGELOG.md) - Version history
3. [verify_benchmarks.sh](verify_benchmarks.sh) - Verification script

## External Resources

### Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro repository

### Documentation

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/hydro-project/hydro)

## Document Maintenance

This index should be updated when:
- New documentation files are added
- Documentation structure changes
- New sections are added to existing documents
- External links change

---

**Last Updated**: November 25, 2024  
**Version**: 0.1.0
