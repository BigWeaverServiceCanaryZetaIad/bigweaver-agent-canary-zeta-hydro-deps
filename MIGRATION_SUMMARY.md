# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) to this dedicated dependencies repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

November 29, 2025

## Rationale

The benchmarks were moved to:
1. Isolate timely and differential-dataflow dependencies from the main Hydro repository
2. Maintain the ability to run performance comparisons between Hydro and these frameworks
3. Keep the main repository's dependency tree cleaner and more focused

## Migrated Files

The following benchmark files and directories were migrated:

### Benchmark Tests
- `benches/benches/arithmetic.rs` - Arithmetic operations benchmarks
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Futures-based operations benchmarks
- `benches/benches/identity.rs` - Identity operations benchmarks
- `benches/benches/join.rs` - Join operations benchmarks
- `benches/benches/micro_ops.rs` - Micro-operations benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/upcase.rs` - String transformation benchmarks
- `benches/benches/words_diamond.rs` - Word processing diamond pattern benchmarks

### Data Files
- `benches/benches/reachability_edges.txt` - Graph edges for reachability benchmarks
- `benches/benches/reachability_reachable.txt` - Expected reachable nodes
- `benches/benches/words_alpha.txt` - English wordlist for word processing benchmarks (from https://github.com/dwyl/english-words)

### Configuration Files
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script for generating benchmark code
- `benches/benches/.gitignore` - Git ignore rules for benchmark outputs

## Dependencies

The migrated benchmarks depend on:

### From Main Hydro Repository (via Git)
- `dfir_rs` - DFIR runtime with debugging features
- `sinktools` - Sink utilities

### External Dependencies
- `timely-master` (v0.13.0-dev.1) - Timely-dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential-dataflow framework
- `criterion` (v0.5.0) - Benchmark framework
- Various supporting dependencies (futures, rand, etc.)

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # Repository documentation
├── MIGRATION_SUMMARY.md          # This file
└── benches/                      # Benchmark package
    ├── Cargo.toml                # Package configuration
    ├── README.md                 # Benchmark documentation
    ├── build.rs                  # Build script
    └── benches/                  # Benchmark tests
        ├── .gitignore
        ├── *.rs                  # Benchmark source files
        └── *.txt                 # Benchmark data files
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

## Changes Made

1. **In bigweaver-agent-canary-hydro-zeta repository:**
   - Removed `benches/` directory (already done in previous commit)
   - Removed `benches` from workspace members in root `Cargo.toml` (already done)
   - Updated `CONTRIBUTING.md` to reference new benchmark location

2. **In bigweaver-agent-canary-zeta-hydro-deps repository:**
   - Created workspace `Cargo.toml` at repository root
   - Added complete `benches/` directory structure
   - Updated `benches/Cargo.toml` to use git dependencies for `dfir_rs` and `sinktools`
   - Updated `README.md` with comprehensive documentation
   - Updated `benches/README.md` with migration note
   - Created this migration summary document

## Maintenance Notes

- The benchmarks reference `dfir_rs` and `sinktools` from the main repository via git dependencies
- Updates to the main repository's APIs may require corresponding updates in these benchmarks
- Benchmark data files (particularly `words_alpha.txt`) are large and tracked in git
- The build script (`build.rs`) generates additional benchmark code at compile time

## Performance Comparison Capability

The migration maintains full performance comparison capability by:
1. Preserving all original benchmark implementations
2. Maintaining the same benchmark structure and interfaces
3. Keeping reference data files intact
4. Using git dependencies to stay current with main repository changes
