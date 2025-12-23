# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons without adding these dependencies to the main codebase.

## Repository Structure

```
.
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
├── MIGRATION.md                         # Detailed migration documentation
├── scripts/
│   └── compare_benchmarks.sh           # Cross-repository benchmark comparison script
└── timely-differential-benches/
    ├── Cargo.toml                       # Benchmark package configuration
    ├── README.md                        # Benchmark documentation
    └── benches/                         # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt       # Test data
        ├── reachability_reachable.txt   # Test data
        ├── upcase.rs
        └── zip.rs
```

## Dependencies

This repository includes the following external dependencies:

- **timely-dataflow** (`timely`): A low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **criterion**: Benchmarking framework
- Other supporting dependencies (lazy_static, rand, seq-macro, tokio)

### Optional Dependencies (Cross-Repository Comparison)

When the `cross-repo-compare` feature is enabled, the following path dependencies are used:
- **babyflow**: Custom dataflow implementation (from main repository)
- **hydroflow**: Alternative dataflow implementation (from main repository)
- **spinachflow**: Another dataflow variant (from main repository)

## Running Benchmarks

### Basic Usage (Timely/Differential Only)

Run benchmarks using only timely and differential-dataflow:

```bash
cargo bench
```

This will execute benchmarks for timely-dataflow and differential-dataflow implementations without requiring the main repository to be present.

### Cross-Repository Comparison

To run benchmarks that compare all implementations (including babyflow, hydroflow, and spinachflow):

1. **Clone both repositories side-by-side**:
   ```bash
   git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
   git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
   ```

2. **Run benchmarks with the cross-repo-compare feature**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench --features cross-repo-compare
   ```

3. **Or use the comparison script**:
   ```bash
   ./scripts/compare_benchmarks.sh
   ```

### Run Specific Benchmark

```bash
# Without cross-repo-compare
cargo bench -p timely-differential-benches --bench <benchmark_name>

# With cross-repo-compare
cargo bench -p timely-differential-benches --bench <benchmark_name> --features cross-repo-compare
```

Available benchmarks:
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `identity`
- `join`
- `reachability`
- `upcase`
- `zip`

## Features

- **default**: Runs benchmarks for timely-dataflow and differential-dataflow only
- **cross-repo-compare**: Enables benchmarks for babyflow, hydroflow, and spinachflow (requires main repository at ../bigweaver-agent-canary-hydro-zeta)

## Migration Notes

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. **Separate dependencies**: Remove timely and differential-dataflow dependencies from the main codebase
2. **Maintain comparisons**: Allow performance comparisons between different dataflow implementations
3. **Reduce build time**: Avoid compiling these dependencies in the main repository
4. **Focused development**: Keep the main repository focused on its core functionality

For detailed migration information, see [MIGRATION.md](MIGRATION.md).

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
# Basic benchmarks
cargo bench

# With cross-repository comparison
cargo bench --features cross-repo-compare
```

Results are saved in `target/criterion/` and can be viewed by opening `target/criterion/report/index.html` in a web browser.

## Troubleshooting

### Error: "failed to load manifest" for babyflow/hydroflow/spinachflow

This error occurs when running benchmarks with the `cross-repo-compare` feature enabled but the main repository is not available. Solutions:

1. Clone the main repository side-by-side: `../bigweaver-agent-canary-hydro-zeta`
2. Or run without the feature flag: `cargo bench` (runs timely/differential benchmarks only)

### Benchmarks not running

Make sure you're in the repository root directory and run:
```bash
cargo bench -p timely-differential-benches
```

## License

See the main repository for license information.