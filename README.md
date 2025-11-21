# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison utilities for Hydro/DFIR against timely and differential-dataflow frameworks.

## Contents

### Benchmarks (`/benches`)

Contains microbenchmarks that compare DFIR performance with timely and differential-dataflow:

- **arithmetic.rs** - Pipeline arithmetic operations benchmark
- **fan_in.rs** - Fan-in pattern benchmark
- **fan_out.rs** - Fan-out pattern benchmark
- **fork_join.rs** - Fork-join pattern benchmark
- **futures.rs** - Futures handling benchmark
- **identity.rs** - Identity/passthrough benchmark
- **join.rs** - Join operations benchmark
- **micro_ops.rs** - Micro operations benchmark
- **reachability.rs** - Graph reachability benchmark
- **symmetric_hash_join.rs** - Symmetric hash join benchmark
- **upcase.rs** - String uppercase transformation benchmark
- **words_diamond.rs** - Diamond pattern with word processing benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

Run DFIR benchmarks only:
```bash
cargo bench -p benches -- dfir
```

Run micro operations benchmarks:
```bash
cargo bench -p benches -- micro/ops/
```

## CI/CD Integration

The repository includes a GitHub Actions workflow (`.github/workflows/benchmark.yml`) that:

1. Runs benchmarks automatically on:
   - Daily schedule (3:35 AM UTC)
   - Push to main branch with `[ci-bench]` in commit message
   - Pull requests with `[ci-bench]` in title or body
   - Manual workflow dispatch

2. Generates benchmark reports using Criterion
3. Publishes results to GitHub Pages
4. Tracks performance over time

## Dependencies

The benchmarks depend on:

- **dfir_rs** - DFIR framework (from main Hydro repository)
- **sinktools** - Sink tools (from main Hydro repository)
- **timely-master** - Timely dataflow framework
- **differential-dataflow-master** - Differential dataflow framework
- **criterion** - Benchmarking framework

## Performance Comparison

These benchmarks provide performance comparison data between:
- DFIR (Hydro's dataflow framework)
- Timely Dataflow
- Differential Dataflow

Results are published to the repository's GitHub Pages for historical tracking and analysis.

## Repository Purpose

This repository was created to separate the performance benchmarking and comparison code from the main Hydro repository, allowing:

1. Independent dependency management for benchmarking frameworks
2. Focused performance testing without impacting main repository build times
3. Dedicated CI/CD for performance tracking
4. Clear separation of concerns between core functionality and performance analysis