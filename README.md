# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow` packages.

## Purpose

This repository isolates benchmarks that have dependencies on:
- `timely` (timely-master version 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master version 0.13.0-dev.1)

By separating these benchmarks into a dedicated repository, we maintain cleaner dependency management in the main `bigweaver-agent-canary-hydro-zeta` repository.

## Benchmarks

The benchmarks included are:
- `arithmetic.rs` - Uses timely dataflow operators
- `join.rs` - Uses timely dataflow
- `reachability.rs` - Uses differential_dataflow
- And all other benchmark files in the benches/benches directory

## Usage

Run all benchmarks from the workspace root:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Dependencies

The benchmarks reference `dfir_rs` and `sinktools` from the main `bigweaver-agent-canary-hydro-zeta` repository using relative paths. Ensure both repositories are cloned at the same level:

```
/projects/sandbox/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```
