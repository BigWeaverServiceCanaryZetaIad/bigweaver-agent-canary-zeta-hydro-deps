# Benchmark Migration History

This document tracks the history of benchmark migrations from the main Hydro repository to this dedicated benchmarks repository.

## Initial Migration

**Date**: December 2025

**Source Repository**: bigweaver-agent-canary-hydro-zeta (main Hydro repository)

**Purpose**: Separate benchmarks with external framework dependencies (timely-dataflow, differential-dataflow) from the main repository to avoid dependency pollution and keep the main codebase focused on core Hydro functionality.

### Benchmarks Migrated

The following benchmarks were moved from the main repository to this deps repository:

1. **arithmetic.rs** - Pipeline arithmetic operations benchmark
   - Uses: timely-dataflow
   - Purpose: Tests basic arithmetic pipeline operations

2. **fan_in.rs** - Fan-in pattern benchmark
   - Uses: timely-dataflow
   - Purpose: Tests data convergence from multiple sources

3. **fan_out.rs** - Fan-out pattern benchmark
   - Uses: timely-dataflow
   - Purpose: Tests data distribution to multiple destinations

4. **fork_join.rs** - Fork-join pattern benchmark
   - Uses: timely-dataflow
   - Purpose: Tests parallel processing with synchronization

5. **identity.rs** - Identity transformation benchmark
   - Uses: timely-dataflow
   - Purpose: Tests baseline throughput with minimal processing

6. **join.rs** - Join operation benchmark
   - Uses: timely-dataflow
   - Purpose: Tests stream join operations

7. **reachability.rs** - Graph reachability benchmark
   - Uses: differential-dataflow
   - Dependencies: reachability_edges.txt, reachability_reachable.txt
   - Purpose: Tests iterative graph computation

8. **upcase.rs** - String uppercase transformation benchmark
   - Uses: timely-dataflow
   - Purpose: Tests string processing throughput

### Supporting Files Migrated

- `reachability_edges.txt` - Edge list for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation
- `.gitignore` - Benchmark-specific ignore patterns
- `build.rs` - Build script for benchmark compilation

### Configuration Changes

**Main Repository** (bigweaver-agent-canary-hydro-zeta):
- Removed `benches/` workspace member from root Cargo.toml
- No remaining timely-dataflow or differential-dataflow dependencies
- Updated CONTRIBUTING.md to reference this repository for performance benchmarks

**Deps Repository** (bigweaver-agent-canary-zeta-hydro-deps):
- Created new workspace with `benches/` as sole member
- Updated dependency paths to use git references to main repository
- Maintained all benchmark configurations and harness settings

### Benefits of Migration

1. **Reduced Dependency Footprint**: Main repository no longer requires timely/differential dependencies
2. **Cleaner Build Times**: Developers working on core Hydro functionality don't need to build comparison frameworks
3. **Focused Scope**: Main repository remains focused on Hydro core, benchmarks in dedicated location
4. **Preserved Functionality**: Performance comparison capabilities fully retained and maintained separately

### Benchmarks Retained in Main Repository

The following benchmarks were not migrated because they don't depend on external frameworks:
- `futures.rs` - Uses only standard Rust futures
- `micro_ops.rs` - Tests Hydro micro-operations without external dependencies
- `symmetric_hash_join.rs` - Pure Hydro implementation
- `words_diamond.rs` - Pure Hydro implementation

These benchmarks remained in the main repository as they test core Hydro functionality without external framework dependencies.

## Running Migrated Benchmarks

From the bigweaver-agent-canary-zeta-hydro-deps repository:

```bash
# Run all migrated benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run with custom parameters
cargo bench -p benches --bench arithmetic -- --sample-size 100
```

## Future Migrations

Future benchmarks that require external framework dependencies should be added directly to this repository rather than the main Hydro repository. This maintains the clean separation of concerns established by this migration.
