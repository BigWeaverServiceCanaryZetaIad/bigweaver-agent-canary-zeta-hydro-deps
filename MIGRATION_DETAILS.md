# Benchmark Migration Details

## Overview
This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this repository.

## Benchmarks Included

The following benchmarks were moved to this repository:

1. **arithmetic.rs** - Basic arithmetic operations comparison between DFIR and timely
2. **fan_in.rs** - Multiple inputs converging to single output pattern
3. **fan_out.rs** - Single input diverging to multiple outputs pattern
4. **fork_join.rs** - Split and rejoin dataflow pattern
5. **identity.rs** - Pass-through operations benchmark
6. **join.rs** - Join operations on streams
7. **reachability.rs** - Graph reachability using differential-dataflow
8. **upcase.rs** - String transformation operations

## Dependencies

This repository includes the following key dependencies:

- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)
- `dfir_rs` - Referenced from the main Hydro repository via git
- `sinktools` - Referenced from the main Hydro repository via git

## Usage

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Purpose

This separation allows:
1. **Reduced build overhead** in the main repository
2. **Smaller dependency tree** for projects that only need DFIR
3. **Maintained performance comparison** capability
4. **Independent updates** of timely/differential-dataflow dependencies
5. **Clearer security auditing** by isolating external dependencies

## Maintenance

When updating benchmarks:
1. Ensure the git revision for `dfir_rs` and `sinktools` is kept in sync with the main repository
2. Test benchmarks after any dependency updates
3. Compare performance results with historical data

## Related Documentation

- See `README.md` for general repository information
- See `benches/README.md` for benchmark-specific documentation
- See the main repository's `MIGRATION_NOTES.md` for additional context
