# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for performance comparisons with the main bigweaver-agent-canary-hydro-zeta project.

## Structure

* `benches` contains microbenchmarks for comparing Hydro (DFIR) with timely and differential-dataflow frameworks.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
```

## Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`
2. Add it to the `[[bench]]` section in `benches/Cargo.toml`
3. Ensure it follows the existing pattern of comparing implementations

## Dependencies

The benchmarks depend on:
- `dfir_rs` from the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` from the main bigweaver-agent-canary-hydro-zeta repository
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)

These paths are configured as relative paths to the sibling repository.
