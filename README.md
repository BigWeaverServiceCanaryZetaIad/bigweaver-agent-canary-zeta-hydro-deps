# Hydro Dependencies

This repository contains performance comparison benchmarks for Hydro/DFIR against Timely Dataflow and Differential Dataflow frameworks. These benchmarks were separated from the main [Hydro repository](https://github.com/hydro-project/hydro) to isolate dependencies on external dataflow frameworks.

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks comparing DFIR/Hydro performance against:
- **Timely Dataflow**: A low-latency cyclic dataflow computational model
- **Differential Dataflow**: An implementation of differential dataflow over timely dataflow

These benchmarks measure performance across various operations including:
- Graph reachability algorithms
- Join operations (with different data types)
- Stream transformations (map, filter, etc.)
- Fork-join patterns
- Fan-in/fan-out operations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

To run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench fork_join
```

## Benchmark Results

Benchmark results are generated in HTML format and stored in `target/criterion/` after running the benchmarks. Open `target/criterion/report/index.html` in a browser to view detailed performance reports.

## Dependencies

This repository depends on:
- `dfir_rs` - From the main Hydro repository
- `sinktools` - From the main Hydro repository  
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework
- `criterion` - For benchmark harness and reporting

## Repository Structure

```
.
├── benches/
│   ├── Cargo.toml          # Benchmark package configuration
│   ├── build.rs            # Build script for generating benchmark code
│   └── benches/
│       ├── arithmetic.rs   # Arithmetic operation benchmarks
│       ├── fan_in.rs       # Fan-in pattern benchmarks
│       ├── fan_out.rs      # Fan-out pattern benchmarks
│       ├── fork_join.rs    # Fork-join pattern benchmarks
│       ├── identity.rs     # Identity operation benchmarks
│       ├── join.rs         # Join operation benchmarks
│       ├── reachability.rs # Graph reachability benchmarks
│       ├── upcase.rs       # String transformation benchmarks
│       └── *.txt           # Test data files
└── Cargo.toml              # Workspace configuration
```

## Related Repositories

- [Hydro Main Repository](https://github.com/hydro-project/hydro) - Contains the DFIR runtime and Hydro language
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)