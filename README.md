# Hydro Dependencies Benchmarks

This repository contains benchmarks that compare Hydro/DFIR performance against external dataflow frameworks, specifically **Timely Dataflow** and **Differential Dataflow**.

## Purpose

These benchmarks were separated from the main Hydro repository to:
- Keep the main repository focused on core functionality
- Reduce dependency burden on the main codebase
- Allow independent performance comparison and testing
- Maintain benchmark history for performance regression tracking

## Benchmarks Included

This repository contains the following performance comparison benchmarks:

1. **arithmetic.rs** - Arithmetic operations comparison across different frameworks
2. **fan_in.rs** - Fan-in pattern benchmark  
3. **fan_out.rs** - Fan-out pattern benchmark
4. **fork_join.rs** - Fork-join pattern benchmark
5. **identity.rs** - Identity transformation benchmark
6. **join.rs** - Join operation benchmark
7. **reachability.rs** - Graph reachability benchmark (includes data files)
8. **upcase.rs** - String uppercase operation benchmark

## Data Files

- **reachability_edges.txt** - Graph edge data for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for reachability verification

## Dependencies

### External Framework Dependencies

- `timely` (timely-master 0.13.0-dev.1) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1) - Differential Dataflow framework

### Hydro Dependencies

These benchmarks depend on components from the main Hydro repository:
- `dfir_rs` - Core DFIR runtime and syntax
- `sinktools` - Sink utilities for data collection

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

Run benchmarks with specific patterns:
```bash
cargo bench fan_in
cargo bench fan_out
```

## Build Process

The `fork_join` benchmark requires a build script (`build.rs`) that generates Hydroflow code at compile time. This is automatically executed during `cargo build` or `cargo bench`.

## Repository Structure

```
.
├── Cargo.toml           # Package configuration and dependencies
├── build.rs             # Build script for code generation
├── README.md            # This file
└── benches/             # Benchmark source files
    ├── .gitignore       # Ignore generated files
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── reachability_edges.txt
    ├── reachability_reachable.txt
    └── upcase.rs
```

## Benchmark Focus Areas

These benchmarks measure performance across several key areas:

- **Graph Operations**: Reachability algorithms
- **Join Operations**: Various join patterns with different data types
- **Micro-operations**: map, flat_map, union, tee, fold, sort
- **Data Flow Patterns**: Fan-in, fan-out, fork-join
- **String Operations**: Transformation and processing

## Development

When making changes to the benchmarks:

1. Ensure benchmarks build successfully: `cargo build --benches`
2. Run benchmarks to verify functionality: `cargo bench`
3. Check that performance comparisons remain fair and accurate
4. Update this README if adding or modifying benchmarks

## License

Apache-2.0

## Related Repositories

- Main Hydro Repository: [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta)