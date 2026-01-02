# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow.

These benchmarks have been moved to this repository to keep the main Hydro repository clean and avoid unnecessary dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench --manifest-path benches/Cargo.toml
```

Run specific benchmarks:
```bash
cargo bench --manifest-path benches/Cargo.toml --bench reachability
cargo bench --manifest-path benches/Cargo.toml --bench join
cargo bench --manifest-path benches/Cargo.toml --bench arithmetic
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark  
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String transformation benchmark

## Dependencies

These benchmarks depend on:
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)
- `dfir_rs` (from the main Hydro repository)
- `criterion` (for benchmarking infrastructure)
