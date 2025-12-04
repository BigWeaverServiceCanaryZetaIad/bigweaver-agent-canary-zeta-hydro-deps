# Hydro Benchmarks

This directory contains performance benchmarks that compare Hydro's dataflow implementation with timely-dataflow and differential-dataflow.

## Benchmarks

- **reachability**: Graph reachability computation using differential-dataflow
- **micro_ops**: Basic dataflow operations (map, filter)
- **fan_out**: Fan-out dataflow patterns
- **fan_in**: Fan-in dataflow patterns
- **arithmetic**: Arithmetic operation chains

## Running Benchmarks

```bash
cd benches
cargo bench
```

## Dependencies

These benchmarks depend on:
- `timely` (0.12)
- `differential-dataflow` (0.12)
- `criterion` (0.5)

## Note

These benchmarks are maintained separately from the main Hydro codebase to avoid adding unnecessary dependencies to the core library.
