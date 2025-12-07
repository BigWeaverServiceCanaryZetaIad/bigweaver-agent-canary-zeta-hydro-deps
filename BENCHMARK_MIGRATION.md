# Benchmark Migration Guide

This document explains the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this separate repository.

## Overview

To reduce dependency bloat and improve build times in the main repository, benchmarks requiring timely and differential-dataflow have been moved to this dedicated repository.

## What Was Moved

### Benchmarks

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/`:

- `arithmetic.rs` - Arithmetic operations using timely
- `fan_in.rs` - Fan-in patterns with timely
- `fan_out.rs` - Fan-out patterns with timely
- `fork_join.rs` - Fork-join patterns with timely
- `identity.rs` - Identity operations with timely
- `join.rs` - Join operations with timely
- `reachability.rs` - Graph reachability with differential-dataflow
- `upcase.rs` - String operations with timely
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability
- `build.rs` - Build script for generating benchmark code

### Benchmark Client Code

Moved from `bigweaver-agent-canary-hydro-zeta/hydro_std/src/bench_client/`:
- `mod.rs` - Benchmark client framework
- `rolling_average.rs` - Throughput calculation utilities

### Integration Test Benchmarks

Moved from `bigweaver-agent-canary-hydro-zeta/hydro_test/src/cluster/`:
- `paxos_bench.rs` - Paxos consensus benchmarks
- `two_pc_bench.rs` - Two-phase commit benchmarks

## What Stayed in Main Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta` as they do not depend on timely/differential-dataflow:

- `micro_ops.rs` - Micro-operations benchmarks using dfir_rs
- `symmetric_hash_join.rs` - Hash join benchmarks
- `words_diamond.rs` - Word processing diamond pattern
- `futures.rs` - Async futures benchmarks
- `words_alpha.txt` - Test data for word benchmarks

## Running Performance Comparisons

### Before Migration

```bash
# All benchmarks in one place
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench reachability
```

### After Migration

```bash
# Timely/differential benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-benches-timely --bench reachability

# Hydro-only benchmarks
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench micro_ops
```

### Comparing Performance

To compare performance between implementations:

1. Run the timely/differential benchmark:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-benches-timely --bench reachability > results_timely.txt
   ```

2. Run the corresponding Hydro benchmark (if available):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches --bench reachability_hydro > results_hydro.txt
   ```

3. Compare the results using the criterion reports or custom analysis tools

## Dependencies Removed from Main Repository

The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta`:

- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)

These dependencies are now only in `bigweaver-agent-canary-zeta-hydro-deps`.

## Benefits

1. **Reduced Build Times** - Main repository builds faster without timely/differential dependencies
2. **Cleaner Dependencies** - Separation of concerns for different benchmark types
3. **Maintained Performance Testing** - All benchmarks remain runnable
4. **Easy Comparison** - Can still compare Hydro vs timely/differential implementations

## Integration with CI/CD

Update CI/CD pipelines to run benchmarks from both repositories:

```yaml
# Example GitHub Actions workflow
- name: Benchmark Hydro
  run: |
    cd bigweaver-agent-canary-hydro-zeta
    cargo bench -p benches

- name: Benchmark Timely/Differential
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench -p hydro-benches-timely
```

## Future Maintenance

- Update benchmarks in the appropriate repository based on their dependencies
- Keep benchmark APIs consistent between repositories for fair comparisons
- Document any new benchmarks and their location
- Maintain version compatibility with the main repository when needed
