# Benchmark Repository Setup

This document outlines the setup and verification of the bigweaver-agent-canary-zeta-hydro-deps repository.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── .github/
│   └── workflows/
│       └── ci.yml                    # CI configuration for automated testing
├── benches/
│   ├── benches/
│   │   ├── arithmetic.rs              # Pipeline and dataflow arithmetic benchmarks
│   │   ├── fan_in.rs                  # Fan-in pattern benchmarks
│   │   ├── fan_out.rs                 # Fan-out pattern benchmarks
│   │   ├── fork_join.rs               # Fork-join pattern benchmarks
│   │   ├── identity.rs                # Identity operation benchmarks
│   │   ├── join.rs                    # Join operation benchmarks
│   │   ├── reachability.rs            # Graph reachability computation benchmarks
│   │   ├── reachability_edges.txt     # Test data for reachability benchmark
│   │   ├── reachability_reachable.txt # Expected results for reachability benchmark
│   │   ├── upcase.rs                  # String uppercase transformation benchmarks
│   │   └── .gitignore                 # Ignores generated fork_join_*.hf files
│   ├── Cargo.toml                     # Benchmark dependencies and configuration
│   ├── build.rs                       # Build script for fork_join benchmark generation
│   └── README.md                      # Benchmark-specific documentation
├── Cargo.toml                         # Workspace configuration
├── README.md                          # Repository overview
├── LICENSE                            # Apache 2.0 license
├── .gitignore                         # Git ignore patterns
├── clippy.toml                        # Clippy configuration
├── rust-toolchain.toml                # Rust toolchain specification
└── rustfmt.toml                       # Code formatting configuration
```

## Setup Complete

All required components have been set up:

### ✅ Benchmark Files
- All 8 benchmark source files moved from main repository
- Test data files for reachability benchmark included
- Build script for generating fork_join variants

### ✅ Configuration Files
- **Cargo.toml (workspace)**: Workspace configuration with proper profile settings
- **benches/Cargo.toml**: All dependencies including timely and differential-dataflow
- **rust-toolchain.toml**: Rust 1.91.1 with required components
- **rustfmt.toml**: Code formatting standards
- **clippy.toml**: Linting configuration
- **.gitignore**: Proper ignore patterns for build artifacts

### ✅ Dependencies

#### Core Dependencies (dev-dependencies in benches/Cargo.toml):
- `timely` (timely-master 0.13.0-dev.1): For dataflow computation
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1): For incremental computation
- `dfir_rs`: Core DFIR framework (git dependency)
- `sinktools`: Utility tools (git dependency)
- `criterion`: Benchmarking framework with async and HTML reports
- Supporting libraries: futures, rand, tokio, etc.

### ✅ CI/CD Configuration
- GitHub Actions workflow for continuous integration
- Automated linting with clippy
- Format checking with rustfmt
- Build verification for all benchmarks
- Optional benchmark execution on workflow dispatch

### ✅ Documentation
- README.md: Overview and usage instructions
- benches/README.md: Specific benchmark documentation
- BENCHMARKS_MIGRATION.md: In main repository, explains the migration

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench
```

### Run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

### Build without running:
```bash
cargo build --benches --release
```

### Check compilation:
```bash
cargo check --all-targets
```

## Verification Commands

### Verify all benchmarks are configured:
```bash
cargo metadata --format-version 1 | grep '"name":"benches"' -A 100 | grep '"bench"'
```

### List all benchmark files:
```bash
ls -l benches/benches/*.rs
```

### Verify dependencies:
```bash
cargo tree -p benches
```

## Development Workflow

### Testing local changes from main repository:

1. Edit `benches/Cargo.toml` to use path dependencies:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

2. Run benchmarks to test changes

3. Revert to git dependencies before committing

### Adding new benchmarks:

1. Add the benchmark file to `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`:
```toml
[[bench]]
name = "new_benchmark"
harness = false
```

3. Verify it compiles: `cargo check --benches`
4. Run it: `cargo bench --bench new_benchmark`

## Code Quality Checks

### Format code:
```bash
cargo fmt
```

### Check formatting:
```bash
cargo fmt -- --check
```

### Run linter:
```bash
cargo clippy --workspace -- -D warnings
```

## Next Steps

The repository is fully set up and ready for use. The benchmarks can be run independently to measure performance of the Hydro framework against timely and differential-dataflow implementations.

To integrate with CI/CD:
1. Commit and push the changes
2. The CI workflow will automatically run on pull requests and pushes to main
3. Benchmarks will run on manual workflow dispatch

## Related Documentation

- [Main repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Migration documentation](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARKS_MIGRATION.md)
