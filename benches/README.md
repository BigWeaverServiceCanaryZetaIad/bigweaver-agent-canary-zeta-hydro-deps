# Timely and Differential Dataflow Performance Benchmarks

This directory contains benchmarks comparing Hydro (dfir_rs) performance with timely and differential-dataflow implementations.

These benchmarks were extracted from the main bigweaver-agent-canary-hydro-zeta repository to isolate the timely/differential-dataflow dependencies.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p hydro-timely-benches
```

To run specific benchmarks:
```bash
cargo bench -p hydro-timely-benches --bench reachability
cargo bench -p hydro-timely-benches --bench arithmetic
```

## Benchmarks Included

- **arithmetic**: Performance comparison of arithmetic operations
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join dataflow patterns
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks (uses data files: reachability_edges.txt, reachability_reachable.txt)
- **upcase**: String upper-case transformation benchmarks

## Dependencies

Note: These benchmarks require dfir_rs and sinktools from the parent Hydro repository. When running these benchmarks, ensure the parent repository is accessible in the workspace.
