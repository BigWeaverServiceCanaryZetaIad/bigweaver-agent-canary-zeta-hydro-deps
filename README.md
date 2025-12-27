# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies and performance comparison tests for the Hydro project that have been isolated from the main repository to prevent dependency bloat.

## Contents

### Benches
Comprehensive microbenchmarks comparing Hydro's performance against other dataflow frameworks like Timely Dataflow and Differential Dataflow.

See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Running Benchmarks

From this repository root:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository includes dependencies on:
- `timely-master` (version 0.13.0-dev.1) - For performance comparison benchmarks
- `differential-dataflow-master` (version 0.13.0-dev.1) - For reachability and dataflow benchmarks
- `dfir_rs` and `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository (via relative path)
