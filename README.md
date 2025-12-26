# bigweaver-agent-canary-zeta-hydro-deps

Benchmark repository for performance comparison between Hydro and Timely/Differential-Dataflow implementations.

## Overview

This repository contains benchmarks that depend on `timely-dataflow` and `differential-dataflow` for performance comparison with Hydro-native implementations. By separating these benchmarks from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository, we reduce build dependencies and improve build times for core development.

## Purpose

- **Performance Comparison**: Compare Hydro implementations against Timely/Differential-Dataflow
- **Benchmark Preservation**: Maintain comparative benchmarks without imposing heavy dependencies on the main repository
- **Independent Evaluation**: Enable independent performance testing and validation

## Repository Structure

```
.
├── benches/              # Benchmark suite
│   ├── benches/          # Benchmark implementations
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   ├── words_diamond.rs
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   └── words_alpha.txt
│   ├── build.rs          # Build script for code generation
│   ├── Cargo.toml        # Package configuration
│   └── README.md         # Benchmark documentation
├── Cargo.toml            # Workspace configuration
└── README.md             # This file
```

## Getting Started

### Prerequisites

- Rust toolchain (see main repository for version)
- Access to the main bigweaver-agent-canary-hydro-zeta repository (for dfir_rs and sinktools dependencies)

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

View benchmark reports:
```bash
# HTML reports are generated in target/criterion/
open target/criterion/report/index.html
```

## Available Benchmarks

### All Benchmarks with Timely/Differential-Dataflow Implementations

All benchmarks in this repository now include timely and/or differential-dataflow implementations for comprehensive performance comparison:

- **arithmetic** - Pipeline arithmetic operations with timely implementation
- **fan_in** - Multiple inputs to single output with timely implementation
- **fan_out** - Single input to multiple outputs with timely implementation
- **fork_join** - Fork-join pattern with code generation and timely implementation
- **futures** - Futures-based operations with timely dataflow overhead comparison
- **identity** - Identity transformation with timely implementation
- **join** - Join operations with timely implementation
- **micro_ops** - Micro-operations (identity, map, flat_map, filter) with timely implementations
- **reachability** - Graph reachability (large dataset) with timely and differential implementations
- **symmetric_hash_join** - Symmetric hash join with timely and differential implementations
- **upcase** - String uppercase transformation with timely implementation
- **words_diamond** - Word processing diamond pattern with timely implementation

### Running Specific Implementation Variants

Run only timely benchmarks:
```bash
cargo bench -p benches -- timely
```

Run only differential-dataflow benchmarks:
```bash
cargo bench -p benches -- differential
```

Run Hydro DFIR benchmarks:
```bash
cargo bench -p benches -- dfir_rs
```

## Performance Comparison Workflow

1. **Run Hydro-native benchmarks** in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run Timely/Differential benchmarks** in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. **Compare results** from both repositories using the generated Criterion reports

## Dependencies

This repository depends on:

- **timely-master** (0.13.0-dev.1) - Timely dataflow engine
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow engine
- **dfir_rs** - Hydro's DFIR implementation (from main repository)
- **sinktools** - Sink utilities (from main repository)
- **criterion** - Benchmarking framework

## Related Documentation

For more details about the benchmark migration, see:
- [BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md) in the main repository

## Contributing

When adding new benchmarks:

1. Ensure benchmarks with timely/differential-dataflow dependencies are added to this repository
2. Keep Hydro-native benchmarks in the main repository
3. Update both README files accordingly
4. Add appropriate `[[bench]]` entries in `benches/Cargo.toml`

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations