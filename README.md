# Timely and Differential Dataflow Benchmarks

This repository contains performance benchmarks comparing Hydroflow against Timely Dataflow and Differential Dataflow.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a clear separation of concerns and avoid unnecessary dependencies on `timely` and `differential-dataflow` packages in the core repository.

## Benchmarks Included

The following benchmarks are available:

- **arithmetic** - Arithmetic operations performance comparison
- **fan_in** - Multiple input streams merging into one
- **fan_out** - Single stream splitting to multiple outputs
- **fork_join** - Fork/join pattern with filtering
- **identity** - Pass-through/identity operations
- **join** - Stream join operations
- **micro_ops** - Micro-benchmarks for basic operations
- **reachability** - Graph reachability computation (uses differential-dataflow)
- **symmetric_hash_join** - Symmetric hash join implementation
- **upcase** - String transformation operations

## Setup

### Prerequisites

1. Ensure you have Rust installed (see [rustup.rs](https://rustup.rs/))
2. Clone both repositories as siblings:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
   ```

The benchmarks expect the main Hydroflow repository to be located at `../bigweaver-agent-canary-hydro-zeta/hydroflow` relative to this repository.

### Alternative: Git Dependency

If you prefer to use a git dependency instead of a local path, edit `Cargo.toml` and change:
```toml
hydroflow = { path = "../bigweaver-agent-canary-hydro-zeta/hydroflow" }
```
to:
```toml
hydroflow = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" }
```

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Benchmark Output

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) and will generate:
- Console output with performance statistics
- HTML reports in `target/criterion/` directory

## Performance Comparison

These benchmarks allow for performance comparisons between:
- Hydroflow implementations
- Timely Dataflow implementations  
- Differential Dataflow implementations (where applicable)

The goal is to track Hydroflow's performance relative to established dataflow systems and ensure optimizations are retained over time.

## Contributing

When adding new benchmarks:
1. Add the benchmark source file to `benches/benches/`
2. Register it in `Cargo.toml` under `[[bench]]`
3. Follow existing benchmark patterns for consistency
4. Include comparison implementations for Hydroflow, Timely, and Differential (where applicable)

## License

Apache-2.0