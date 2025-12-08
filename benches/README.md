# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks comparing Hydro/DFIR performance with Timely Dataflow and Differential Dataflow libraries. These benchmarks were moved from the main hydro repository to isolate the timely and differential-dataflow dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-benches-timely-differential
```

Run specific benchmarks:
```bash
cargo bench -p hydro-benches-timely-differential --bench reachability
cargo bench -p hydro-benches-timely-differential --bench arithmetic
```

## Benchmarks

### Timely Dataflow Comparison Benchmarks

- **arithmetic.rs** - Simple arithmetic operations pipeline comparison
- **fan_in.rs** - Fan-in pattern comparison
- **fan_out.rs** - Fan-out pattern comparison
- **fork_join.rs** - Fork-join pattern comparison
- **identity.rs** - Identity operation comparison
- **join.rs** - Join operation comparison
- **upcase.rs** - String uppercase transformation comparison

### Differential Dataflow Comparison Benchmarks

- **reachability.rs** - Graph reachability computation using differential dataflow iterative operators

## Why These Benchmarks Are Separate

The timely and differential-dataflow dependencies are substantial and not required for the core Hydro functionality. By moving these benchmarks to a separate repository, we:

1. Reduce build times for the main repository
2. Avoid unnecessary dependencies in production builds
3. Maintain the ability to run performance comparisons when needed
4. Keep benchmark code organized by dependency requirements

## Related Repositories

For non-timely/differential benchmarks (testing Hydro-only features), see the `benches` directory in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.
