# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks for Timely Dataflow and Differential Dataflow implementations compared against Hydro/DFIR.

## Purpose

This repository was created to isolate benchmarks that depend on external frameworks (Timely Dataflow and Differential Dataflow) from the main Hydro repository. This separation:

1. **Reduces build dependencies**: The main Hydro repository no longer needs Timely/Differential dependencies
2. **Maintains comparison capability**: Performance comparisons can still be conducted
3. **Improves build times**: Developers working on Hydro core don't need to build external dependencies
4. **Preserves benchmark history**: All benchmark code and test data are retained

## Repository Structure

```
.
├── benches/
│   ├── Cargo.toml              # Benchmark dependencies and configuration
│   ├── README.md               # Benchmark-specific documentation
│   ├── build.rs                # Build script for generated benchmarks
│   └── benches/
│       ├── arithmetic.rs       # Arithmetic operations benchmark
│       ├── fan_in.rs          # Fan-in pattern benchmark
│       ├── fan_out.rs         # Fan-out pattern benchmark
│       ├── fork_join.rs       # Fork-join pattern benchmark
│       ├── identity.rs        # Identity operation benchmark
│       ├── join.rs            # Join operation benchmark
│       ├── reachability.rs    # Graph reachability benchmark
│       ├── upcase.rs          # String transformation benchmark
│       ├── reachability_edges.txt        # Test data
│       └── reachability_reachable.txt    # Test data
├── Cargo.toml                  # Workspace configuration
├── README.md                   # This file
└── run_benchmarks.sh          # Convenience script for running benchmarks
```

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p hydro-benches-comparison
```

To run a specific benchmark:
```bash
cargo bench -p hydro-benches-comparison --bench <benchmark_name>
```

Example:
```bash
cargo bench -p hydro-benches-comparison --bench reachability
```

## Cross-Repository Performance Comparison

To compare performance between Hydro implementations and Timely/Differential implementations:

1. **Run benchmarks in this repository** for Timely/Differential comparisons
2. **Run benchmarks in bigweaver-agent-canary-hydro-zeta** for DFIR-native implementations
3. **Compare results** to understand relative performance

The main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) contains DFIR-native benchmarks:
- `micro_ops`: Micro-operations performance
- `futures`: Futures-based operations
- `symmetric_hash_join`: Symmetric hash join
- `words_diamond`: Word processing patterns

## Dependencies

This repository depends on:
- **timely-master**: Timely Dataflow framework
- **differential-dataflow-master**: Differential Dataflow framework  
- **dfir_rs**: Hydro's Dataflow IR (from main repository via git)
- **criterion**: Benchmarking framework

## Migration History

These benchmarks were migrated from the main Hydro repository to:
- Reduce dependency burden on core Hydro development
- Maintain performance comparison capabilities
- Preserve historical benchmark data and configurations

For more details, see the main repository's documentation on benchmark architecture.

## Contributing

When adding new comparison benchmarks:
1. Add benchmark implementation in `benches/benches/`
2. Update `benches/Cargo.toml` with the new `[[bench]]` entry
3. Update `benches/README.md` to document the new benchmark
4. Include any required test data files

## License

Apache-2.0
