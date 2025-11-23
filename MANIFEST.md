# Repository Manifest

Complete listing of files in the bigweaver-agent-canary-zeta-hydro-deps repository.

**Last Updated**: November 2025  
**Purpose**: Performance benchmarks for Hydro (dfir_rs) comparing with timely and differential-dataflow

## Root Directory

### Configuration Files

| File | Purpose | Type |
|------|---------|------|
| `Cargo.toml` | Workspace configuration and profiles | Configuration |
| `rust-toolchain.toml` | Rust toolchain specification (if present) | Configuration |
| `.gitignore` | Git ignore patterns | Configuration |

### Documentation Files

| File | Purpose | Lines |
|------|---------|-------|
| `README.md` | Main repository documentation | ~300 |
| `QUICKSTART.md` | Quick start guide | ~300 |
| `MANIFEST.md` | This file - complete file listing | ~200 |
| `LICENSE` | Apache-2.0 license | ~200 |

### Utility Scripts

| File | Purpose | Executable |
|------|---------|------------|
| `run_benchmarks.sh` | Run benchmarks with options | Yes |
| `run_comparison.sh` | Guided performance comparison workflow | Yes |

## benches/ Directory

### Configuration

| File | Purpose |
|------|---------|
| `benches/Cargo.toml` | Benchmark package configuration and dependencies |
| `benches/build.rs` | Build script (if needed for benchmark compilation) |
| `benches/README.md` | Detailed benchmark documentation |

### Benchmark Implementations (benches/benches/)

| File | Purpose | Lines | Data Size |
|------|---------|-------|-----------|
| `arithmetic.rs` | Pipeline arithmetic operations (20 sequential +1 ops) | 256 | - |
| `fan_in.rs` | Fan-in pattern (multiple sources to single sink) | ~120 | - |
| `fan_out.rs` | Fan-out pattern (single source to multiple sinks) | ~120 | - |
| `fork_join.rs` | Fork-join pattern (fan-out + fan-in) | ~130 | - |
| `identity.rs` | Identity/pass-through operations | ~220 | - |
| `join.rs` | Two-stream join operations | ~150 | - |
| `reachability.rs` | Graph reachability computation | ~386 | Uses data files |
| `upcase.rs` | String transformation (uppercase) | ~110 | - |

### Test Data Files (benches/benches/)

| File | Purpose | Size |
|------|---------|------|
| `reachability_edges.txt` | Graph edges for reachability benchmark | 533 KB |
| `reachability_reachable.txt` | Expected reachable nodes | 38 KB |

## File Statistics

### By Category

| Category | Count | Total Size |
|----------|-------|------------|
| Documentation | 4 | ~800 lines |
| Configuration | 2 | ~100 lines |
| Scripts | 2 | ~300 lines |
| Benchmark Code | 8 | ~1,500 lines |
| Test Data | 2 | ~571 KB |
| **Total** | **18** | **~2,700 lines + 571 KB data** |

### By Language/Type

| Type | Files | Purpose |
|------|-------|---------|
| Rust (`.rs`) | 8 | Benchmark implementations |
| TOML (`.toml`) | 2 | Configuration |
| Markdown (`.md`) | 4 | Documentation |
| Shell (`.sh`) | 2 | Utility scripts |
| Text (`.txt`) | 2 | Test data |

## Dependencies

### Direct Dependencies (from benches/Cargo.toml)

| Dependency | Version | Purpose |
|------------|---------|---------|
| `criterion` | 0.5.0 | Benchmarking framework |
| `dfir_rs` | git | Hydro dataflow implementation (main subject) |
| `differential-dataflow` | 0.13.0-dev.1 | Comparison baseline |
| `timely` | 0.13.0-dev.1 | Comparison baseline |
| `tokio` | 1.29.0 | Async runtime |
| `futures` | 0.3 | Async primitives |
| `rand` | 0.8.0 | Random data generation |
| `rand_distr` | 0.4.3 | Random distributions |
| `sinktools` | git | Hydro utilities |
| `nameof` | 1.0.0 | Name-of macro |
| `seq-macro` | 0.2.0 | Sequence macros |
| `static_assertions` | 1.0.0 | Compile-time assertions |

## Benchmark Coverage

### Implementation Variants per Benchmark

Each benchmark typically includes variants for:

1. **dfir_rs/compiled**: Compiled Hydro implementation
2. **dfir_rs/scheduled**: Scheduled Hydro implementation
3. **timely**: Timely dataflow implementation
4. **differential**: Differential dataflow implementation (for applicable benchmarks)
5. **raw/baseline**: Raw Rust implementation (theoretical minimum)

### Coverage Matrix

