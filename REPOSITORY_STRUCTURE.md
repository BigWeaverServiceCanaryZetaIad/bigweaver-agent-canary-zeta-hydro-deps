# Repository Relationship and Dependencies

## Overview

This repository (`bigweaver-agent-canary-zeta-hydro-deps`) contains benchmark code that depends on the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`). This document explains the relationship and dependency structure.

## Repository Structure

```
/projects/
├── bigweaver-agent-canary-hydro-zeta/          # Main Hydro/DFIR repository
│   ├── dfir_rs/                                 # Core DFIR runtime
│   ├── sinktools/                               # Utilities used by benchmarks
│   ├── hydro_lang/                              # High-level Hydro language
│   └── ... (other core packages)
│
└── bigweaver-agent-canary-zeta-hydro-deps/     # This repository - benchmarks
    └── benches/                                 # Benchmark code
        ├── Cargo.toml                           # References dfir_rs and sinktools
        └── benches/                             # Benchmark source files
            ├── reachability.rs                  # Uses timely, differential, dfir_rs
            ├── identity.rs
            └── ...
```

## Dependency Flow

```
bigweaver-agent-canary-zeta-hydro-deps/benches
    │
    ├──> dfir_rs (from main repo)
    ├──> sinktools (from main repo)
    ├──> timely-master (v0.13.0-dev.1)
    └──> differential-dataflow-master (v0.13.0-dev.1)
```

### Path References

In `benches/Cargo.toml`:

```toml
[dev-dependencies]
# References to main repository (relative path)
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }

# External comparison frameworks
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

## Why This Structure?

### Benefits of Separation

1. **Reduced Build Dependencies**: The main Hydro repository doesn't need timely/differential-dataflow
2. **Clear Purpose**: Performance comparison code is explicitly separate
3. **Independent Versioning**: Benchmark dependencies can be updated independently
4. **Faster CI**: Main repository CI doesn't build comparison frameworks

### Maintaining Connection

- Benchmarks still test Hydro/DFIR code through path dependencies
- Performance comparison remains functional and up-to-date
- Both repositories can be developed in parallel

## Working with Both Repositories

### Initial Setup

```bash
# Clone both repositories side-by-side
cd /projects/
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Verify structure
ls -l
# Should show:
# bigweaver-agent-canary-hydro-zeta/
# bigweaver-agent-canary-zeta-hydro-deps/
```

### Development Workflow

#### Working on Main Hydro Code
```bash
cd bigweaver-agent-canary-hydro-zeta
# Make changes to dfir_rs, hydro_lang, etc.
cargo test
cargo build
```

#### Testing Performance Impact
```bash
cd ../bigweaver-agent-canary-zeta-hydro-deps
# Benchmarks will automatically use your local changes
cargo bench -p benches --bench reachability
```

#### Updating Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches/benches
# Edit benchmark files
# They can use latest APIs from local dfir_rs
```

## CI/CD Integration

### Main Repository CI
- Builds and tests core Hydro/DFIR functionality
- No timely/differential-dataflow dependencies
- Fast feedback loop for core development

### Benchmark Repository CI
- Checks out both repositories
- Builds benchmarks with all frameworks
- Runs performance comparisons
- Publishes results to gh-pages

### GitHub Actions Setup

In `bigweaver-agent-canary-zeta-hydro-deps/.github/workflows/`:

```yaml
- name: Checkout main hydro repository
  uses: actions/checkout@v4
  with:
    repository: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
    path: bigweaver-agent-canary-hydro-zeta
```

This ensures the benchmark CI has access to required dependencies.

## Version Compatibility

### Keeping Benchmarks in Sync

1. **Breaking Changes in dfir_rs**: Update benchmark code when APIs change
2. **New Features**: Add new benchmarks to showcase improvements
3. **Performance Regressions**: Benchmarks help catch unintended slowdowns

### Dependency Versions

- **dfir_rs/sinktools**: Always use latest from main repository (path dependency)
- **timely/differential-dataflow**: Pin to specific versions for fair comparison
- **Other dependencies**: Keep compatible with both repositories

## Troubleshooting

### "Cannot find dfir_rs"
- Ensure main repository is cloned at `../bigweaver-agent-canary-hydro-zeta`
- Check path in `benches/Cargo.toml`

### "Compilation errors in dfir_rs"
- Update your local clone of the main repository
- Benchmark APIs might need updating after changes

### "Missing sinktools"
- Verify sinktools exists in main repository
- Path should be `../../bigweaver-agent-canary-hydro-zeta/sinktools`

## Future Considerations

### Publishing Benchmarks
Currently benchmarks use path dependencies. If publishing to crates.io:
- Would need to use published versions of dfir_rs
- Or keep as dev-only benchmark repository

### Alternative Repository Layouts
Could use:
- Git submodules
- Cargo workspace across repositories
- Monorepo with feature flags

Current separate-repository approach chosen for simplicity and clarity.

## Summary

This repository structure provides:
- ✅ Clear separation of concerns
- ✅ Maintained performance comparison capability
- ✅ Reduced dependencies in main repository
- ✅ Flexible independent development
- ✅ Automated CI/CD for both repositories

For questions or issues with the repository relationship, see MIGRATION.md or open an issue.
