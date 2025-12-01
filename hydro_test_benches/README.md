# Hydro Test Benchmarks

This directory contains benchmark implementations that were migrated from the main repository's `hydro_test/src/cluster/` directory.

## Contents

- `paxos_bench.rs` - Paxos consensus protocol benchmark implementation
- `two_pc_bench.rs` - Two-phase commit protocol benchmark implementation

## Note

These files are reference implementations that were originally part of the `hydro_test` crate. They have been moved here as part of the benchmark migration to:

1. Separate benchmark code from core test infrastructure
2. Reduce dependencies in the main repository
3. Provide a reference for distributed protocol benchmarking

## Usage

These benchmark implementations use:
- `hydro_lang` - For distributed dataflow programming
- `hydro_std::bench_client` - For benchmark client utilities
- Various protocol implementations from the main repository

## Integration

To use these benchmarks:

1. They can serve as templates for creating new distributed protocol benchmarks
2. They demonstrate how to use `hydro_std::bench_client` for performance testing
3. They show patterns for benchmarking distributed consensus protocols

## Dependencies

These benchmarks depend on modules from the main repository:
- `hydro_lang` - Hydro language constructs
- `hydro_std` - Standard library including bench_client
- Protocol implementations (Paxos, Two-PC)

Note: The main repository retains the `hydro_std::bench_client` module for integration test benchmarking.

## Related Files

The original context for these benchmarks can be found in the main repository's `hydro_test` crate, which contains:
- Protocol implementations (Paxos, Two-PC)
- Test infrastructure
- Integration tests

## Migration Date

Migrated from `bigweaver-agent-canary-hydro-zeta` repository on 2025-11-30.
