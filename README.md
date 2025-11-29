# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the Hydro project that depend on `timely-master` and `differential-dataflow-master` packages.

## Purpose

These benchmarks have been moved to a separate repository to:
- Avoid timely and differential-dataflow dependencies in the main Hydro repository
- Maintain the ability to run performance comparisons between Hydro and timely/differential-dataflow
- Keep benchmark-specific dependencies isolated from the main codebase
- Preserve historical performance data and comparison methodology

## Contents

- `benches/`: Microbenchmarks for Hydro that compare performance with timely and differential-dataflow implementations
  - Benchmark suite with 12 different scenarios
  - Data files for graph and text processing benchmarks
  - Build scripts for generating benchmark code

## Repository Structure

```
.
├── Cargo.toml              # Workspace configuration
├── clippy.toml             # Clippy linting configuration
├── rustfmt.toml            # Code formatting configuration
├── rust-toolchain.toml     # Rust toolchain version specification
└── benches/
    ├── Cargo.toml          # Benchmark package configuration
    ├── build.rs            # Build script for code generation
    ├── README.md           # Detailed benchmark documentation
    └── benches/            # Benchmark source files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        └── words_diamond.rs
```

## Available Benchmarks

1. **arithmetic** - Pipeline arithmetic operations benchmark
2. **fan_in** - Fan-in pattern benchmark
3. **fan_out** - Fan-out pattern benchmark  
4. **fork_join** - Fork-join pattern benchmark
5. **futures** - Async futures benchmark
6. **identity** - Identity operation benchmark
7. **join** - Join operation benchmark
8. **micro_ops** - Micro-operations benchmark
9. **reachability** - Graph reachability benchmark
10. **symmetric_hash_join** - Symmetric hash join benchmark
11. **upcase** - String uppercase benchmark
12. **words_diamond** - Diamond pattern with word processing

## Running Benchmarks

### Prerequisites

- Rust toolchain (specified in `rust-toolchain.toml`)
- Access to the main bigweaver-agent-canary-hydro-zeta repository (for cross-repository dependencies)

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
```

### Run with Output

```bash
cargo bench -p benches --bench reachability -- --verbose
```

### Generate Benchmark Reports

Criterion automatically generates HTML reports in `target/criterion/`.

## Dependencies

### Key Dependencies

- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **criterion** (v0.5.0) - Benchmarking framework with HTML reports
- **dfir_rs** - Hydro's dataflow IR (from main repository)
- **sinktools** - Utility tools (from main repository)

### Cross-Repository Dependencies

This repository depends on components from the main bigweaver-agent-canary-hydro-zeta repository:
- `dfir_rs` at `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- `sinktools` at `../../bigweaver-agent-canary-hydro-zeta/sinktools`

Ensure both repositories are checked out in the same parent directory.

## Development

### Code Quality Tools

- **rustfmt**: Run `cargo fmt` to format code
- **clippy**: Run `cargo clippy` for linting

### Building

```bash
# Check if code compiles
cargo check -p benches

# Build benchmarks
cargo build -p benches --benches
```

## Performance Comparison Methodology

These benchmarks enable fair comparisons between:
- Hydro's dfir_rs implementation
- Timely dataflow implementations
- Differential dataflow implementations

Each benchmark measures:
- Throughput (operations per second)
- Latency (time per operation)
- Resource utilization

## Maintenance

When updating benchmarks:
1. Ensure compatibility with the specified timely/differential-dataflow versions
2. Update cross-repository dependency paths if repository structure changes
3. Re-run all benchmarks to validate changes
4. Update documentation with any new benchmarks or methodology changes

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro project repository