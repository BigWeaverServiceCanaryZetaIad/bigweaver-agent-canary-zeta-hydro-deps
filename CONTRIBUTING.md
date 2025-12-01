# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and heavy dependencies for the Hydro project.

## Repository Structure

* `benches/` - Performance microbenchmarks comparing Hydro implementations with Timely Dataflow and Differential Dataflow.

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench reachability
```

To trigger benchmarks in CI, include `[ci-bench]` in your commit message or PR title/body.

## Dependencies

This repository depends on:
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework
- `dfir_rs` and `sinktools` from the main Hydro repository (referenced via git)

## Purpose

This repository was separated from the main Hydro repository to:
1. Improve build times in the core repository
2. Reduce dependency bloat
3. Allow independent benchmarking workflows
4. Maintain the ability to run performance comparisons

## Coordination with Main Repository

When making changes that affect both repositories:
1. Create coordinated PRs in both repositories
2. Reference the companion PR in the PR description
3. Ensure both PRs are merged in the correct order
4. The deps repository should typically be merged first or simultaneously
