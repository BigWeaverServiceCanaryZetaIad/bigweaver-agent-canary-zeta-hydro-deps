# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that compare Hydro/DFIR performance with other dataflow systems like Timely Dataflow and Differential Dataflow.

## Benchmarks

Performance comparison benchmarks are located in the `benches/` directory. These benchmarks compare Hydro/DFIR implementations against:
- Timely Dataflow
- Differential Dataflow

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
```

### Available Benchmarks

The benchmarks include:
- **reachability**: Graph reachability algorithms comparing Timely, Differential, and DFIR implementations
- **fork_join**: Fork-join pattern benchmarks
- **arithmetic**: Arithmetic operations
- **join**: Join operations
- **micro_ops**: Micro-operation benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- And more...

## Purpose

This repository isolates the timely and differential-dataflow dependencies from the main Hydro repository while maintaining the ability to run performance comparisons. This separation allows:
- Clean separation of core Hydro code from external dataflow framework dependencies
- Preservation of performance comparison capabilities
- Independent versioning of benchmark code
