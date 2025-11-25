# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro performance against external dataflow frameworks (timely and differential-dataflow).

## Purpose

This repository was created to:
- Isolate external dependencies (timely and differential-dataflow) from the main Hydro codebase
- Maintain performance comparison benchmarks between Hydro and other dataflow systems
- Keep the main Hydro repository focused on core functionality
- Reduce build times and dependency complexity in the main repository

## Repository Structure

```
.
├── benches/                    # Performance benchmarks
│   ├── benches/               # Individual benchmark files
│   │   ├── arithmetic.rs     # Arithmetic operations benchmark
│   │   ├── fan_in.rs         # Fan-in pattern benchmark
│   │   ├── fan_out.rs        # Fan-out pattern benchmark
│   │   ├── fork_join.rs      # Fork-join pattern benchmark
│   │   ├── identity.rs       # Identity operation benchmark
│   │   ├── join.rs           # Join operation benchmark
│   │   ├── reachability.rs   # Graph reachability benchmark
│   │   └── upcase.rs         # String uppercase benchmark
│   ├── Cargo.toml            # Benchmark dependencies
│   ├── README.md             # Benchmark documentation
│   └── build.rs              # Build script for generated benchmarks
└── README.md                  # This file
```

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench reachability
```

To run benchmarks for a specific implementation:
```bash
cargo bench timely
cargo bench differential
cargo bench dfir_rs
```

## Benchmark Implementations

Each benchmark includes multiple implementations for comparison:
- **Timely**: Implementation using the timely-dataflow framework
- **Differential**: Implementation using differential-dataflow
- **Hydro (dfir_rs)**: Implementation using Hydro's dataflow runtime

This allows direct performance comparison between different dataflow systems.

## Dependencies

- **timely-master**: Timely dataflow framework
- **differential-dataflow-master**: Differential dataflow framework
- **dfir_rs**: Hydro dataflow runtime (from main repository)
- **criterion**: Benchmarking framework

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro): Main Hydro repository

## License

Apache-2.0