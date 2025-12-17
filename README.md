# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely and differential-dataflow, separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the main codebase.

## Benchmarks

The following benchmarks are included:

- `arithmetic.rs` - Uses timely
- `fan_in.rs` - Uses timely
- `fan_out.rs` - Uses timely
- `fork_join.rs` - Uses timely
- `identity.rs` - Uses timely
- `join.rs` - Uses timely
- `reachability.rs` - Uses differential-dataflow
- `upcase.rs` - Uses timely

**Note:** Some benchmarks reference historical dependencies (babyflow, spinachflow, hydroflow) that may require updates or additional dependencies to compile. These benchmarks are preserved for historical comparison and performance analysis purposes.

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

To compare performance with benchmarks in the main repository:

1. Run benchmarks in both repositories
2. Results are stored in `target/criterion/` in each repository
3. Use criterion's HTML reports to compare results
4. Both repositories use the same criterion version and configuration for consistency

## Dependencies

This repository includes:
- `timely` (package: timely-master, version 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version 0.13.0-dev.1)

These dependencies have been removed from the main repository to keep it lean and focused on core functionality.