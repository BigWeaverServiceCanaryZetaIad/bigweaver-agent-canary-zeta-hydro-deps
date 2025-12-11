# Benchmark Migration

## Overview

Benchmarks that depend on timely and differential-dataflow have been moved to a separate repository to avoid unnecessary dependencies in the main bigweaver-agent-canary-hydro-zeta repository.

## Moved Benchmarks

The following benchmarks were moved to [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps):

- `arithmetic.rs` - Uses timely
- `fan_in.rs` - Uses timely
- `fan_out.rs` - Uses timely
- `fork_join.rs` - Uses timely
- `identity.rs` - Uses timely
- `join.rs` - Uses timely
- `reachability.rs` - Uses differential-dataflow
- `upcase.rs` - Uses timely

Associated data files:
- `reachability_edges.txt`
- `reachability_reachable.txt`

## Remaining Benchmarks

The following benchmarks remain in this repository as they do not depend on timely or differential-dataflow:

- `futures.rs`
- `micro_ops.rs`
- `symmetric_hash_join.rs`
- `words_diamond.rs`

Associated data files:
- `words_alpha.txt`

## Running Benchmarks

### In this repository:
```bash
cargo bench -p benches
```

### In the deps repository:
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

## Performance Comparisons

To compare performance across repositories:

1. Run benchmarks in both repositories
2. Results are stored in `target/criterion/` in each repository
3. Use criterion's HTML reports to compare results
4. Both repositories use the same criterion version and configuration for consistency

## Dependencies Removed

From this repository's benches/Cargo.toml:
- `differential-dataflow` (package: differential-dataflow-master, version 0.13.0-dev.1)
- `timely` (package: timely-master, version 0.13.0-dev.1)

These dependencies are now only in the deps repository's benches/Cargo.toml.
