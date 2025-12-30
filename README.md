# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro/DFIR project that compare performance against Timely Dataflow and Differential Dataflow frameworks.

## Structure

- `benches/` - Microbenchmarks comparing DFIR, Timely, and Differential implementations

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
```

## Dependencies

The benchmarks depend on:
- `timely` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` and `sinktools` from the main Hydro repository