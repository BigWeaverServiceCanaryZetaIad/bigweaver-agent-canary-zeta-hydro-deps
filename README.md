# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro with other dataflow frameworks, specifically 
[timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow) and 
[differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow).

## Overview

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) 
repository to avoid including these external framework dependencies in the core codebase. 
This separation allows for:

- Cleaner dependency management in the main repository
- Independent performance comparison testing
- Maintaining historical benchmark results without affecting the main codebase

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Multiple inputs merging to one output
- `fan_out` - One input fanning out to multiple outputs
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Asynchronous operations
- `identity` - Identity/pass-through operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String manipulation operations
- `words_diamond` - Diamond topology benchmarks

## Benchmark Results

Results are generated in the `target/criterion` directory with HTML reports that can be viewed in a browser.

### Viewing Historical Results

Benchmark results are automatically tracked and published via GitHub Actions:

- **Latest Benchmarks**: Available in the GitHub Actions artifacts for each run
- **Benchmark History**: Published to GitHub Pages (if enabled for this repository)
- **CI Integration**: Benchmarks run automatically on:
  - Scheduled daily runs (8:35 PM PDT / 7:35 PM PST)
  - Commits to main branch with `[ci-bench]` in the commit message
  - Pull requests with `[ci-bench]` in the title or description
  - Manual workflow dispatch

To manually trigger a benchmark run, use the GitHub Actions "workflow_dispatch" event with the `should_bench` input set to `true`.

## Dependencies

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main Hydro repository (via git dependency)
- `timely-master` and `differential-dataflow-master` for comparison
- `criterion` for benchmark harness

## Contributing

For general contribution guidelines, see the main [Hydro repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).

## Migration History

These benchmarks were migrated from the main Hydro repository at commit `484e6fdd` to maintain 
the ability to run performance comparisons while keeping the main repository free of 
timely/differential-dataflow dependencies.