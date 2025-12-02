# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` packages, separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unwanted dependencies and improve build times.

## Contents

### Benchmarks (`benches/`)

Microbenchmarks for Hydro and related crates that require timely and differential-dataflow dependencies.

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed with the appropriate toolchain. The benchmarks use criterion for performance testing.

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

Run a single benchmark:
```bash
cargo bench -p benches --bench reachability
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity transformations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercase operations
- `words_diamond` - Word processing with diamond pattern

### Benchmark Output

Benchmarks generate HTML reports in `target/criterion/` directory. Open `target/criterion/report/index.html` in a browser to view detailed results.

## Comparing Performance with Main Repository

To compare performance between this repository and the main hydro repository:

1. **Run benchmarks in this repository:**
   ```bash
   cargo bench -p benches --bench <benchmark_name> -- --save-baseline deps-baseline
   ```

2. **Run equivalent benchmarks in the main repository** (if they still exist):
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p <package> --bench <benchmark_name> -- --save-baseline main-baseline
   ```

3. **Compare results:**
   ```bash
   # In this repository
   cargo bench -p benches --bench <benchmark_name> -- --baseline deps-baseline
   ```

4. **View HTML reports:**
   - Open `target/criterion/<benchmark_name>/report/index.html` for detailed graphs
   - Comparison results show relative performance differences

### Performance Comparison Notes

- Ensure consistent hardware and system load when comparing
- Run benchmarks multiple times for statistical significance
- Use `--warm-up-time` and `--measurement-time` flags for longer, more accurate runs:
  ```bash
  cargo bench -- --warm-up-time 5 --measurement-time 10
  ```

## Dependencies

This repository depends on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- Components from main repository (via git dependencies):
  - `dfir_rs` - DFIR runtime
  - `sinktools` - Sink utilities

## Repository Structure

```
.
├── Cargo.toml          # Workspace configuration
├── README.md           # This file
└── benches/
    ├── Cargo.toml      # Benchmark package configuration
    ├── build.rs        # Build script for code generation
    └── benches/        # Benchmark implementations
        ├── *.rs        # Benchmark source files
        └── *.txt       # Test data files
```

## Why This Repository Exists

This repository was created to:
1. **Improve build times** - Separating heavy dependencies reduces compilation time for developers working on the main repository
2. **Maintain clean dependencies** - Avoid polluting the main repository with optional benchmark dependencies
3. **Preserve benchmarking capability** - Keep comprehensive performance testing without impacting day-to-day development
4. **Enable focused optimization** - Allow performance engineering to work independently

## Migration Guide

If you were previously running benchmarks from the main repository:

1. **Clone this repository:**
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Update your scripts** to point to this repository for benchmark execution

3. **Historical benchmark data** remains in the main repository's git history (before the migration)

## Contributing

Contributions should follow the same guidelines as the main hydro repository. See [CONTRIBUTING.md](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md) in the main repository.

## License

Apache-2.0 - Same as the main hydro repository.