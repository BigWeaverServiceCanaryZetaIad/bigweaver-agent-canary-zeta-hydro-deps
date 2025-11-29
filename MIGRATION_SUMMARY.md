# Benchmark Migration Summary

This document summarizes the recovery and migration of timely-dataflow and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this repository.

## Background

The benchmarks were removed from the main repository in commit `b161bc10` ("chore(benches): remove timely/differential-dataflow dependencies and benchmarks") to eliminate dependencies on timely-dataflow and differential-dataflow packages from the main codebase.

## What Was Recovered

### Files Recovered from Commit b161bc10^

All benchmark-related files that existed before the removal commit were recovered:

#### Core Benchmark Package Files
- `benches/Cargo.toml` - Package configuration with dependencies and benchmark targets
- `benches/README.md` - Basic usage instructions
- `benches/build.rs` - Build script for code generation

#### Benchmark Implementations (15 files)
- `benches/benches/.gitignore` - Ignore generated files
- `benches/benches/arithmetic.rs` - Arithmetic operation benchmarks
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Futures integration benchmarks
- `benches/benches/identity.rs` - Identity transformation benchmarks
- `benches/benches/join.rs` - Join operation benchmarks
- `benches/benches/micro_ops.rs` - Micro-operation benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/reachability_edges.txt` - Test data for reachability (55,008 lines)
- `benches/benches/reachability_reachable.txt` - Expected results (7,855 lines)
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/upcase.rs` - String uppercase benchmarks
- `benches/benches/words_alpha.txt` - English word list (370,104 lines)
- `benches/benches/words_diamond.rs` - Word processing diamond pattern benchmarks

#### Total Recovered
- 19 source and data files
- ~435,649 lines of code and data

### Files Not Migrated

The following files were removed in the same commit but are not part of the benchmark code itself and were intentionally not migrated:

- `.github/workflows/benchmark.yml` - CI/CD workflow (specific to main repo's infrastructure)
- `.github/gh-pages/index.md` - Documentation page reference (already removed)
- `CONTRIBUTING.md` - Documentation change (already updated)

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps (This Repository)

1. **Created workspace configuration** (`Cargo.toml`)
   - Set up Cargo workspace with benches as a member
   - Configured workspace-level settings (edition, license, lints, profiles)
   - Matches configuration from main repository

2. **Updated benchmark paths** (`benches/Cargo.toml`)
   - Changed `dfir_rs` path from `../dfir_rs` to `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
   - Changed `sinktools` path from `../sinktools` to `../../bigweaver-agent-canary-hydro-zeta/sinktools`
   - Preserved all other dependencies and benchmark target configurations

3. **Created documentation**
   - `README.md` - Overview of repository and basic benchmark usage
   - `BENCHMARK_GUIDE.md` - Comprehensive guide for running and understanding benchmarks
   - `MIGRATION_SUMMARY.md` - This document

### In bigweaver-agent-canary-hydro-zeta (Main Repository)

The main repository was already cleaned by commit `b161bc10`:

- ✅ Removed `benches` from workspace members in `Cargo.toml`
- ✅ Removed all benchmark files and directories
- ✅ Removed benchmark references from `CONTRIBUTING.md`
- ✅ Removed benchmark workflow and documentation

**Note**: The main repository's `Cargo.lock` may still contain stale entries for the benches package and timely/differential-dataflow dependencies. These entries are harmless but will be cleaned up on the next `cargo update` run.

## Dependencies

### Preserved Dependencies

The benchmarks maintain their original dependencies:

- **timely-master** (0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework
- **criterion** (0.5.0) - Benchmarking framework with HTML reports
- **dfir_rs** - From main repository (via relative path)
- **sinktools** - From main repository (via relative path)
- **futures**, **rand**, **rand_distr**, **tokio** - Supporting libraries

### Cross-Repository Dependencies

The benchmarks depend on two crates from the main repository:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

This requires both repositories to be cloned at the same directory level:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Verification

### Structure Verification
```bash
$ tree -L 3 -I target bigweaver-agent-canary-zeta-hydro-deps
.
├── Cargo.toml
├── README.md
├── BENCHMARK_GUIDE.md
├── MIGRATION_SUMMARY.md
└── benches
    ├── Cargo.toml
    ├── README.md
    ├── benches
    │   ├── .gitignore
    │   ├── arithmetic.rs
    │   ├── fan_in.rs
    │   ├── fan_out.rs
    │   ├── fork_join.rs
    │   ├── futures.rs
    │   ├── identity.rs
    │   ├── join.rs
    │   ├── micro_ops.rs
    │   ├── reachability.rs
    │   ├── reachability_edges.txt
    │   ├── reachability_reachable.txt
    │   ├── symmetric_hash_join.rs
    │   ├── upcase.rs
    │   ├── words_alpha.txt
    │   └── words_diamond.rs
    └── build.rs
```

### Dependency Verification

Main repository no longer has timely/differential-dataflow in active Cargo.toml files:
```bash
$ cd bigweaver-agent-canary-hydro-zeta
$ find . -name "Cargo.toml" -not -path "./target/*" -exec grep -l "timely\|differential-dataflow" {} \;
# (no output - clean)
```

### Functional Verification

The benchmarks can be run with:
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench arithmetic
```

## Performance Comparison Capability

The migration preserves the ability to run performance comparisons:

1. **Before/After Comparisons**: Use Criterion's baseline feature to compare performance across code changes
2. **Framework Comparisons**: Many benchmarks include implementations in multiple frameworks (raw, dfir, timely)
3. **HTML Reports**: Criterion generates detailed HTML reports with graphs and statistics

Example workflow:
```bash
# Establish baseline
cargo bench -p benches -- --save-baseline before

# Make changes to dfir_rs in main repository

# Compare performance
cargo bench -p benches -- --baseline before
```

## Benefits of This Migration

1. **Dependency Isolation**: Main repository no longer depends on timely/differential-dataflow
2. **Preserved Benchmarks**: All benchmark functionality is retained and accessible
3. **Performance Testing**: Ability to run performance comparisons is maintained
4. **Clear Separation**: Benchmarks that require external dataflow frameworks are clearly separated
5. **Independent Versioning**: Benchmarks can evolve independently from the main codebase

## Future Considerations

### CI/CD Integration

To integrate these benchmarks into CI/CD:

1. Create a `.github/workflows/benchmark.yml` workflow in this repository
2. Configure it to run on:
   - Push to main branches
   - Pull requests with `[ci-bench]` tag
   - Scheduled runs (e.g., daily)
3. Set up GitHub Pages to publish benchmark results
4. Configure cross-repository triggers if benchmarks should run on main repo changes

### Maintenance

- Keep dfir_rs and sinktools paths in sync if repository structure changes
- Update timely/differential-dataflow versions as needed
- Add new benchmarks to this repository for code that depends on these frameworks
- Consider adding performance regression tests based on benchmark results

## References

- Original removal commit: `b161bc10` in bigweaver-agent-canary-hydro-zeta
- Wordlist source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Criterion documentation: https://bheisler.github.io/criterion.rs/book/
