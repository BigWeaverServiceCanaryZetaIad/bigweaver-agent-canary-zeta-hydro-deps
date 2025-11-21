# Hydro Performance Benchmarks - Timely and Differential Dataflow Dependencies

This repository contains performance comparison benchmarks for Hydro that depend on timely-dataflow and differential-dataflow. These benchmarks were separated from the main bigweaver-agent-canary-hydro-zeta repository to keep the main codebase free of these heavy dependencies.

## Purpose

This repository provides:
- Comparative performance benchmarks between Hydro and timely/differential-dataflow
- Microbenchmarks for evaluating Hydro performance against established streaming frameworks
- Performance regression testing capabilities

## Structure

- `benches/` - Benchmark suite with timely and differential-dataflow comparisons
  - `benches/benches/` - Individual benchmark implementations

## Prerequisites

To run these benchmarks, you need to have the main bigweaver-agent-canary-hydro-zeta repository cloned alongside this one:

```
/projects/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

Alternatively, you can adjust the paths in `benches/Cargo.toml` to point to your local clone of the main repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Diamond pattern with word processing

## Dependencies

This repository depends on:
- `timely-master` (0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` - From the main Hydro repository (via path dependency)
- `sinktools` - From the main Hydro repository (via path dependency)
- `criterion` - For benchmark harness

## Migration Notes

These benchmarks were moved from the main repository on [DATE] to:
1. Reduce dependency footprint of the main repository
2. Keep heavy benchmark dependencies isolated
3. Allow independent versioning and updates of benchmark code
4. Maintain clean separation between core functionality and performance testing

For historical reference, see the main repository's `BENCHMARK_MIGRATION.md` file.

## Development

When adding new benchmarks:
1. Create a new `.rs` file in `benches/benches/`
2. Add a corresponding `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing benchmark patterns for consistency
4. Ensure benchmarks compare Hydro with timely/differential-dataflow fairly

## Notes

- Wordlist for text benchmarks is from: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Graph data for reachability benchmarks is included in the `benches/benches/` directory