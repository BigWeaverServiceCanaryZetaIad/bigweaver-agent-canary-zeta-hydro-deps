# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows for performance comparisons without adding these dependencies to the main codebase.

## Repository Structure

```
.
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
├── MIGRATION.md                         # Migration documentation
├── VERIFICATION_SUMMARY.md              # Detailed verification results
├── scripts/
│   ├── compare_benchmarks.sh           # Cross-repository benchmark comparison script
│   └── verify_structure.sh             # Repository structure verification script
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

- **timely-dataflow** (`timely` v0.12): A low-latency data-parallel dataflow system (actively used in benchmarks)
- **differential-dataflow** (v0.12): Incremental computation based on timely-dataflow (available for future benchmarks)
- **criterion** (v0.3): Benchmarking framework with async tokio support
- **Cross-repository dependencies**: babyflow, hydroflow, spinachflow (via path dependencies to main repository)
- Other supporting dependencies: lazy_static, rand, seq-macro, tokio

## Setup Instructions

The benchmarks in this repository depend on the core dataflow implementations (babyflow, hydroflow, spinachflow) from the `bigweaver-agent-canary-hydro-zeta` repository.

### Prerequisites

1. Clone both repositories side-by-side:

```bash
git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Enable path dependencies in `timely-differential-benches/Cargo.toml`:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
```

Edit `Cargo.toml` and uncomment the following lines under `[dev-dependencies]`:

```toml
babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
```

## Running Benchmarks

### Run All Benchmarks

```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run Specific Benchmark

```bash
cargo bench -p timely-differential-benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity operator benchmark
- `join` - Join operation benchmark
- `reachability` - Graph reachability benchmark (includes data files)
- `upcase` - String transformation benchmark
- `zip` - Zip operation benchmark

### Cross-Repository Comparison

To compare performance between this repository and the main repository:

```bash
./scripts/compare_benchmarks.sh
```

This script will:
1. Run all timely/differential-dataflow benchmarks in this repository
2. Compare performance across different dataflow implementations (timely, differential, babyflow, hydroflow, spinachflow)
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

## Troubleshooting

### Path Dependencies
The benchmarks depend on `babyflow`, `hydroflow`, and `spinachflow` from the main repository via relative path dependencies:
```toml
babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
```

Ensure the main repository is located at `../bigweaver-agent-canary-hydro-zeta` relative to this repository.

### Build Errors
If you encounter build errors:
1. Verify the main repository exists and is up to date
2. Run `cargo clean` and rebuild
3. Check that all path dependencies are accessible
4. Ensure you have the correct Rust toolchain installed

### Benchmark Discovery
All benchmarks are explicitly declared in `timely-differential-benches/Cargo.toml` with `harness = false`. If a benchmark is not discovered:
1. Check that it's listed in the `[[bench]]` sections
2. Verify the file exists in `timely-differential-benches/benches/`
3. Ensure the benchmark name matches the filename (without `.rs` extension)

## Verification

To verify the repository is properly configured:

### Quick Verification
```bash
# Run the automated structure verification script
./scripts/verify_structure.sh
```

### Manual Verification
```bash
# Check workspace structure
cargo metadata --no-deps

# Build all packages
cargo build

# Run a single benchmark to verify setup
cargo bench --bench arithmetic -- --test

# Run all benchmarks
cargo bench
```

## License

See the main repository for license information.