# Hydro Dependencies Repository

This repository contains dependencies and benchmarks for the Hydro project that have been separated from the main repository to improve build times and reduce dependency bloat.

## Contents

### Benchmarks

Microbenchmarks for Hydro and related frameworks, including timely and differential-dataflow.

**Location:** `benches/`

These benchmarks were moved from the main Hydro repository to isolate heavyweight dependencies like `timely` and `differential-dataflow`.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

#### Available Benchmarks

- `arithmetic` - Arithmetic operation benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String case conversion benchmarks
- `words_diamond` - Diamond pattern benchmarks

## Rationale

The benchmarks in this repository use `timely` and `differential-dataflow` as dependencies. These dependencies are heavyweight and can significantly increase build times. By isolating them in a separate repository, the main Hydro repository maintains faster build times while preserving the ability to run performance comparisons.

## Migration Notes

These benchmarks were previously located in the main Hydro repository at `bigweaver-agent-canary-hydro-zeta`. See `BENCHMARKS_MOVED.md` in the main repository for migration details.

## Related Repositories

- Main Hydro Repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)