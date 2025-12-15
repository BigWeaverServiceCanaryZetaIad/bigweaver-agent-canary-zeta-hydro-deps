# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

December 15, 2025

## Motivation

The benchmarks were moved to achieve the following goals:

1. **Reduce Build Dependencies**: Remove timely and differential-dataflow dependencies from the main repository's build process
2. **Improve Build Times**: Developers working on core Hydro functionality no longer need to compile these large dependencies
3. **Maintain Performance Testing**: Preserve the ability to run comparative performance tests between DFIR (Hydro) and timely/differential-dataflow implementations
4. **Separate Concerns**: Keep core implementation separate from benchmarking infrastructure

## Migrated Files

### Benchmark Files
The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`:

- `arithmetic.rs` - Arithmetic operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `upcase.rs` - String transformation benchmarks

### Data Files
The following test data files were also migrated:

- `reachability_edges.txt` - Graph edge data for reachability benchmarks
- `reachability_reachable.txt` - Expected reachability results

### Build Files
- `build.rs` - Build script for generating fork_join benchmark data

## Dependency Changes

### Source Repository (bigweaver-agent-canary-hydro-zeta)

**Removed from `benches/Cargo.toml`:**
```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

**Removed benchmark entries:**
```toml
[[bench]]
name = "arithmetic"
harness = false

[[bench]]
name = "fan_in"
harness = false

[[bench]]
name = "fan_out"
harness = false

[[bench]]
name = "fork_join"
harness = false

[[bench]]
name = "identity"
harness = false

[[bench]]
name = "join"
harness = false

[[bench]]
name = "reachability"
harness = false

[[bench]]
name = "upcase"
harness = false
```

### Destination Repository (bigweaver-agent-canary-zeta-hydro-deps)

**Added to `benches/Cargo.toml`:**
```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

**Cross-repository dependencies:**
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Repository Structure

### bigweaver-agent-canary-zeta-hydro-deps
```
bigweaver-agent-canary-zeta-hydro-deps/
├── .gitignore
├── Cargo.toml                 # Workspace configuration
├── README.md                  # Repository overview
├── MIGRATION.md              # This file
├── rust-toolchain.toml       # Rust version specification
├── clippy.toml               # Linter configuration
├── rustfmt.toml              # Formatter configuration
└── benches/
    ├── Cargo.toml            # Benchmark package configuration
    ├── README.md             # Benchmark documentation
    ├── build.rs              # Build script
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Running Performance Comparisons

### Prerequisites

1. Both repositories must be cloned in the same parent directory:
   ```
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Ensure Rust toolchain is installed (see `rust-toolchain.toml`)

### Running Benchmarks

From the `bigweaver-agent-canary-zeta-hydro-deps` repository:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability

# Generate detailed reports
cargo bench -- --verbose

# Save baseline for comparison
cargo bench -- --save-baseline baseline-name

# Compare against baseline
cargo bench -- --baseline baseline-name
```

### Viewing Results

Benchmark results are stored in `target/criterion/`:
- HTML reports with graphs
- Statistical analysis
- Performance comparisons

Open `target/criterion/report/index.html` in a browser to view detailed results.

## Verification Steps

To verify the migration was successful:

1. **Build Check**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build --release
   ```

2. **Benchmark Execution**:
   ```bash
   cargo bench --bench arithmetic
   cargo bench --bench reachability
   ```

3. **Main Repository Build**:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo build
   # Verify timely/differential are not in dependency tree
   cargo tree | grep -E "timely|differential"
   ```

4. **Cross-Repository References**:
   - Verify dfir_rs path reference works
   - Verify sinktools path reference works
   - Check that benchmarks can access DFIR operators

## Impact on Teams

### Development Team
- **Benefit**: Faster build times for main repository
- **Benefit**: Cleaner dependency tree
- **Action**: No changes needed for core development work

### Performance Engineering Team
- **Benefit**: Dedicated repository for performance testing
- **Benefit**: All comparison benchmarks in one place
- **Action**: Clone and use deps repository for performance comparisons

### CI/CD Team
- **Benefit**: Reduced build time in main CI pipeline
- **Benefit**: Can run performance tests separately
- **Action**: May need to add separate CI job for benchmark repository

## Maintenance Notes

1. **Syncing Changes**: If dfir_rs or sinktools interfaces change in the main repository, benchmarks may need updates
2. **Version Management**: Keep rust-toolchain.toml synchronized between repositories
3. **Dependency Updates**: Update timely/differential versions independently of main repository
4. **Documentation**: Keep benchmark documentation up-to-date as new benchmarks are added

## Related Documentation

- Main repository README: `../bigweaver-agent-canary-hydro-zeta/README.md`
- Benchmark README: `benches/README.md`
- Contributing guide: `../bigweaver-agent-canary-hydro-zeta/CONTRIBUTING.md`

## Future Considerations

1. Consider publishing benchmark results to a dashboard
2. Add automated performance regression detection
3. Expand benchmark suite to cover more operators
4. Create comparison reports between DFIR, Timely, and Differential implementations
5. Document performance characteristics and trade-offs

## Questions or Issues

For questions about:
- Benchmark implementation: See individual benchmark files
- Repository setup: See README.md
- Performance comparisons: Contact Performance Engineering team
- Migration process: Refer to this document
