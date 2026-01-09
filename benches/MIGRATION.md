# Benchmark Migration Notes

This document describes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this repository.

## Migration Date

December 11, 2025

## What Was Moved

The following benchmarks were extracted from commit `51d81693` of the main repository and updated to focus solely on timely and differential-dataflow implementations:

### Benchmarks
- **arithmetic.rs**: Basic arithmetic operations with multiple map stages
- **fan_in.rs**: Multiple streams concatenating into one
- **fan_out.rs**: One stream branching into multiple consumers  
- **fork_join.rs**: Fork-join pattern with filtering and concatenation
- **identity.rs**: Identity mapping (passthrough) operations
- **join.rs**: Hash join operations on different data types
- **reachability.rs**: Graph reachability using both timely and differential-dataflow
- **upcase.rs**: String manipulation benchmarks

### Data Files
- **reachability_edges.txt**: Edge list for reachability benchmarks
- **reachability_reachable.txt**: Expected reachable nodes for validation

## Changes Made During Migration

1. **Removed non-timely/differential benchmarks**: Each benchmark file was simplified to contain only the timely and/or differential-dataflow implementations. Benchmarks for other frameworks (babyflow, hydroflow, spinachflow) were removed.

2. **Updated dependencies**: The Cargo.toml was updated to:
   - Use timely 0.12 and differential-dataflow 0.12
   - Remove dependencies on old frameworks
   - Keep criterion for benchmark infrastructure
   - Add optional reference to dfir_rs for future comparison benchmarks

3. **Modernized code**: Updated edition to 2021 and modernized dependency versions.

4. **Removed zip benchmark**: The zip.rs benchmark did not have an active timely implementation, so it was excluded.

## Why This Migration Was Done

The migration serves several purposes:

1. **Dependency Isolation**: Keeps external dependencies (timely, differential-dataflow) separate from the core Hydro codebase
2. **Clean Separation**: Allows the main repository to focus on Hydro-specific code
3. **Maintained Comparisons**: Preserves the ability to run performance comparisons between frameworks
4. **Reduced Build Times**: Main repository builds faster without external benchmark dependencies

## What Remains in Main Repository

The main `bigweaver-agent-canary-hydro-zeta` repository:
- No longer has timely or differential-dataflow as dependencies
- Has updated CONTRIBUTING.md documenting the benchmark migration
- May have Hydro-specific benchmarks that don't require external dependencies

## Building and Running

To verify the migration was successful:

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps/benches
cargo check  # Verify compilation
cargo bench  # Run all benchmarks
```

To run specific benchmarks:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Future Work

- Consider adding Hydro implementation benchmarks for direct comparison
- Update benchmarks as timely/differential-dataflow evolve
- Add more sophisticated comparison metrics
