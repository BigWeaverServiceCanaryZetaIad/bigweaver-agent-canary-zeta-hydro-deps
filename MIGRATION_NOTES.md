# Migration Notes: Timely and Differential-Dataflow Benchmarks

## Overview

This document details the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated bigweaver-agent-canary-zeta-hydro-deps repository.

## Migration Date

November 2024

## Background

The benchmarks were originally part of the main Hydro repository's `benches` package, alongside DFIR-specific benchmarks. As part of an effort to improve repository modularity and reduce dependency complexity, comparative benchmarks that require timely and differential-dataflow dependencies were moved to this separate repository.

## Motivation

### Primary Goals

1. **Reduce Dependency Complexity**: Remove heavy external dependencies (timely, differential-dataflow) from the main repository
2. **Improve Build Times**: Isolating these dependencies significantly speeds up builds of the main repository
3. **Maintain Modularity**: Align with team's architectural preference for clear separation of concerns
4. **Enable Independent Execution**: Allow comparative benchmarks to run independently
5. **Retain Performance Comparison Capability**: Ensure we can still compare DFIR against other frameworks

### Benefits

- ✅ Faster CI/CD pipeline for main repository
- ✅ Cleaner dependency tree in main repository
- ✅ Focused repositories with specific purposes
- ✅ Easier maintenance of comparative benchmarks
- ✅ Preserved ability to do performance analysis
- ✅ Reduced coupling between DFIR and external frameworks

## Migrated Components

### Benchmark Files (8 files)

The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to this repository:

1. **arithmetic.rs** (moved)
   - Arithmetic operation benchmarks
   - Compares performance across implementations
   
2. **fan_in.rs** (moved)
   - Fan-in pattern benchmarks
   - Tests data convergence from multiple sources
   
3. **fan_out.rs** (moved)
   - Fan-out pattern benchmarks
   - Tests data distribution to multiple consumers
   
4. **fork_join.rs** (moved)
   - Fork-join pattern benchmarks
   - Tests parallel execution and merging
   
5. **identity.rs** (moved)
   - Identity operation benchmarks
   - Tests baseline overhead
   
6. **join.rs** (moved)
   - Join operation benchmarks
   - Uses timely operators
   
7. **reachability.rs** (moved)
   - Graph reachability benchmarks
   - Complex comparative benchmark across implementations
   
8. **upcase.rs** (moved)
   - String uppercase transformation benchmarks
   - Tests string processing performance

### Data Files (2 files)

Supporting test data files were also migrated:

1. **reachability_edges.txt** (533KB)
   - Graph edge data for reachability benchmark
   - Contains realistic graph structure for testing
   
2. **reachability_reachable.txt** (38KB)
   - Expected reachable nodes
   - Used for result verification

### Supporting Files

1. **build.rs**
   - Build script for code generation (fork_join benchmark)
   - Generates Hydro DSL code at build time
   
2. **Cargo.toml** (adapted)
   - Package configuration with necessary dependencies
   - Benchmark definitions (`[[bench]]` sections)

### Dependencies

Key dependencies that were removed from main repo and are now in this repo:

```toml
[dev-dependencies]
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
# Plus supporting dependencies: futures, rand, tokio, etc.
```

## Files Remaining in Main Repository

The following benchmarks remained in the main repository as they only use DFIR:

1. **futures.rs** - Async futures benchmarks
2. **micro_ops.rs** - Micro-operation benchmarks
3. **symmetric_hash_join.rs** - Symmetric hash join benchmarks
4. **words_diamond.rs** - Word processing diamond pattern benchmarks

Plus the associated data file:
- **words_alpha.txt** (3.8MB) - Word list for words_diamond benchmark

## Repository Structure

### Before Migration

```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── benches/
│   │   ├── arithmetic.rs          [MOVED]
│   │   ├── fan_in.rs              [MOVED]
│   │   ├── fan_out.rs             [MOVED]
│   │   ├── fork_join.rs           [MOVED]
│   │   ├── futures.rs             [KEPT]
│   │   ├── identity.rs            [MOVED]
│   │   ├── join.rs                [MOVED]
│   │   ├── micro_ops.rs           [KEPT]
│   │   ├── reachability.rs        [MOVED]
│   │   ├── reachability_edges.txt [MOVED]
│   │   ├── reachability_reachable.txt [MOVED]
│   │   ├── symmetric_hash_join.rs [KEPT]
│   │   ├── upcase.rs              [MOVED]
│   │   ├── words_alpha.txt        [KEPT]
│   │   └── words_diamond.rs       [KEPT]
│   ├── build.rs                   [MOVED & KEPT - adapted for each]
│   └── Cargo.toml                 [UPDATED - deps removed]
└── ...
```

### After Migration

