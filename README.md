# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely and differential-dataflow. These benchmarks were moved from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid including unnecessary dependencies in the main project.

## Benchmarks

This repository contains the following benchmarks:

### Timely Benchmarks
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity operation benchmark
- `join.rs` - Join operation benchmark
- `upcase.rs` - String uppercase transformation benchmark

### Differential Dataflow Benchmarks
- `reachability.rs` - Graph reachability benchmark
  - Uses data files: `reachability_edges.txt` and `reachability_reachable.txt`

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Performance Comparisons

To compare performance with benchmarks in the main repository:

1. Run benchmarks in this repository:
   ```bash
   cargo bench
   ```

2. Run benchmarks in the main repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Results are stored in `target/criterion/` in each repository
4. Use criterion's HTML reports to compare results by opening `target/criterion/report/index.html` in a browser

Both repositories use the same criterion version and configuration for consistency.

## Dependencies

This repository includes the following key dependencies:
- `timely` (package: timely-master, version 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version 0.13.0-dev.1)
- `criterion` (version 0.5.0) for benchmarking

These dependencies are intentionally kept separate from the main repository to reduce build times and dependency complexity for users who don't need to run these specific benchmarks.

## Contributing

When adding new benchmarks that depend on timely or differential-dataflow, please add them to this repository rather than the main repository.