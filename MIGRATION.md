# Benchmark Migration Documentation

## Overview

This document explains the migration of timely-dataflow and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated deps repository.

## Migration Date

December 2025

## Rationale

### Why Separate the Benchmarks?

1. **Dependency Management**: The main repository focuses on DFIR implementation and should not require timely or differential-dataflow as dependencies
2. **Build Performance**: Removing external dataflow dependencies significantly improves compilation time for core development
3. **Clean Architecture**: Separates performance comparison code from production code
4. **Focused Development**: Developers working on core DFIR features don't need to build external comparison frameworks

## What Was Migrated

### Benchmark Files

Eight benchmark files were migrated that use timely-dataflow or differential-dataflow:

| Benchmark | Description | Primary Dependency |
|-----------|-------------|-------------------|
| arithmetic.rs | Arithmetic operations | timely |
| fan_in.rs | Fan-in pattern | timely |
| fan_out.rs | Fan-out pattern | timely |
| fork_join.rs | Fork-join pattern | timely |
| identity.rs | Identity operation | timely |
| join.rs | Join operation | timely |
| reachability.rs | Graph reachability | differential-dataflow |
| upcase.rs | Uppercase transformation | timely |

### Supporting Files

- **Data Files**: 
  - `reachability_edges.txt` (533 KB) - Graph edge data
  - `reachability_reachable.txt` (38 KB) - Expected reachable nodes
  
- **Configuration Files**:
  - `rustfmt.toml` - Code formatting
  - `clippy.toml` - Linting rules
  - `rust-toolchain.toml` - Rust toolchain specification
  
- **Build Files**:
  - `build.rs` - Build script for benchmarks

## What Was NOT Migrated

The following benchmarks remain in the main repository (if they still exist) because they only test DFIR without external dependencies:

- `futures.rs` - Async/futures benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `words_diamond.rs` - Word processing diamond pattern
- `words_alpha.txt` - Word list data file

## Source Information

Benchmarks were extracted from:
- **Repository**: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- **Git Commit**: 484e6fdd (Sync with hydro-project/hydro)
- **Original Location**: `/benches/` directory

## Dependencies Added

```toml
[dev-dependencies]
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
```

## Usage

### Running Benchmarks

```bash
# All benchmarks
cargo bench

# Specific benchmark
cargo bench --bench arithmetic

# With flamegraph profiling (requires cargo-flamegraph)
cargo flamegraph --bench arithmetic
```

### Interpreting Results

Benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework which provides:
- Statistical analysis of measurements
- HTML reports with graphs (in `target/criterion/`)
- Automatic detection of performance changes
- Comparison between runs

### Adding New Benchmarks

When adding new benchmarks that compare DFIR with timely/differential-dataflow:

1. Add the benchmark file to `benches/benches/`
2. Add a `[[bench]]` entry to `benches/Cargo.toml`
3. Ensure the benchmark tests comparable functionality across implementations
4. Document the benchmark in `benches/README.md`
5. Include any required data files

## Maintenance

### Updating Dependencies

To update timely or differential-dataflow versions:

```bash
# Check for updates
cargo update --dry-run

# Update specific dependency
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

### Syncing Configuration

Configuration files (rustfmt.toml, clippy.toml) should be kept in sync with the main repository to maintain consistency:

```bash
# Copy from main repo
cp ../bigweaver-agent-canary-hydro-zeta/rustfmt.toml .
cp ../bigweaver-agent-canary-hydro-zeta/clippy.toml .
```

## Related Documentation

- [Main Repository BENCHMARKS.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARKS.md)
- [README.md](README.md) - This repository's main documentation
- [benches/README.md](benches/README.md) - Benchmark-specific documentation

## Questions?

For questions about:
- **Benchmarks**: See benchmark-specific documentation
- **Migration**: Refer to this document
- **Main Repository**: See the main repo's CONTRIBUTING.md
