# Hydro Comparison Benchmarks

This directory contains performance comparison benchmarks between DFIR (Dataflow Intermediate Representation) and timely-dataflow/differential-dataflow.

## Purpose

These benchmarks enable direct performance comparisons between:
- **DFIR**: The dataflow runtime used by Hydro
- **Timely Dataflow**: A low-latency cyclic dataflow computational model
- **Differential Dataflow**: An implementation of differential computation on timely dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench upcase
```

## Benchmark Descriptions

- **arithmetic** - Basic arithmetic operations comparing DFIR pipeline, raw iteration, compiled DFIR, timely, and differential dataflow
- **reachability** - Graph reachability analysis (transitive closure) comparing DFIR and differential dataflow
- **join** - Join operation performance comparing symmetric hash joins, timely joins, and differential joins
- **fan_in** - Multiple streams merging into one
- **fan_out** - One stream splitting into multiple
- **fork_join** - Parallel processing with synchronization
- **identity** - Pass-through operations
- **upcase** - String transformation operations

## Viewing Results

After running benchmarks, view HTML reports:
```bash
open target/criterion/report/index.html
```

Or view individual benchmark reports in `target/criterion/*/report/index.html`

## Data Files

- `reachability_edges.txt` - Graph edge data for reachability benchmarks
- `reachability_reachable.txt` - Expected reachability results for validation

## Migration Note

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate timely and differential-dataflow dependencies. See the repository root MIGRATION.md for details.

## Related Benchmarks

DFIR-native benchmarks (without timely/differential dependencies) are in the main repository:
```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```
