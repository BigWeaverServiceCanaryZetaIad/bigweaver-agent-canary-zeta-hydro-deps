# Hydro Test Benchmarks

This directory contains benchmark files that were previously part of the `hydro_test` crate in the main bigweaver-agent-canary-hydro-zeta repository.

## Files

- `cluster/paxos_bench.rs` - Paxos protocol benchmarks
- `cluster/two_pc_bench.rs` - Two-phase commit protocol benchmarks

## Integration

These benchmark files depend on other modules within the `hydro_test` crate:
- `super::kv_replica` (for paxos_bench.rs)
- `super::paxos_with_client` (for paxos_bench.rs)
- `super::two_pc` (for two_pc_bench.rs)
- `crate::cluster::paxos_bench` (for two_pc_bench.rs)

## Usage

To use these benchmarks:

1. These files should be integrated back into the `hydro_test/src/cluster/` directory of the main repository when running performance tests.

2. Alternatively, maintain a fork or working branch of the main repository that includes these benchmark files alongside the main code.

## Note

Unlike the standalone benchmarks in the `benches/` directory, these benchmarks are tightly coupled with the hydro_test implementation and cannot run independently. They are preserved here for reference and to maintain the ability to run performance comparisons when needed.

## Dependencies

These benchmarks require:
- `hydro_lang` crate from the main repository
- `hydro_std` crate from the main repository
- Other modules from the `hydro_test` crate
