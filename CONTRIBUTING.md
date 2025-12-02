# Contributing to Hydro Benchmarks

This repository contains performance benchmarks for the [Hydro project](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta). These benchmarks compare Hydro's performance with timely-dataflow and differential-dataflow implementations.

## Repository Structure

* `benches/` - Contains all benchmark code
  * `benches/benches/*.rs` - Individual benchmark files
  * `benches/benches/*.txt` - Test data files for benchmarks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

To run with specific filters:
```bash
cargo bench -p benches --bench micro_ops -- "fold"
```

## Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/` (e.g., `my_benchmark.rs`)
2. Add a corresponding `[[bench]]` entry in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Use the criterion framework for consistent benchmark output
4. Follow the pattern of existing benchmarks

## Dependencies

Benchmarks in this repository depend on:
- `dfir_rs` and `sinktools` from the main Hydro repository (via git dependency)
- `timely-dataflow` and `differential-dataflow` for comparison benchmarks
- `criterion` for benchmarking infrastructure

The git dependencies automatically track the main branch of the Hydro repository.

## Performance Comparisons

When creating comparison benchmarks:
1. Implement the same algorithm in both Hydro and timely/differential-dataflow
2. Use identical inputs and data sizes
3. Measure throughput and/or latency consistently
4. Document any algorithmic differences or limitations

## Commit Messages

Follow the same [Conventional Commits](https://www.conventionalcommits.org/) specification used in the main Hydro repository.

Common types:
- `bench:` - Add or modify benchmarks
- `perf:` - Performance improvements
- `fix:` - Bug fixes in benchmark code
- `docs:` - Documentation updates
- `chore:` - Dependency updates or maintenance

Example:
```
bench(reachability): add transitive closure benchmark

Add a new benchmark comparing Hydro and differential-dataflow implementations
of transitive closure on a social network graph.
```

## Testing Before Commit

Make sure benchmarks compile and run:
```bash
cargo check --workspace
cargo bench --no-run
```

## Questions?

For questions about the benchmarks or contribution process, please refer to the main Hydro repository's [CONTRIBUTING.md](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md) or open an issue.
