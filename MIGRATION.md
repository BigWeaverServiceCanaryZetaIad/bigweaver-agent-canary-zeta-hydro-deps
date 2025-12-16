# Benchmark Migration Guide

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the main Hydro repository to this dedicated dependencies repository.

## Background

Previously, all benchmarks were located in the `benches/` directory of the main Hydro repository. Some of these benchmarks compared DFIR performance with timely-dataflow and differential-dataflow implementations. These comparison benchmarks required adding timely-dataflow and differential-dataflow as dependencies, which added unnecessary overhead to the main repository.

## What Was Moved

The following benchmarks were moved from the main repository to this repository:

### Benchmark Files
- `benches/benches/arithmetic.rs` - Arithmetic operations pipeline benchmark
- `benches/benches/fan_in.rs` - Fan-in dataflow pattern benchmark
- `benches/benches/fan_out.rs` - Fan-out dataflow pattern benchmark
- `benches/benches/fork_join.rs` - Fork-join pattern benchmark
- `benches/benches/identity.rs` - Identity/pass-through operations benchmark
- `benches/benches/join.rs` - Join operations benchmark
- `benches/benches/reachability.rs` - Graph reachability benchmark
- `benches/benches/reachability_edges.txt` - Test data for reachability benchmark
- `benches/benches/reachability_reachable.txt` - Test data for reachability benchmark
- `benches/benches/upcase.rs` - String uppercase transformation benchmark
- `benches/build.rs` - Build script (used by moved benchmarks)

### Dependencies Removed from Main Repository
- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)

## What Remained in Main Repository

The following DFIR-native benchmarks remain in the main repository's `benches/` directory:

- `benches/benches/futures.rs` - Async/futures integration benchmark
- `benches/benches/micro_ops.rs` - Micro-operation benchmarks
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmark
- `benches/benches/words_diamond.rs` - Diamond dataflow pattern with word processing
- `benches/benches/words_alpha.txt` - Test data for word benchmarks

## Running Benchmarks After Migration

### DFIR-Native Benchmarks (Main Repository)
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Timely/Differential Comparison Benchmarks (This Repository)
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench

# Or use the provided script
./run_benchmarks.sh
```

## Performance Comparison Workflow

To compare DFIR performance with timely/differential-dataflow:

1. Run DFIR benchmarks in the main repository
2. Run comparison benchmarks in this repository
3. Compare results from both repositories

The benchmark results are stored in `target/criterion/` in each respective repository.

## Benefits of Separation

1. **Reduced Dependencies**: Main repository no longer requires timely/differential-dataflow
2. **Cleaner Dependency Tree**: Core Hydro development doesn't pull in comparison framework dependencies
3. **Independent Updates**: Comparison benchmarks can be updated independently
4. **Focused Development**: Main repository stays focused on DFIR/Hydro development
5. **Maintained Capability**: Performance comparisons are still possible via this repository

## CI/CD Considerations

If you have CI/CD pipelines that previously ran all benchmarks from the main repository:

- Update CI to run DFIR benchmarks from the main repository
- Optionally add separate CI jobs to run comparison benchmarks from this repository
- Update performance tracking to pull results from both repositories

## Migration Date

December 11, 2025

## Questions or Issues

If you have questions about this migration or encounter issues, please:
- Check the README in both repositories
- Review the benchmark documentation in `benches/README.md`
- Open an issue in the relevant repository
