# Timely and Differential Dataflow Benchmarks

Performance comparison benchmarks between Hydroflow and Timely Dataflow / Differential Dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench join
```

## Benchmarks

This package contains the following benchmarks:

- **arithmetic** - Basic arithmetic operations comparison
- **fan_in** - Fan-in pattern (multiple inputs, single output)
- **fan_out** - Fan-out pattern (single input, multiple outputs)
- **fork_join** - Fork-join parallelism pattern
- **identity** - Identity transformation pipeline
- **join** - Join operations
- **reachability** - Graph reachability using both Timely and Differential Dataflow
- **upcase** - String uppercase operations

## Dependencies

These benchmarks depend on:
- `timely-master` - Timely Dataflow for low-latency streaming
- `differential-dataflow-master` - Differential Dataflow for incremental computation
- `dfir_rs` (Hydroflow) - For comparison baseline
- `criterion` - For benchmark measurement and reporting
