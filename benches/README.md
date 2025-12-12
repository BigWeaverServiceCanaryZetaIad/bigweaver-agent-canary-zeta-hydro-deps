# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare DFIR performance with timely-dataflow and differential-dataflow.

These benchmarks were moved from the `bigweaver-agent-canary-hydro-zeta` repository to keep the main codebase free of external dataflow dependencies while still maintaining the ability to run performance comparisons.

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations comparison
- `fan_in` - Fan-in pattern comparison
- `fan_out` - Fan-out pattern comparison  
- `fork_join` - Fork-join pattern comparison
- `identity` - Identity operation comparison
- `upcase` - String uppercase operation comparison
- `join` - Join operation comparison
- `reachability` - Graph reachability comparison (uses differential-dataflow)

## Dependencies

These benchmarks depend on:
- `timely-master` - Timely dataflow library
- `differential-dataflow-master` - Differential dataflow library
- `dfir_rs` - Referenced from the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - Referenced from the main bigweaver-agent-canary-hydro-zeta repository

## Performance Comparison

The benchmarks compare three implementations:
1. DFIR (pull-based dataflow)
2. Timely dataflow (push-based dataflow)
3. Differential dataflow (incremental computation, for reachability benchmark)

Results are generated as HTML reports in `target/criterion/`.
