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

## Running Benchmarks

### Prerequisites

The benchmarks compare multiple dataflow implementations:
- **timely-dataflow** and **differential-dataflow** (dependencies in this repo)
- **babyflow**, **hydroflow**, and **spinachflow** (optional, from the main repository)

To enable cross-framework benchmarking, you need to:

1. Clone both repositories side-by-side:
   ```bash
   git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
   git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Uncomment the path dependencies in `timely-differential-benches/Cargo.toml`:
   ```toml
   babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
   hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
   spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
   ```

### Run All Benchmarks

```bash
# Run only timely/differential benchmarks (without path dependencies)
cargo bench

# Or run all benchmarks including cross-framework comparison (with path dependencies uncommented)
cargo bench -p timely-differential-benches
```

### Run Specific Benchmark

```bash
cargo bench -p timely-differential-benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark for data aggregation
- `fan_out` - Fan-out pattern benchmark for data distribution
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity operation benchmark (data pass-through)
- `join` - Join operation benchmark
- `reachability` - Graph reachability computation benchmark
- `upcase` - String uppercase transformation benchmark
- `zip` - Zip operation benchmark

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