# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on timely and differential-dataflow. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies.

## Benchmarks

- `arithmetic.rs` - Uses timely
- `fan_in.rs` - Uses timely
- `fan_out.rs` - Uses timely
- `fork_join.rs` - Uses timely
- `identity.rs` - Uses timely
- `join.rs` - Uses timely
- `reachability.rs` - Uses differential-dataflow
- `upcase.rs` - Uses timely

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench arithmetic
```

## Performance Comparisons

To compare performance with DFIR implementations in the main repository:

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
4. Use criterion's HTML reports to compare results
5. Both repositories use the same criterion version and configuration for consistency

## Data Files

- `reachability_edges.txt` - Input data for reachability benchmark
- `reachability_reachable.txt` - Expected output for reachability benchmark
