# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow, which were moved from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the main project.

## Benchmarks

The following benchmarks compare Hydro/DFIR performance against timely-dataflow and differential-dataflow:

- **arithmetic.rs** - Arithmetic operations pipeline comparison using timely
- **fan_in.rs** - Fan-in pattern comparison using timely
- **fan_out.rs** - Fan-out pattern comparison using timely
- **fork_join.rs** - Fork-join pattern comparison using timely
- **identity.rs** - Identity transformation comparison using timely
- **join.rs** - Join operations comparison using timely
- **reachability.rs** - Graph reachability comparison using differential-dataflow
- **upcase.rs** - String uppercase transformation comparison using timely

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench
```

### Run specific benchmarks:
```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

### Run benchmarks with specific filters:
```bash
# Run only DFIR benchmarks
cargo bench dfir

# Run only timely benchmarks
cargo bench timely

# Run only differential benchmarks
cargo bench differential
```

## Performance Comparisons

These benchmarks are designed to compare the performance of Hydro/DFIR against timely-dataflow and differential-dataflow. Results are stored in `target/criterion/` and include:

- HTML reports with visualizations
- Statistical analysis of performance
- Comparison with baseline runs

### Viewing Results

After running benchmarks, open the HTML reports:
```bash
open target/criterion/report/index.html
```

### Comparing with Hydro Benchmarks

To compare these results with Hydro-native benchmarks in the main repository:

1. Run benchmarks in this repository:
   ```bash
   cargo bench
   ```

2. Run benchmarks in the main bigweaver-agent-canary-hydro-zeta repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. Compare the HTML reports from both repositories:
   - This repository: `target/criterion/`
   - Main repository: `target/criterion/`

Both repositories use the same criterion version and configuration for consistency.

## Dependencies

This repository depends on:

- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - DFIR runtime (from main repository via git)
- **sinktools** - Utilities (from main repository via git)
- **criterion** (v0.5.0) - Benchmarking framework

## Data Files

- **reachability_edges.txt** - Edge data for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation

## Build Configuration

The benchmarks use:
- Criterion's async tokio support for async benchmarks
- HTML reports for visualization
- Multi-threaded tokio runtime

## Migration Background

These benchmarks were moved from the main repository to:
1. Reduce dependencies in the main bigweaver-agent-canary-hydro-zeta repository
2. Keep timely/differential-dataflow dependencies isolated
3. Maintain the ability to run performance comparisons
4. Keep the main repository focused on Hydro/DFIR development

For more details, see the [main repository's CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).

## Troubleshooting

### Compilation Errors

If you encounter compilation errors related to dfir_rs or sinktools:
1. Ensure you have access to the main repository
2. Check that your git credentials are configured
3. Try clearing the cargo cache: `cargo clean`

### Performance Inconsistencies

If benchmark results seem inconsistent:
1. Ensure your system is not under heavy load
2. Close unnecessary applications
3. Run benchmarks multiple times to establish a baseline
4. Use criterion's baseline comparison features

## Contributing

When adding new benchmarks:
1. Follow the existing naming convention
2. Include both DFIR and timely/differential implementations for comparison
3. Add appropriate [[bench]] entries to Cargo.toml
4. Update this README with benchmark descriptions
5. Ensure benchmarks use the same input data for fair comparison
