# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark suites and dependency comparisons for the BigWeaver Agent Canary Hydro Zeta project.

## Structure

- `benches/` - Microbenchmarks comparing Hydro with timely and differential-dataflow frameworks

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

The benchmarks depend on the main `bigweaver-agent-canary-hydro-zeta` repository. Ensure both repositories are checked out in the same parent directory:
```
parent_directory/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

## Purpose

This repository maintains performance benchmarks that:
- Compare Hydro implementations with timely and differential-dataflow
- Track performance regressions
- Enable performance comparisons between frameworks
- Provide reproducible performance metrics