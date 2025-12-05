# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on heavyweight dependencies like `timely` and `differential-dataflow`. These have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the main repository clean and reduce build times.

## Contents

- **benches/** - Performance benchmarks comparing Hydro/DFIR with timely and differential-dataflow implementations

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed. The benchmarks use Criterion for performance testing.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Arithmetic operations benchmark
cargo bench -p benches --bench arithmetic

# Fan-in/Fan-out patterns
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out

# Fork-join pattern
cargo bench -p benches --bench fork_join

# Identity transformation
cargo bench -p benches --bench identity

# Join operations
cargo bench -p benches --bench join

# Reachability analysis (differential-dataflow)
cargo bench -p benches --bench reachability

# Micro operations
cargo bench -p benches --bench micro_ops

# Symmetric hash join
cargo bench -p benches --bench symmetric_hash_join

# String operations
cargo bench -p benches --bench upcase

# Words diamond pattern
cargo bench -p benches --bench words_diamond

# Futures operations
cargo bench -p benches --bench futures
```

## Performance Comparison

The benchmarks in this repository allow for performance comparison between:
- **DFIR (Dataflow Intermediate Representation)** - The Hydro framework's runtime
- **Timely Dataflow** - A low-latency data-parallel dataflow system
- **Differential Dataflow** - An incremental data-parallel dataflow system

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark crate
│   ├── benches/               # Criterion benchmark files
│   │   ├── arithmetic.rs     # Arithmetic operations
│   │   ├── fan_in.rs         # Fan-in pattern
│   │   ├── fan_out.rs        # Fan-out pattern
│   │   ├── fork_join.rs      # Fork-join pattern
│   │   ├── futures.rs        # Futures operations
│   │   ├── identity.rs       # Identity transformation
│   │   ├── join.rs           # Join operations
│   │   ├── micro_ops.rs      # Micro operations
│   │   ├── reachability.rs   # Reachability (uses differential-dataflow)
│   │   ├── symmetric_hash_join.rs  # Symmetric hash join
│   │   ├── upcase.rs         # String uppercase operations
│   │   └── words_diamond.rs  # Word processing diamond pattern
│   ├── Cargo.toml            # Benchmark dependencies
│   └── README.md             # Benchmark-specific documentation
├── Cargo.toml                # Workspace configuration
└── README.md                 # This file
```

## Migration Notes

These benchmarks were moved from the main repository to:
1. Reduce build times for core development
2. Isolate heavyweight dependencies (timely, differential-dataflow)
3. Allow independent performance testing and comparison
4. Keep the main repository focused on core Hydro functionality

For more details on the migration, see `BENCHMARK_MIGRATION.md` in the main repository.

## Contributing

When adding new benchmarks:
1. Place benchmark files in `benches/benches/`
2. Update the `[[bench]]` sections in `benches/Cargo.toml`
3. Follow the existing patterns for comparative benchmarks
4. Document the benchmark purpose in this README

## Dependencies

The benchmarks depend on:
- **criterion** - For benchmark harness and reporting
- **timely-master** - Timely dataflow system
- **differential-dataflow-master** - Differential dataflow system
- **dfir_rs** - From the main Hydro repository (via git)
- **sinktools** - From the main Hydro repository (via git)
- Various supporting libraries (futures, tokio, rand, etc.)

## License

Apache-2.0 - See LICENSE file in the repository root.