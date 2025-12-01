# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for timely-dataflow and differential-dataflow, comparing them with Hydro/DFIR implementations.

## Overview

This repository was created to separate heavyweight benchmark dependencies (timely-dataflow and differential-dataflow) from the main bigweaver-agent-canary-hydro-zeta repository. This separation provides:

- ✅ Cleaner separation of heavyweight dependencies
- ✅ Improved build times for main repository
- ✅ Independent benchmark development and versioning
- ✅ Preserved performance comparison capabilities
- ✅ Optional performance testing (clone only when needed)

## Structure

```
benches/
├── Cargo.toml          # Benchmark dependencies and configurations
├── README.md           # Benchmark-specific documentation
├── build.rs            # Build script
└── benches/            # Benchmark implementations
    ├── arithmetic.rs              # Basic arithmetic operations
    ├── fan_in.rs                  # Fan-in patterns
    ├── fan_out.rs                 # Fan-out patterns
    ├── fork_join.rs               # Fork-join parallelism
    ├── futures.rs                 # Async futures handling
    ├── identity.rs                # Baseline overhead measurement
    ├── join.rs                    # Join operations
    ├── micro_ops.rs               # Micro-operation benchmarks
    ├── reachability.rs            # Graph reachability computation
    ├── symmetric_hash_join.rs     # Symmetric hash join implementation
    ├── upcase.rs                  # String transformation
    └── words_diamond.rs           # Diamond pattern with word processing
```

## Running Benchmarks

To run the benchmarks:

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability

# Run with specific features
cargo bench --features debugging
```

## Dependencies

The benchmarks depend on:
- `dfir_rs` - From the main hydro-zeta repository (via git)
- `sinktools` - From the main hydro-zeta repository (via git)
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `criterion` - Benchmark harness with statistical analysis

## Performance Comparison

These benchmarks enable performance comparisons between:
- Hydro/DFIR implementations
- timely-dataflow implementations
- differential-dataflow implementations

Each benchmark typically includes implementations in multiple frameworks to enable direct performance comparisons.

## Migration

This repository contains benchmarks migrated from the main bigweaver-agent-canary-hydro-zeta repository. The migration was performed to:
1. Reduce the dependency footprint of the main repository
2. Improve CI/CD build times
3. Enable independent benchmark development
4. Make performance testing optional

For more details on the migration, see the main repository's documentation.