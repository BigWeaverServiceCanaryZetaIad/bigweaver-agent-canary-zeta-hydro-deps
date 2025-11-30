# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow that were moved from the main bigweaver-agent-canary-hydro-zeta repository to reduce its dependency footprint.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Performance Comparisons

The benchmarks in this repository allow performance comparisons between:
- timely and differential-dataflow implementations
- dfir_rs implementations (pulled from the main repository)

This separation maintains the ability to run performance comparisons while keeping the main repository free from timely and differential-dataflow dependencies.