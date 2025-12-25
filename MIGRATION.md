# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from `bigweaver-agent-canary-hydro-zeta` to `bigweaver-agent-canary-zeta-hydro-deps`.

## Motivation

The benchmarks were migrated to achieve the following goals:

1. **Reduce dependencies**: Remove heavy timely-dataflow and differential-dataflow dependencies from the main codebase
2. **Improve build times**: Avoid compiling these dependencies in the main repository
3. **Maintain comparison capability**: Retain the ability to run performance comparisons between different dataflow implementations
4. **Simplify development**: Keep the main repository focused on core functionality

## Migrated Files

### Benchmark Files

The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches/benches/`:

- `arithmetic.rs` - Basic arithmetic operations
- `fan_in.rs` - Multiple input merging
- `fan_out.rs` - Single to multiple output splitting
- `fork_join.rs` - Fork and join patterns
- `identity.rs` - Identity transformation
- `join.rs` - Join operations
- `reachability.rs` - Graph reachability computation
- `upcase.rs` - String transformations

### Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

### Configuration Files

- Created `timely-differential-benches/Cargo.toml` with appropriate dependencies
- Created `timely-differential-benches/README.md` with usage instructions

## Changes to Main Repository

### Removed Dependencies

From `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`

### Removed Benchmarks

The following benchmark entries were removed from the main repository's `benches/Cargo.toml`:
- `[[bench]] name = "arithmetic"`
- `[[bench]] name = "fan_in"`
- `[[bench]] name = "fan_out"`
- `[[bench]] name = "fork_join"`
- `[[bench]] name = "identity"`
- `[[bench]] name = "upcase"`
- `[[bench]] name = "join"`
- `[[bench]] name = "reachability"`

### Retained Benchmarks

The following DFIR-native benchmarks remain in the main repository:
- `futures.rs` - Async/futures benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `words_diamond.rs` - Word processing diamond pattern

## Repository Setup

### Directory Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md
├── MIGRATION.md (this file)
├── scripts/
│   └── compare_benchmarks.sh
└── timely-differential-benches/
    ├── Cargo.toml
    ├── README.md
    └── benches/
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

## Running Benchmarks

### In the Deps Repository

To run the migrated benchmarks:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
cargo bench
```

### Cross-Repository Comparisons

To enable cross-repository comparisons with the main repository:

1. Clone both repositories side-by-side:
```bash
git clone <url>/bigweaver-agent-canary-hydro-zeta.git
git clone <url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. In `bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches/Cargo.toml`, uncomment the path dependencies:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

3. Run benchmarks:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

## Performance Comparison

The benchmarks compare the performance of different dataflow implementations:

- **timely-dataflow**: Low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **dfir_rs**: DFIR (Dataflow Intermediate Representation) implementation

To compare results:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

## Verification

To verify the migration was successful:

1. **Main repository builds without timely/differential dependencies**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build
   cargo test
   ```

2. **Deps repository benchmarks run successfully**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
   cargo bench
   ```

3. **Cross-repository path dependencies work**:
   - Uncomment path dependencies in deps repository
   - Run benchmarks
   - Verify DFIR implementations are compared against timely/differential

## Future Maintenance

### Adding New Benchmarks

- Add timely/differential benchmarks to `bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches/`
- Add DFIR-only benchmarks to `bigweaver-agent-canary-hydro-zeta/benches/`

### Updating Dependencies

- Update timely/differential versions in deps repository only
- Update DFIR dependencies in main repository

### Syncing Changes

When core DFIR implementations change:
1. Update code in main repository
2. Run benchmarks in deps repository with path dependencies enabled
3. Compare performance metrics
