# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependencies and benchmarks for the Hydro project that have been extracted to reduce compilation overhead in the main repository.

## Contents

### Timely and Differential Dataflow Benchmarks

Located in `/timely-differential-benchmarks/`

A comprehensive benchmark suite for [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) performance testing.

**Benchmarks included:**
- **arithmetic**: Chain of arithmetic operations
- **fan_in**: Multiple stream concatenation
- **fan_out**: Single stream splitting
- **fork_join**: Iterative fork-join patterns
- **identity**: Pass-through operations
- **join**: Hash join operations
- **reachability**: Graph reachability (includes Differential Dataflow)
- **upcase**: String transformation operations

See [timely-differential-benchmarks/README.md](timely-differential-benchmarks/README.md) for detailed documentation.

### Quick Start

```bash
# Run all benchmarks
cd timely-differential-benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run specific benchmark function
cargo bench --bench reachability -- "reachability/timely"
```

## Purpose

This repository serves as a home for Hydro-related components that:
1. Have heavy dependencies (Timely/Differential Dataflow)
2. Are used for performance comparisons
3. Benefit from independent version management
4. Reduce compilation times in the main Hydro repository

## Migration History

The Timely and Differential Dataflow benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` to enable:
- Reduced dependency overhead in the main Hydro project
- Dedicated performance testing environment
- Independent benchmark maintenance and updates

See [timely-differential-benchmarks/MIGRATION.md](timely-differential-benchmarks/MIGRATION.md) for complete migration documentation.

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro project repository with Hydro-specific benchmarks
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow

## License

This repository inherits the license from the Hydro project.