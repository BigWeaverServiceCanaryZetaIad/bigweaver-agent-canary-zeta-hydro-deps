# Benchmark Migration Details

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the main Hydro repository to this dedicated repository.

## Background

The main Hydro repository previously contained benchmarks comparing Hydro's performance with other dataflow frameworks (timely-dataflow and differential-dataflow). These benchmarks required external dependencies that were not needed for core Hydro functionality.

## What Was Moved

The following benchmarks were moved to this repository:

### Benchmarks Using timely-dataflow
- **arithmetic.rs**: Pipeline arithmetic operations
- **fan_in.rs**: Fan-in pattern benchmarks
- **fan_out.rs**: Fan-out pattern benchmarks  
- **fork_join.rs**: Fork-join pattern benchmarks
- **identity.rs**: Identity transformation benchmarks
- **join.rs**: Join operation benchmarks
- **upcase.rs**: String uppercase transformation benchmarks

### Benchmarks Using differential-dataflow
- **reachability.rs**: Graph reachability benchmarks
- **reachability_edges.txt**: Test data for reachability
- **reachability_reachable.txt**: Expected results for reachability

### Supporting Files
- **Cargo.toml**: Build configuration with dependencies
- **build.rs**: Build script for generating fork_join test files
- **README.md**: Documentation for running benchmarks
- **.gitignore**: Ignore generated files

## What Stayed in Main Repository

Benchmarks that don't depend on timely or differential-dataflow remained in the main repository:
- futures.rs
- micro_ops.rs
- symmetric_hash_join.rs
- words_diamond.rs

## Dependency Changes

### In This Repository (bigweaver-agent-canary-zeta-hydro-deps)
- Added `timely-master` (timely-dataflow) dependency
- Added `differential-dataflow-master` dependency
- Reference `dfir_rs` from main Hydro repository as git dependency
- Reference `sinktools` from main Hydro repository as git dependency

### In Main Repository (bigweaver-agent-canary-hydro-zeta)
- Removed `timely-master` dependency (no longer needed)
- Removed `differential-dataflow-master` dependency (no longer needed)
- Removed associated transitive dependencies

## Running Benchmarks After Migration

To run the migrated benchmarks:

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Benefits of This Migration

1. **Reduced Dependency Footprint**: Main repository no longer includes timely/differential-dataflow dependencies
2. **Cleaner Repository Structure**: Comparison benchmarks separated from core functionality
3. **Preserved Functionality**: All benchmarks still runnable from dedicated repository
4. **Better Organization**: Benchmarks grouped by their dependencies
5. **Security**: Reduced attack surface by minimizing dependencies in main repository

## Integration Points

The benchmarks in this repository reference the main Hydro repository via git dependencies. This ensures:
- Benchmarks always use the latest version of Hydro
- No code duplication between repositories
- Performance comparisons reflect current Hydro implementation

## Future Maintenance

When updating these benchmarks:
1. Make changes in this repository
2. Test against current main Hydro repository
3. Document any API changes or performance differences
4. Update documentation if benchmark interpretation changes