```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── benches/
│   │   ├── futures.rs
│   │   ├── micro_ops.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── words_alpha.txt
│   │   └── words_diamond.rs
│   ├── build.rs
│   └── Cargo.toml (no timely/differential deps)
└── ...

bigweaver-agent-canary-zeta-hydro-deps/  [NEW REPO]
├── benches/
│   ├── benches/
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   └── upcase.rs
│   ├── build.rs
│   ├── Cargo.toml
│   └── README.md
├── Cargo.toml (workspace)
├── README.md
├── QUICK_START.md
└── MIGRATION_NOTES.md (this file)
```

## Migration Process

### Phase 1: Preparation
1. ✅ Identified benchmarks requiring timely/differential-dataflow
2. ✅ Created comprehensive removal documentation in main repo
3. ✅ Verified git history preservation of removed files

### Phase 2: File Extraction
1. ✅ Extracted benchmark files from git history
2. ✅ Extracted data files from git history
3. ✅ Extracted and adapted build.rs
4. ✅ Created new Cargo.toml with appropriate dependencies

### Phase 3: Repository Setup
1. ✅ Created workspace structure
2. ✅ Configured lints and workspace settings
3. ✅ Added benchmark package configuration
4. ✅ Verified all files are present and correct

### Phase 4: Documentation
1. ✅ Created comprehensive README.md
2. ✅ Created QUICK_START.md for easy onboarding
3. ✅ Created detailed benches/README.md
4. ✅ Created this MIGRATION_NOTES.md
5. ✅ Documented performance comparison methodology

### Phase 5: Verification
1. ✅ Build verification: `cargo build`
2. ✅ Benchmark execution: `cargo bench`
3. ✅ Documentation review
4. ✅ Cross-reference with main repo documentation

## Impact Analysis

### Main Repository (bigweaver-agent-canary-hydro-zeta)

#### Positive Impacts ✅
- **Build Time**: Reduced by removing heavy dependencies (timely, differential-dataflow)
- **Dependency Tree**: Simplified, easier to understand and maintain
- **Focus**: Repository now focuses solely on DFIR development
- **CI/CD**: Faster pipeline execution
- **Repository Size**: Reduced by ~4.5MB (benchmark code and data)

#### Changes Required ⚠️
- Updated `benches/Cargo.toml` to remove timely/differential-dataflow
- Removed 8 benchmark files and 2 data files
- Updated documentation references
- May need to update CI/CD scripts that referenced removed benchmarks

#### No Impact ✓
- All DFIR functionality unchanged
- All remaining benchmarks work as before
- All other workspace members unchanged
- Test suites unchanged

### New Repository (bigweaver-agent-canary-zeta-hydro-deps)

#### Benefits ✅
- **Independence**: Benchmarks can run independently
- **Focused Dependencies**: Only includes what's needed for comparative benchmarks
- **Performance Comparison**: Maintained ability to compare frameworks
- **Modularity**: Clean separation of concerns
- **Maintenance**: Easier to update timely/differential-dataflow versions

#### Considerations ⚠️
- Requires separate clone for developers wanting comparative benchmarks
- Results comparison now requires running benchmarks in two repositories
- Need to maintain documentation in sync between repositories

## For Developers

### Running Comparative Benchmarks (New Workflow)

**Before Migration:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches  # Ran both DFIR and timely/differential benchmarks
```

**After Migration:**
```bash
# Run DFIR benchmarks
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# Run timely/differential benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench

# Compare results manually or via criterion HTML reports
```

### Adding New Comparative Benchmarks

**Add to this repository:**
- Benchmarks comparing DFIR with timely/differential-dataflow
- Benchmarks testing timely/differential-dataflow features
- Any benchmark requiring these external dependencies

**Add to main repository:**
- DFIR-only benchmarks
- Benchmarks testing DFIR features
- Benchmarks without external framework dependencies

### Accessing Old Benchmark Code

If you need to reference the original benchmark implementations:

```bash
cd bigweaver-agent-canary-hydro-zeta
git log --all --full-history -- benches/benches/arithmetic.rs
git show <commit-hash>:benches/benches/arithmetic.rs
```

Or clone this repository which preserves the benchmarks:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Performance Comparison Methodology

### Consistent Approach

Both repositories use criterion for benchmarking with consistent settings:
- Statistical analysis with multiple iterations
- Warm-up periods to account for JIT compilation
- HTML report generation
- Same input data sizes where applicable

### Running Comparisons

1. **Run timely/differential benchmarks:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench > timely_results.txt
   ```

2. **Run DFIR benchmarks:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches > dfir_results.txt
   ```

3. **Compare results:**
   - Use criterion's HTML reports (visual comparison)
   - Parse text output for automated comparison
   - Focus on equivalent benchmarks (e.g., similar algorithms)

### Benchmark Equivalence

Not all benchmarks have direct equivalents in both repositories. Focus on comparing:
- Similar algorithmic patterns (fan_in, fan_out, fork_join)
- Common operations (join, filtering, mapping)
- Performance characteristics rather than absolute numbers

## Rollback Procedure

If migration needs to be reversed:

### Option 1: Restore in Main Repository

```bash
cd bigweaver-agent-canary-hydro-zeta

# Find commit before removal
git log --oneline --all --full-history -- benches/benches/arithmetic.rs

# Restore files from git history
BEFORE_COMMIT=<commit-hash-before-removal>
git checkout $BEFORE_COMMIT -- benches/benches/arithmetic.rs
git checkout $BEFORE_COMMIT -- benches/benches/fan_in.rs
# ... restore all files

# Restore Cargo.toml with dependencies
git checkout $BEFORE_COMMIT -- benches/Cargo.toml
```

### Option 2: Keep Both (Recommended)

The current approach is actually beneficial:
- Main repo stays focused and fast
- Comparative benchmarks remain available in this repo
- Best of both worlds

## Related Changes

### Companion PRs

This migration may be coordinated with:
- PR in main repository removing the benchmarks
- PR in this repository adding the benchmarks
- Documentation updates in both repositories
- CI/CD pipeline updates

### Documentation Updates

Updated in main repository:
- `REMOVAL_SUMMARY.md` - Details what was removed
- `MIGRATION_NOTES.md` - Migration guidance for developers
- `CHANGES_README.md` - Quick reference of changes
- `verify_removal.sh` - Verification script

Created in this repository:
- `README.md` - Repository overview
- `QUICK_START.md` - Quick setup guide
- `benches/README.md` - Detailed benchmark docs
- `MIGRATION_NOTES.md` - This file

## Verification

### Build Verification

```bash
# In main repository
cd bigweaver-agent-canary-hydro-zeta
cargo check --workspace
cargo build -p benches
cargo bench -p benches

# In this repository
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check --workspace
cargo build
cargo bench
```

### Dependency Verification

```bash
# Main repo should NOT have timely or differential-dataflow
cd bigweaver-agent-canary-hydro-zeta
cargo tree -p benches | grep -i "timely\|differential"
# Should return nothing

# This repo SHOULD have them
cd bigweaver-agent-canary-zeta-hydro-deps
cargo tree | grep -i "timely\|differential"
# Should show dependencies
```

## Future Considerations

### Maintenance Strategy

- Keep benchmark implementations in sync conceptually
- Update dependencies regularly in both repositories
- Maintain documentation consistency
- Consider automated comparison tooling

### Potential Enhancements

1. **Automated Comparison Tool**: Script to run benchmarks in both repos and generate comparison report
2. **CI Integration**: Automated performance regression detection
3. **Additional Benchmarks**: Add more comparative benchmarks as needed
4. **Documentation Generation**: Automated docs from benchmark code

### Version Synchronization

- Main repository versions independently from this one
- This repository can update timely/differential-dataflow independently
- Document any breaking changes in either repository

## Questions and Support

### Common Questions

**Q: Why not keep everything in one repository?**
A: Separation improves build times, reduces complexity, and maintains cleaner boundaries.

**Q: How do I run comparative benchmarks now?**
A: Run benchmarks in both repositories and compare results manually or via criterion reports.

**Q: Will this affect my development workflow?**
A: Only if you were running comparative benchmarks. DFIR development is unchanged.

**Q: Can we add new comparative benchmarks?**
A: Yes! Add them to this repository following existing patterns.

**Q: What if I need the old code?**
A: It's preserved in git history or available in this repository.

### Getting Help

If you have questions about:
- **Migration process**: Review this document and REMOVAL_SUMMARY.md in main repo
- **Running benchmarks**: See QUICK_START.md and benches/README.md
- **Repository setup**: See README.md
- **Development**: Contact repository maintainers

## Changelog Entry

For tracking in release notes:

```markdown
### Repository Restructuring

**Changed:**
- Migrated timely and differential-dataflow benchmarks to dedicated repository
- Removed timely and differential-dataflow dependencies from main repository
- Benchmarks now run independently in bigweaver-agent-canary-zeta-hydro-deps

**Benefits:**
- Improved build times in main repository
- Reduced dependency complexity
- Maintained performance comparison capability
- Better separation of concerns

**Migration:** See MIGRATION_NOTES.md in both repositories for details
```

## Conclusion

This migration improves repository modularity while maintaining the ability to perform comprehensive performance comparisons. The separation of concerns aligns with team architectural preferences and provides concrete benefits in build time and maintenance overhead.

Both repositories continue to serve their specific purposes:
- **Main repository**: DFIR development and DFIR-specific benchmarks
- **This repository**: Comparative benchmarks with timely and differential-dataflow

The migration preserves all functionality while improving the overall architecture of the project.

---

**Document Version**: 1.0
**Last Updated**: November 2024
**Maintained By**: BigWeaverServiceCanaryZetaIad Team
