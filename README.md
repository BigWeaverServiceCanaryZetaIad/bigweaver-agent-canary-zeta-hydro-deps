# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison tools for the Hydro/DFIR project that depend on external dataflow frameworks (timely-dataflow and differential-dataflow).

## Purpose

These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Keep timely and differential-dataflow dependencies isolated from the main codebase
- Maintain a cleaner main repository without these external dependencies
- Preserve the ability to run performance comparisons between Hydro/DFIR and established dataflow frameworks

## Repository Structure

```
benches/
  benches/
    arithmetic.rs           - Arithmetic operations benchmarks
    fan_in.rs              - Fan-in pattern benchmarks
    fan_out.rs             - Fan-out pattern benchmarks
    fork_join.rs           - Fork-join pattern benchmarks
    identity.rs            - Identity operation benchmarks
    join.rs                - Join operations benchmarks (comparing timely, differential, and DFIR)
    reachability.rs        - Graph reachability benchmarks (comparing timely, differential, and DFIR)
    upcase.rs              - String uppercase benchmarks
    reachability_edges.txt - Test data for reachability benchmarks
    reachability_reachable.txt - Test data for reachability benchmarks
  Cargo.toml               - Benchmark configuration with timely/differential dependencies
  build.rs                 - Build script for generating fork_join benchmark variants
```

## Running Benchmarks

This repository must be checked out alongside the main `bigweaver-agent-canary-hydro-zeta` repository, as it references DFIR components via relative paths.

```bash
# Ensure both repositories are checked out in the same parent directory
cd /path/to/parent/
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench

# Run specific benchmarks
cargo bench --bench reachability
cargo bench --bench join
```

## Dependencies

This repository depends on:
- `timely` (timely-master 0.13.0-dev.1) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1) - Differential Dataflow framework
- `dfir_rs` (via path to main repository) - Hydro DFIR runtime
- `sinktools` (via path to main repository) - Hydro sink utilities
- `criterion` - Benchmarking framework

## Performance Comparison

These benchmarks compare the performance of Hydro/DFIR implementations against equivalent implementations in Timely Dataflow and Differential Dataflow. This allows for:
- Tracking performance relative to established frameworks
- Identifying optimization opportunities
- Validating that DFIR remains competitive with state-of-the-art dataflow systems

## Contributing

When adding new benchmarks that compare against timely/differential-dataflow, they should be added to this repository. Benchmarks that only test DFIR functionality without external framework comparisons should be added to the main repository instead.