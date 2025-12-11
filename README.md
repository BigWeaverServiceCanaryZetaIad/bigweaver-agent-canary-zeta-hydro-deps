# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for comparing Hydro/DFIR with timely-dataflow and differential-dataflow.

## Overview

These benchmarks were separated from the main bigweaver-agent-canary-hydro-zeta repository to:
- Remove timely and differential-dataflow dependencies from the main codebase
- Maintain performance comparison infrastructure
- Enable independent benchmarking and testing

## Repository Structure

- `benches/` - Benchmark implementations comparing Hydro/DFIR with timely-dataflow and differential-dataflow

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern  
- `fork_join` - Fork-join pattern
- `identity` - Identity transformation
- `join` - Join operations
- `reachability` - Graph reachability
- `upcase` - String uppercase transformation

## Performance Comparisons

These benchmarks allow comparing performance between:
- DFIR (from bigweaver-agent-canary-hydro-zeta)
- timely-dataflow
- differential-dataflow

To compare with DFIR benchmarks, run the corresponding benchmarks from the bigweaver-agent-canary-hydro-zeta repository.

## Migration Notes

This repository was created to separate benchmarks that depend on timely-dataflow and differential-dataflow from the main Hydro/DFIR codebase. The main repository still contains DFIR-only benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond).

For more details, see `MIGRATION.md`.