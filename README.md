# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository serves to:
- Isolate timely and differential-dataflow dependencies from the main codebase
- Maintain performance benchmarks for various dataflow patterns
- Enable performance comparisons between different implementations
- Keep the main repository cleaner and reduce build times

## Contents

### Benchmarks

The `benches/` directory contains comprehensive benchmarks comparing:
- **Timely Dataflow** implementations
- **Differential Dataflow** implementations  
- **Hydroflow/dfir_rs** implementations
- **Raw Rust** implementations

#### Available Benchmarks

- **arithmetic.rs** - Arithmetic operations benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Futures-based benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operations benchmarks
- **reachability.rs** - Graph reachability benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String uppercase benchmarks
- **words_diamond.rs** - Word processing benchmarks

## Running Benchmarks

### Prerequisites

- Rust toolchain (specified in `rust-toolchain.toml`)
- Git access to the main bigweaver-agent-canary-hydro-zeta repository

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run a specific benchmark
cargo bench -p benches --bench reachability

# Run all join-related benchmarks
cargo bench -p benches --bench join
cargo bench -p benches --bench symmetric_hash_join
```

### Quick Benchmark Run

For faster iteration during development:

```bash
# Run with reduced sample size
cargo bench -p benches -- --quick
```

## Performance Comparison

The benchmarks are designed to enable performance comparisons across different dataflow implementations:

1. **Timely Dataflow** - Low-latency dataflow system
2. **Differential Dataflow** - Incremental computation framework built on Timely
3. **Hydroflow** - The main framework from bigweaver-agent-canary-hydro-zeta
4. **Raw Rust** - Baseline implementations for comparison

Each benchmark typically includes multiple variants to compare these implementations under similar workloads.

## Dependencies

### Main Dependencies

- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - From main repository (via git dependency)
- **sinktools** - From main repository (via git dependency)
- **criterion** - Benchmarking framework

### Rationale for Separation

These dependencies were moved to this separate repository to:
- ✅ Reduce the main repository's dependency tree complexity
- ✅ Improve build times for the main repository
- ✅ Maintain better separation of concerns
- ✅ Enable focused performance testing without affecting core development
- ✅ Follow the team's modular architecture approach

## Repository Structure

```
.
├── Cargo.toml              # Workspace configuration
├── rust-toolchain.toml     # Rust toolchain specification
├── rustfmt.toml           # Code formatting configuration
├── clippy.toml            # Linting configuration
├── README.md              # This file
└── benches/
    ├── Cargo.toml         # Benchmark package configuration
    ├── README.md          # Benchmark-specific documentation
    ├── build.rs           # Build script
    └── benches/
        ├── *.rs           # Benchmark implementations
        ├── reachability_edges.txt      # Test data for reachability
        ├── reachability_reachable.txt  # Test data for reachability
        └── words_alpha.txt             # Word list (371KB)
```

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing benchmark patterns
4. Document the benchmark purpose and expected results

### Updating Dependencies

The benchmarks reference `dfir_rs` and `sinktools` from the main repository via git dependencies. When the main repository updates, you may need to:

1. Update your local cache: `cargo update`
2. Test benchmarks: `cargo bench -p benches`
3. Verify performance hasn't regressed

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydroflow repository

## Migration Information

This repository was created as part of a code organization initiative to separate benchmark code and dependencies from the main codebase. See the [BENCHMARK_REMOVAL.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_REMOVAL.md) file in the main repository for details about the migration.

## License

Apache-2.0

## Contributing

When contributing benchmarks:
- Follow the team's coding standards (see rustfmt.toml and clippy.toml)
- Ensure benchmarks are reproducible
- Document benchmark purpose and interpretation
- Include performance comparison data when possible
- Test benchmarks locally before submitting PRs

For more details on contributing, refer to the [CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md) in the main repository.
