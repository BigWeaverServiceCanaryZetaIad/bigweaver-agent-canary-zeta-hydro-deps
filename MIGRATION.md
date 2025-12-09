# Migration History

## Benchmark Migration from Main Repository

**Date**: December 2025

### Background

Performance benchmarks that compare Hydro with external dataflow frameworks (timely-dataflow and differential-dataflow) were originally part of the main bigweaver-agent-canary-hydro-zeta repository. To improve dependency management and reduce build complexity, these benchmarks have been migrated to this dedicated repository.

### Rationale

1. **Dependency Isolation**: The main Hydro repository no longer needs to carry timely and differential-dataflow as dependencies, reducing dependency bloat
2. **Faster Builds**: Developers working on core Hydro functionality benefit from faster build times without benchmark dependencies
3. **Modular Architecture**: Separating benchmarks allows for independent versioning and maintenance
4. **Performance Testing**: Maintains full ability to run comprehensive performance comparisons through Git dependencies

### Migrated Components

#### Benchmarks (`benches/`)

All benchmark implementations that depend on timely or differential-dataflow:

- `arithmetic.rs`: Basic arithmetic operations benchmark
- `fan_in.rs`: Fan-in pattern benchmark
- `fan_out.rs`: Fan-out pattern benchmark
- `fork_join.rs`: Fork-join parallel pattern benchmark
- `futures.rs`: Async/await pattern benchmark
- `identity.rs`: Identity transformation benchmark
- `join.rs`: Stream join benchmark
- `micro_ops.rs`: Micro-operations performance benchmark
- `reachability.rs`: Graph reachability algorithm benchmark
- `symmetric_hash_join.rs`: Hash join implementation benchmark
- `upcase.rs`: String transformation benchmark
- `words_diamond.rs`: Diamond pattern word processing benchmark

#### Supporting Files

- `benches/Cargo.toml`: Benchmark dependencies configuration
- `benches/build.rs`: Build script for generating benchmark code
- `benches/README.md`: Benchmark-specific documentation
- Data files: `reachability_edges.txt`, `reachability_reachable.txt`, `words_alpha.txt`

#### Configuration Files

- `Cargo.toml`: Workspace configuration (created for this repository)
- `rustfmt.toml`: Code formatting configuration (copied from main repo)
- `clippy.toml`: Linting configuration (copied from main repo)
- `rust-toolchain.toml`: Rust toolchain version (copied from main repo)

### Changes to Main Repository

The following were removed from bigweaver-agent-canary-hydro-zeta:

1. **Removed**: `benches/` directory and all its contents
2. **Removed**: `benches` from workspace members in root `Cargo.toml`
3. **Removed**: Benchmark workflow (`.github/workflows/benchmark.yml`)
4. **Updated**: `CONTRIBUTING.md` to reference this repository for benchmarks
5. **Removed**: Benchmark history links from `.github/gh-pages/index.md`

### Dependency Management

#### Git Dependencies

Benchmarks now use Git dependencies to pull Hydro components:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", version = "^0.0.1" }
```

This ensures benchmarks always test against the current version of Hydro while keeping the dependencies separate.

#### External Dependencies

The following external dependencies remain in this repository:
- `timely-master` (timely-dataflow)
- `differential-dataflow-master`
- Standard benchmark dependencies (`criterion`, `rand`, etc.)

### Running Benchmarks Post-Migration

Users can continue to run benchmarks with the same commands:

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

### Testing Against Local Changes

For development, benchmarks can be run against a local Hydro checkout:

1. Clone both repositories side-by-side
2. Modify `benches/Cargo.toml` to use path dependencies:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```
3. Run benchmarks as usual

### Verification

#### Confirmed Removals from Main Repository

- ✅ No `timely` or `differential-dataflow` dependencies in main repository's `Cargo.toml` files
- ✅ No `timely` or `differential-dataflow` packages in main repository's `Cargo.lock`
- ✅ Benchmark code and data files removed from main repository
- ✅ Benchmark workflow removed from CI/CD

#### Confirmed Additions to This Repository

- ✅ All benchmark files present and functional
- ✅ Workspace configuration created
- ✅ Git dependencies configured for Hydro components
- ✅ Documentation updated with migration information
- ✅ Configuration files (rustfmt, clippy, rust-toolchain) in place

### Related PRs

This migration is part of a coordinated effort to improve the Hydro project's architecture:

- **Main Repository PR**: Removal of benchmark dependencies and files
- **Deps Repository PR**: Addition of benchmarks with Git dependencies

Merge order: The removal PR in the main repository should be merged AFTER this repository is set up to ensure continuity of benchmark capability.

### Future Considerations

1. **CI/CD Integration**: Consider setting up automated benchmark runs on schedule or pull request triggers
2. **Benchmark History**: Consider implementing benchmark result tracking similar to the previous setup
3. **Additional Benchmarks**: New benchmarks comparing Hydro with external frameworks should be added to this repository
4. **Version Pinning**: For reproducible benchmarks, consider pinning to specific Hydro commits using Git revision specifiers

### Contact

For questions about this migration or the benchmarks, please refer to the main Hydro repository's CONTRIBUTING.md or open an issue in the appropriate repository.
