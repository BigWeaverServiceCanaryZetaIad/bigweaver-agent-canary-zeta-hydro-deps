# Timely and Differential-Dataflow Benchmarks

This directory contains benchmark implementations using timely and differential-dataflow that correspond to benchmarks in the main `bigweaver-agent-canary-hydro-zeta` repository.

## Quick Start

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench arithmetic_timely
cargo bench --bench reachability_timely_differential
```

## Available Benchmarks

- `arithmetic_timely` - Arithmetic operations (20 ops on 1M elements)
- `fan_in_timely` - Stream merging (20 streams)
- `fan_out_timely` - Stream splitting (to 20 consumers)
- `fork_join_timely` - Fork-join pattern (10 iterations, 2 branches)
- `identity_timely` - Identity mapping (20 sequential maps)
- `join_timely` - Hash join (usize and String types)
- `reachability_timely_differential` - Graph reachability (both implementations)
- `upcase_timely` - String transformations (3 variants)

## Comparing with Main Repository

See the parent directory README and `docs/BENCHMARK_COMPARISON.md` for detailed instructions on cross-repository performance comparison.

Quick comparison:
```bash
cd ..
./scripts/compare_benchmarks.sh
```

## Benchmark Parameters

All benchmarks use the same parameters as their counterparts in the main repository to ensure fair comparison. Constants are defined at the top of each benchmark file.

## Test Data

Some benchmarks (like reachability) use data files in this directory:
- `reachability_edges.txt` - Graph edge list
- `reachability_reachable.txt` - Expected reachable nodes

These files are identical to those in the main repository.
