# Timely and Differential-Dataflow Benchmarks

Performance comparison benchmarks for DFIR vs timely-dataflow and differential-dataflow.

These benchmarks were migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the main repository.

## Benchmarks

### Timely-Dataflow Benchmarks

Benchmarks comparing DFIR performance against timely-dataflow:

- `arithmetic.rs` - Simple arithmetic operations across multiple operators
- `fan_in.rs` - Multiple input streams merging into one
- `fan_out.rs` - One stream splitting into multiple outputs
- `fork_join.rs` - Fork-join pattern with filtering
- `identity.rs` - Identity/passthrough operations
- `join.rs` - Stream join operations
- `upcase.rs` - String uppercase transformations

### Differential-Dataflow Benchmarks

Benchmarks comparing DFIR against differential-dataflow:

- `reachability.rs` - Graph reachability computation using iterative dataflow

Associated data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

## Performance Comparisons

Criterion generates HTML reports in `target/criterion/` for detailed performance analysis and comparison across different runs.

## Dependencies

These benchmarks depend on:
- `timely-dataflow` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` from the main bigweaver-agent-canary-hydro-zeta repository
