# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository. Specifically, this includes benchmarks that depend on external frameworks like `timely` and `differential-dataflow`.

## Purpose

The benchmarks in this repository are used for performance comparisons between Hydro and other dataflow frameworks. By maintaining these in a separate repository, we:

- Keep the main repository's dependency footprint minimal
- Preserve the ability to run performance comparisons
- Maintain cleaner separation between core functionality and comparison benchmarks
- Avoid transitive dependencies from external frameworks in the main codebase

## Structure

- `benches/` - Microbenchmarks comparing Hydro with timely and differential-dataflow implementations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

## Available Benchmarks

The following benchmarks are available:
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `futures` - Async futures comparison
- `identity` - Identity operation (passthrough)
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercasing
- `words_diamond` - Diamond pattern with word processing

## Dependencies

The benchmarks depend on:
- `dfir_rs` - From the main Hydro repository (via git dependency)
- `sinktools` - From the main Hydro repository (via git dependency)
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework
- `criterion` - Benchmarking harness

## Performance Comparison Workflow

To compare Hydro performance with other frameworks:

1. Clone this repository
2. Run the desired benchmarks
3. Criterion will generate detailed reports in `target/criterion/`
4. Reports include statistical analysis and HTML visualizations

## Maintenance

This repository is maintained separately from the main Hydro repository. Updates to benchmark code or addition of new comparison benchmarks should be made here.