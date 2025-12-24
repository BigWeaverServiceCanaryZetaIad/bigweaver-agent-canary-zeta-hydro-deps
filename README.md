# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks for timely-dataflow and differential-dataflow that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons between different dataflow implementations without adding heavy dependencies to the main codebase.

## Purpose

The primary purpose of this repository is to:

1. **Isolate timely/differential dependencies**: Keep timely-dataflow and differential-dataflow dependencies separate from the main codebase
2. **Enable performance comparisons**: Compare timely/differential-dataflow against alternative implementations (babyflow, hydroflow, spinachflow) from the main repository
3. **Improve build times**: Avoid compiling these heavy dependencies in the main repository
4. **Maintain benchmarking infrastructure**: Provide a dedicated space for performance testing and comparison

## Repository Structure

```
.
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
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

## Running Benchmarks

### Prerequisites

Both repositories must be cloned side-by-side (in the same parent directory) for the path dependencies to work:

```bash
# Clone both repositories
git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

The expected directory structure:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/     # Core implementations
│   ├── babyflow/
│   ├── hydroflow/
│   └── spinachflow/
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
    └── timely-differential-benches/
```

### Run All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run Specific Benchmark

```bash
cargo bench -p timely-differential-benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations comparison
- `fan_in` - Fan-in pattern for data aggregation
- `fan_out` - Fan-out pattern for data distribution
- `fork_join` - Fork-join pattern
- `identity` - Identity operation (data pass-through)
- `join` - Join operation
- `reachability` - Graph reachability computation
- `upcase` - String uppercase transformation
- `zip` - Zip operation

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
2. **Maintain comparisons**: Allow performance comparisons between different dataflow implementations:
   - **timely-dataflow**: Low-latency data-parallel dataflow system
   - **differential-dataflow**: Incremental computation based on timely-dataflow
   - **babyflow, hydroflow, spinachflow**: Alternative implementations from the main repository
3. **Reduce build time**: Avoid compiling heavy dependencies in the main repository
4. **Focused development**: Keep the main repository focused on its core functionality

The main repository now contains only the core dataflow implementations (babyflow, hydroflow, spinachflow) without any timely/differential-dataflow dependencies. This repository includes those dependencies and uses path dependencies to reference the core implementations for performance comparison.

For detailed migration information, see [MIGRATION.md](MIGRATION.md).

## Development

### Building

```bash
cargo build
```

**Note**: Building requires the `bigweaver-agent-canary-hydro-zeta` repository to be present in the parent directory (side-by-side with this repository) since the benchmarks depend on babyflow, hydroflow, and spinachflow implementations from that repository.

### Testing

```bash
cargo test
```

### Benchmarking

```bash
cargo bench
```

Results are saved in `target/criterion/` and can be viewed by opening `target/criterion/report/index.html` in a web browser.

### Path Dependencies

This repository uses path dependencies to reference the core implementations:

```toml
babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
```

These paths assume both repositories are cloned side-by-side in the same parent directory.

## License

See the main repository for license information.