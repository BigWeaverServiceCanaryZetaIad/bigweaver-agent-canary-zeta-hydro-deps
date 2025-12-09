# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main bigweaver-agent-canary-hydro-zeta repository to avoid direct dependencies on timely and differential-dataflow in the main service repository.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other crates. These benchmarks were migrated from the main repository in commit b161bc10.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
```

### Available Benchmarks

- `arithmetic`: Arithmetic operations benchmarks
- `fan_in`: Fan-in pattern benchmarks
- `fan_out`: Fan-out pattern benchmarks
- `fork_join`: Fork-join pattern benchmarks
- `futures`: Async futures benchmarks
- `identity`: Identity operation benchmarks
- `join`: Join operation benchmarks
- `micro_ops`: Micro-operations benchmarks
- `reachability`: Graph reachability benchmarks
- `symmetric_hash_join`: Symmetric hash join benchmarks
- `upcase`: String case conversion benchmarks
- `words_diamond`: Word processing diamond pattern benchmarks

### Dependencies

The benchmarks depend on:
- `dfir_rs`: Referenced from the main repository via Git
- `sinktools`: Referenced from the main repository via Git
- `timely`: Timely dataflow framework
- `differential-dataflow`: Differential dataflow framework
- `criterion`: Benchmarking framework

### CI/CD

The `.github/workflows/benchmark.yml` workflow is configured to run benchmarks automatically on:
- Push to main and feature branches
- Pull requests (when marked with `[ci-bench]`)
- Daily schedule (3:35 AM UTC)
- Manual workflow dispatch