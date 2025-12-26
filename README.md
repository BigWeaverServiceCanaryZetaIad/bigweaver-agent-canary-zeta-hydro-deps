# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that were separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain cleaner dependency management.

## Purpose

This repository isolates dependencies on external dataflow frameworks (Timely Dataflow and Differential Dataflow) while retaining the ability to run performance comparison benchmarks.

## Contents

### Benchmarks

Performance comparison benchmarks between Hydro and Timely/Differential Dataflow frameworks. These benchmarks allow for objective performance comparisons while keeping the main repository free from direct dependencies on these packages.

See [benches/README.md](benches/README.md) for details on running benchmarks.

## Running Benchmarks

```bash
# Run all comparison benchmarks
cargo bench -p hydro-deps-benches

# Run a specific benchmark
cargo bench -p hydro-deps-benches --bench reachability
```

## Migration

These benchmarks were moved from the main Hydro repository. See [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) for complete migration documentation including rationale, changes made, and verification steps.

## License

Apache-2.0