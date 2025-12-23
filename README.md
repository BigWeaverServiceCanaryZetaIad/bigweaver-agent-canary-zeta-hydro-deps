# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons without adding these dependencies to the main codebase.

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

## Setup

### Prerequisites

To run the benchmarks, you need access to the main `bigweaver-agent-canary-hydro-zeta` repository containing the `babyflow`, `hydroflow`, and `spinachflow` packages. The benchmarks compare the performance of these implementations with timely-dataflow and differential-dataflow.

### Configuring Path Dependencies

The benchmarks use path dependencies to reference the main repository. You have two options:

#### Option 1: Clone repositories side-by-side (Recommended)

```bash
# Clone both repositories in the same parent directory
git clone <url>/bigweaver-agent-canary-hydro-zeta.git
git clone <url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

Then uncomment the path dependencies in `timely-differential-benches/Cargo.toml`:
```toml
babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
```

#### Option 2: Custom path

If you have the main repository in a different location, update the paths in `timely-differential-benches/Cargo.toml` accordingly.

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
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `identity`
- `join`
- `reachability`
- `upcase`
- `zip`

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
2. **Maintain comparisons**: Allow performance comparisons between different dataflow implementations
3. **Reduce build time**: Avoid compiling these dependencies in the main repository
4. **Focused development**: Keep the main repository focused on its core functionality

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