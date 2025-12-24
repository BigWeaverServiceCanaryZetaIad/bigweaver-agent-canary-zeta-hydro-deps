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

### Quick Start (Timely/Differential Only)

To run only the pure timely-dataflow and differential-dataflow benchmarks without cross-repository comparisons:

```bash
cargo bench
```

### Cross-Repository Comparison Setup

Some benchmarks compare multiple implementations (timely, differential, babyflow, hydroflow, spinachflow). To enable these comparisons:

1. Clone both repositories side-by-side:
   ```bash
   git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
   git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Edit `timely-differential-benches/Cargo.toml` and uncomment the path dependencies:
   ```toml
   babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
   hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
   spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
   ```

3. Run benchmarks:
   ```bash
   cargo bench
   ```

**Note**: Without configuring path dependencies, some benchmark variants will fail to compile, but timely/differential variants will still work.

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