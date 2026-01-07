# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow that were moved from the bigweaver-agent-canary-hydro-zeta repository.

## Benchmarks

The `benches` directory contains performance benchmarks including:
- `upcase.rs` - String uppercasing benchmark using timely dataflow
- `fan_in.rs` - Fan-in operations benchmark
- `reachability.rs` - Graph reachability benchmark using differential-dataflow
- And other benchmarks for performance comparison

## Dependencies

The benchmarks use the following key dependencies:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`

### Note on dfir_rs and sinktools Dependencies

Some benchmarks reference `dfir_rs` and `sinktools` packages which are not included in this repository. These dependencies are commented out in `benches/Cargo.toml`. Benchmarks that require these dependencies will not compile without additional configuration.

To use benchmarks that depend on `dfir_rs` or `sinktools`, you will need to:
1. Configure appropriate path dependencies, or
2. Set up git dependencies, or
3. Use cargo's `[patch]` section to point to the main hydro repository

## Running Benchmarks

To run the available benchmarks:

```bash
cd benches
cargo bench
```

Note: Only benchmarks that don't require `dfir_rs` or `sinktools` will compile and run (e.g., `upcase.rs`).