| Benchmark | dfir_rs | timely | differential | raw |
|-----------|---------|--------|--------------|-----|
| arithmetic | ✓ | ✓ | - | ✓ |
| fan_in | ✓ | ✓ | - | - |
| fan_out | ✓ | ✓ | - | - |
| fork_join | ✓ | ✓ | - | - |
| identity | ✓ | ✓ | - | ✓ |
| join | ✓ | - | ✓ | - |
| reachability | ✓ | - | ✓ | - |
| upcase | ✓ | ✓ | - | - |

## Generated Artifacts

These files are generated when running benchmarks (not in repository):

### Build Artifacts
- `target/` - Compiled binaries and intermediate files
- `Cargo.lock` - Dependency lock file (may be gitignored)

### Benchmark Results
- `target/criterion/` - Criterion output directory
  - `target/criterion/report/` - HTML reports
  - `target/criterion/*/` - Individual benchmark results
  - `target/criterion/*/base/` - Baseline measurements

### Report Files (in target/criterion/)
- `index.html` - Main report index
- `*/report/index.html` - Individual benchmark reports
- `*/report/violin.svg` - Performance distribution visualizations
- `*/report/pdf.svg` - PDF plots
- Various `.json` files with raw benchmark data

## Repository Metadata

### Git Configuration
- `.git/` - Git repository data
- `.gitignore` - Ignore patterns for build artifacts and IDE files

### GitHub Configuration (if present)
- `.github/workflows/` - CI/CD workflow definitions
- `.github/ISSUE_TEMPLATE/` - Issue templates
- `.github/PULL_REQUEST_TEMPLATE.md` - PR template

## Historical Context

### Origin
Files moved from `bigweaver-agent-canary-hydro-zeta/benches/` in November 2025.

### Original Location
- **Source Repository**: bigweaver-agent-canary-hydro-zeta
- **Original Path**: `benches/benches/*.rs`
- **Migration Date**: November 2025
- **Reason**: Dependency separation

### Changes from Original
1. **Cargo.toml**: Updated to use git dependencies instead of path dependencies
2. **Documentation**: Added comprehensive documentation (README.md, QUICKSTART.md, MANIFEST.md)
3. **Scripts**: Added run_benchmarks.sh and run_comparison.sh
4. **Structure**: Created workspace structure with benches as member

### Preserved
- All benchmark implementations unchanged
- Test data files unchanged
- Benchmark methodology unchanged
- Performance characteristics unchanged

## File Purposes

### Documentation Strategy

| File | Audience | Purpose |
|------|----------|---------|
| `README.md` | All users | Comprehensive overview, architecture, usage |
| `QUICKSTART.md` | New users | Fast onboarding, common tasks |
| `benches/README.md` | Benchmark users | Detailed benchmark documentation |
| `MANIFEST.md` | Maintainers | Complete file inventory |

### Script Strategy

| Script | Use Case | Interaction |
|--------|----------|-------------|
| `run_benchmarks.sh` | General benchmarking | Command-line arguments |
| `run_comparison.sh` | Before/after comparison | Interactive prompts |

## Maintenance

### Regular Updates Needed

- **Documentation**: Update when adding benchmarks or changing structure
- **MANIFEST.md**: Update when adding/removing files
- **Dependencies**: Keep benches/Cargo.toml dependencies current
- **Scripts**: Update for new workflow patterns

### Version Control

- **Benchmark Code**: Version controlled, track all changes
- **Test Data**: Version controlled, rarely changes
- **Documentation**: Version controlled, update with code changes
- **Build Artifacts**: Gitignored, regenerated on each build
- **Benchmark Results**: Typically gitignored, optionally tracked for history

## Integration Points

### With Main Repository
- **Dependencies**: References dfir_rs and sinktools via git
- **Development**: Can use local paths for development
- **Release**: Coordinates with main repository releases

### With CI/CD
- **Build**: Standard cargo build commands
- **Test**: `cargo bench` for benchmark execution
- **Reports**: Generated HTML can be published to GitHub Pages

## Size Summary

### Code
- **Benchmark implementations**: ~1,500 lines of Rust
- **Documentation**: ~800 lines of Markdown
- **Scripts**: ~300 lines of Shell
- **Configuration**: ~100 lines of TOML
- **Total**: ~2,700 lines

### Data
- **Test data files**: 571 KB
- **Generated reports**: Varies (typically 1-5 MB)
- **Build artifacts**: Varies (typically 100+ MB)

## Contributing

When adding files to this repository:

1. **Update this MANIFEST.md** with new file details
2. **Document purpose** in appropriate README
3. **Add to .gitignore** if generated/temporary
4. **Update scripts** if new workflow needed
5. **Test thoroughly** before committing

---

**Note**: This manifest reflects the repository structure as of the migration from bigweaver-agent-canary-hydro-zeta. Keep this file updated as the repository evolves.
