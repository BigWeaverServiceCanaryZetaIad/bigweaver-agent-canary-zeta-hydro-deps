# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` crates, extracted from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Structure

- **benches/**: Microbenchmarks using timely and differential-dataflow
  - See [benches/README.md](benches/README.md) for details on running benchmarks

## Dependencies

This repository depends on crates from the sibling repository `bigweaver-agent-canary-hydro-zeta`:
- `dfir_rs`
- `sinktools`

Ensure both repositories are cloned in the same parent directory for the path dependencies to work correctly.

## Running Tests and Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability
```