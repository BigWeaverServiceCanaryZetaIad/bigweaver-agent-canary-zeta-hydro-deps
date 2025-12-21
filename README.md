# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons without adding these dependencies to the main codebase.

## Repository Structure

```
.
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
├── MIGRATION.md                         # Documentation of benchmark migration
├── scripts/
│   └── compare_benchmarks.sh           # Cross-repository benchmark comparison script
└── timely-differential-benches/
    ├── Cargo.toml                       # Benchmark package configuration
    ├── README.md                        # Benchmark documentation
    ├── build.rs                         # Build script for generated benchmarks
    └── benches/                         # Benchmark implementations
        ├── arithmetic.rs                # Timely/Differential benchmark
        ├── fan_in.rs                    # Timely/Differential benchmark
        ├── fan_out.rs                   # Timely/Differential benchmark
        ├── fork_join.rs                 # Timely/Differential benchmark
        ├── identity.rs                  # Timely/Differential benchmark
        ├── join.rs                      # Timely/Differential benchmark
        ├── reachability.rs              # Timely/Differential benchmark
        ├── reachability_edges.txt       # Test data
        ├── reachability_reachable.txt   # Test data
        ├── upcase.rs                    # Timely/Differential benchmark
        ├── zip.rs                       # Timely/Differential benchmark
        ├── micro_ops.rs                 # DFIR_rs comparison benchmark
        ├── symmetric_hash_join.rs       # DFIR_rs comparison benchmark
        ├── words_diamond.rs             # DFIR_rs comparison benchmark
        ├── words_alpha.txt              # Test data
        └── futures.rs                   # DFIR_rs comparison benchmark
```

## Dependencies

This repository includes the following external dependencies:

- **timely-dataflow** (`timely`): A low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **dfir_rs**: Hydro dataflow IR for comparison benchmarks
- **criterion**: Benchmarking framework
- Other supporting dependencies (futures, lazy_static, rand, seq-macro, sinktools, tokio)

## Available Benchmarks

### Timely/Differential Dataflow Benchmarks
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in pattern for data aggregation
- `fan_out` - Fan-out pattern for data distribution
- `fork_join` - Fork-join pattern
- `identity` - Identity operation (data pass-through)
- `join` - Join operation
- `reachability` - Graph reachability computation
- `upcase` - String uppercase transformation
- `zip` - Zip operation

### DFIR_rs Comparison Benchmarks
- `micro_ops` - Microbenchmarks of various DFIR_rs operations
- `symmetric_hash_join` - Symmetric hash join implementation
- `words_diamond` - Diamond-shaped dataflow pattern using word list
- `futures` - Async future handling

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark

```bash
cargo bench -p timely-differential-benches --bench <benchmark_name>
```

Available benchmarks:

**Timely/Differential benchmarks:**
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `identity`
- `join`
- `reachability`
- `upcase`
- `zip`

**DFIR_rs comparison benchmarks:**
- `micro_ops`
- `symmetric_hash_join`
- `words_diamond`
- `futures`

### Cross-Repository Comparison

To compare performance between this repository and the main repository:

```bash
./scripts/compare_benchmarks.sh
```

This script will:
1. Run all timely/differential-dataflow benchmarks in this repository
2. Run any benchmarks in the main repository (if available)
3. Generate comparison reports

## Migration Notes

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Separate dependencies**: Remove timely and differential-dataflow dependencies from the main codebase
2. **Maintain comparisons**: Allow performance comparisons between different dataflow implementations (timely/differential vs dfir_rs)
3. **Reduce build time**: Avoid compiling these dependencies in the main repository
4. **Focused development**: Keep the main repository focused on its core functionality

See [MIGRATION.md](MIGRATION.md) for detailed migration documentation.

## Development

### Building

```bash
cargo build
```

### Testing

```bash
cargo test
```

### Benchmarking

```bash
cargo bench
```

Results are saved in `target/criterion/` and can be viewed by opening `target/criterion/report/index.html` in a web browser.

## License

See the main repository for license information.