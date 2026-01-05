# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the BigWeaver Agent Canary Hydro Zeta project.

## Contents

### Benches

Microbenchmarks of Hydro and other crates, including performance comparisons with timely and differential-dataflow.

The benches directory contains:
- Performance benchmark files (fan_in.rs, upcase.rs, reachability.rs, and more)
- Cargo.toml with timely and differential-dataflow dependencies
- Test data files for benchmarking

**Running benchmarks:**

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

**Note:** The benchmarks reference dfir_rs and sinktools from the bigweaver-agent-canary-hydro-zeta repository via relative paths.