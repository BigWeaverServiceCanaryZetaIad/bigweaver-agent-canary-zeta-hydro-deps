# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code and dependencies for comparing DFIR (Hydro) performance against [timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow) frameworks.

## Purpose

This repository was created to separate benchmark dependencies (particularly `timely` and `differential-dataflow`) from the main Hydro repository, reducing dependency bloat while preserving the ability to run performance comparisons.

## Contents

- **`benches/`**: Benchmark implementations comparing DFIR with timely/differential-dataflow
- **Core dependencies**: `dfir_rs`, `dfir_lang`, `dfir_macro`, `lattices`, `sinktools`, `variadics`, etc.
- **GitHub Actions workflow**: Automated benchmark execution and results visualization

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations performance
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **futures**: Futures/async operations benchmark
- **identity**: Identity operation benchmark
- **join**: Join operations benchmark
- **micro_ops**: Micro-operations benchmark
- **reachability**: Graph reachability benchmark
- **symmetric_hash_join**: Symmetric hash join benchmark
- **upcase**: String uppercase benchmark
- **words_diamond**: Diamond pattern word processing benchmark

## CI/CD Integration

The repository includes a GitHub Actions workflow (`.github/workflows/benchmark.yml`) that:
- Runs benchmarks automatically on schedule or on-demand
- Generates benchmark reports in Criterion format
- Publishes results to GitHub Pages
- Tracks performance over time

### Triggering Benchmarks

1. **Scheduled**: Daily at 8:35 PM PDT/7:35 PM PST
2. **Manual**: Via workflow dispatch
3. **On commits**: Include `[ci-bench]` in commit message
4. **On PRs**: Include `[ci-bench]` in PR title or body

## Dependencies

This repository includes the following external dependencies:

### Benchmark Frameworks
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `criterion` (v0.5.0)

### Core Dependencies
- All necessary DFIR/Hydro packages
- Supporting libraries: `futures`, `tokio`, `rand`, etc.

## Relationship to Main Repository

This repository is a companion to [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git), containing only the benchmark code that was removed from the main repository to reduce dependency complexity.

## License

Apache-2.0

## References

- Main Hydro repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow