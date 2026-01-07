# Hydro Dependencies Benchmarks

This repository contains benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow frameworks.

## Purpose

These benchmarks were separated from the main Hydro repository to:
- Maintain clear separation between core Hydro functionality and external framework dependencies
- Enable performance comparisons with Timely and Differential Dataflow
- Reduce dependency footprint in the main Hydro repository

## Benchmarks Included

The following benchmarks compare Hydro implementations against Timely and/or Differential Dataflow:

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in dataflow patterns
- **fan_out** - Fan-out dataflow patterns
- **fork_join** - Fork-join patterns
- **identity** - Identity transformations
- **join** - Join operations with different data types (usize, String)
- **reachability** - Graph reachability algorithms
- **upcase** - String uppercase operations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

## Dependencies

These benchmarks depend on:
- `dfir_rs` - from the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - from the main bigweaver-agent-canary-hydro-zeta repository
- `timely` - Timely Dataflow framework
- `differential-dataflow` - Differential Dataflow framework
- `criterion` - Benchmarking framework

## Performance Comparison

The benchmarks provide comparative performance metrics between:
1. **Hydro/DFIR implementations** - Using the dfir_rs syntax and runtime
2. **Timely Dataflow** - Using direct Timely operators
3. **Differential Dataflow** - Using Differential's incremental computation
4. **Baseline implementations** - Raw Rust implementations for comparison

Results are generated as HTML reports in `target/criterion/`.

## Integration with Main Repository

These benchmarks reference the main Hydro repository for core dependencies. Ensure both repositories are checked out as siblings:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/    # Main Hydro repository
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
```

## Contributing

When adding new benchmarks that compare Hydro with Timely or Differential Dataflow, they should be added to this repository rather than the main Hydro repository.

Benchmarks that only test Hydro functionality without external framework comparisons should remain in the main repository.
