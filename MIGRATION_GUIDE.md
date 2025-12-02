# Migration Guide: Timely/Differential Benchmarks

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) to this dedicated dependencies repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## What Was Moved

### Files Migrated

All files from the `benches/` directory:

**Configuration Files:**
- `benches/Cargo.toml` - Package and dependency configuration
- `benches/build.rs` - Build script
- `benches/README.md` - Benchmark documentation
- `benches/benches/.gitignore` - Git ignore rules for benchmark outputs

**Benchmark Files (12 total):**
- `benches/benches/arithmetic.rs` - Arithmetic operations benchmarks
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Futures-based operations
- `benches/benches/identity.rs` - Identity operations
- `benches/benches/join.rs` - Join operations
- `benches/benches/micro_ops.rs` - Micro-operations
- `benches/benches/reachability.rs` - Graph reachability algorithms
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join
- `benches/benches/upcase.rs` - String uppercase operations
- `benches/benches/words_diamond.rs` - Words diamond pattern

**Test Data Files (3 total):**
- `benches/benches/reachability_edges.txt` - Graph edges data (~55K lines)
- `benches/benches/reachability_reachable.txt` - Reachable nodes data (~8K lines)
- `benches/benches/words_alpha.txt` - Dictionary words data (~370K lines)

**CI/CD Files:**
- `.github/workflows/benchmark.yml` - Automated benchmark workflow
- `.github/gh-pages/index.md` - GitHub Pages configuration for results

## Where It Was Moved To

**From:** `bigweaver-agent-canary-hydro-zeta/benches/`  
**To:** `bigweaver-agent-canary-zeta-hydro-deps/benches/`

All file paths and directory structure remain identical in the new location, ensuring minimal disruption.

## Why It Was Moved

### Primary Reasons

1. **Dependency Isolation**
   - The main repository no longer depends on `timely` and `differential-dataflow`
   - These are heavyweight dependencies that bloat the dependency tree
   - Removing them improves build times for core Hydro development

2. **Build Performance**
   - Significantly faster builds for developers working on core functionality
   - Reduced compile times for CI/CD pipelines
   - Smaller dependency footprint

3. **Architectural Clarity**
   - Clear separation between core functionality and performance testing
   - Follows microservices/modular architecture principles
   - Easier to maintain and update benchmarks independently

4. **Performance Comparison Capability**
   - Benchmarks can still compare DFIR against timely/differential
   - Historical performance data is maintained
   - Independent CI/CD for benchmarking doesn't impact main repository

## How to Use

### For Developers

#### Running Benchmarks Locally

```bash
# Clone the deps repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench --manifest-path benches/Cargo.toml

# Run a specific benchmark
cargo bench --manifest-path benches/Cargo.toml --bench identity

# Generate detailed reports
cargo bench --manifest-path benches/Cargo.toml -- --save-baseline my-baseline
```

#### Comparing Performance

```bash
# Run baseline benchmarks
cargo bench --manifest-path benches/Cargo.toml -- --save-baseline before

# Make your changes in the main repository

# Run comparison benchmarks
cargo bench --manifest-path benches/Cargo.toml -- --baseline before
```

### For CI/CD

The benchmark workflow automatically triggers on:
- Push to main branch
- Pull requests containing `[ci-bench]` in title or body
- Scheduled runs (daily)
- Manual workflow dispatch

To trigger benchmarks in a PR, include `[ci-bench]` in your PR title or description.

### For Performance Engineering

#### Accessing Results

- Results are published to GitHub Pages
- Historical data is preserved in the `gh-pages` branch
- Criterion HTML reports provide detailed visualizations
- Trend analysis available for regression detection

#### Adding New Benchmarks

1. Create your benchmark file in `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Test locally
4. Submit PR to this repository

## Configuration Changes

### Main Repository (`bigweaver-agent-canary-hydro-zeta`)

**Removed:**
- `benches/` directory and all contents
- `"benches"` from workspace members in `Cargo.toml`
- Benchmark references in `CONTRIBUTING.md`
- `.github/workflows/benchmark.yml`
- `.github/gh-pages/index.md`

**No longer depends on:**
- `timely` package
- `differential-dataflow` package

### Deps Repository (`bigweaver-agent-canary-zeta-hydro-deps`)

**Added:**
- Complete `benches/` directory structure
- Workspace `Cargo.toml` configuration
- `rust-toolchain.toml` for Rust version consistency
- CI/CD workflow for benchmarking
- Comprehensive documentation

**Updated Dependencies:**
- `dfir_rs` - Now referenced via git from main repository
- `sinktools` - Now referenced via git from main repository
- Retained `timely` and `differential-dataflow` dependencies

## Impact Analysis

### 🟢 Hydro Development Team
- **Impact:** Low
- **Actions Required:** None for core development
- **Benefits:** Faster build times, cleaner dependency tree

### 🟢 Performance Engineering Team
- **Impact:** Low
- **Actions Required:** 
  - Update local workflows to use deps repository
  - Bookmark new GitHub Pages location
- **Benefits:** Independent benchmark CI/CD, easier to iterate on benchmarks

### 🟢 CI/CD Team
- **Impact:** Low
- **Actions Required:** None - workflows are self-contained
- **Benefits:** Benchmarks don't slow down main repository CI

### 🟢 Documentation Team
- **Impact:** Low
- **Actions Required:** Review migration documentation
- **Benefits:** Clear documentation of architectural decisions

## Performance Comparison Capability

### Retained Functionality

✅ All benchmark tests work identically  
✅ DFIR vs Timely vs Differential comparisons possible  
✅ Historical performance data maintained  
✅ Criterion integration with HTML reports  
✅ Automated CI/CD benchmarking  
✅ GitHub Pages publication  

### How It Works

The benchmarks use git dependencies to reference the main repository:

```toml
[dev-dependencies]
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

This ensures benchmarks always test against the latest version of DFIR while maintaining access to timely and differential-dataflow for comparisons.

## Before & After Comparison

### Before Migration

```
bigweaver-agent-canary-hydro-zeta/
├── benches/                    # ❌ Caused dependency bloat
│   ├── Cargo.toml             # Required timely/differential
│   └── benches/               # 12 benchmark files + data
├── dfir_rs/                    # Core DFIR
├── hydro_lang/                 # Hydro language
└── Cargo.toml                  # Workspace with benches member
```

### After Migration

```
bigweaver-agent-canary-hydro-zeta/
├── dfir_rs/                    # ✅ Core DFIR (cleaner)
├── hydro_lang/                 # ✅ Hydro language (faster builds)
└── Cargo.toml                  # ✅ No benches member

bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # ✅ All benchmarks isolated
│   ├── Cargo.toml             # ✅ Has timely/differential
│   └── benches/               # ✅ All 12 benchmarks + data
├── .github/workflows/          # ✅ Independent CI/CD
└── Cargo.toml                  # ✅ Separate workspace
```

## Rollback Plan

If needed, benchmarks can be restored to the main repository:

```bash
# From the main repository
git checkout <commit-before-removal>^
git checkout <commit-before-removal>^ -- benches/
git checkout <commit-before-removal>^ -- .github/workflows/benchmark.yml
git checkout <commit-before-removal>^ -- .github/gh-pages/index.md
# Edit Cargo.toml to add "benches" back to members
git add -A
git commit -m "chore: restore benchmarks from deps repo"
```

However, this would reintroduce the dependency bloat that this migration addressed.

## Frequently Asked Questions

**Q: How do I run benchmarks now?**  
A: Clone the deps repository and run `cargo bench --manifest-path benches/Cargo.toml`

**Q: Will benchmark history be lost?**  
A: No, all historical data is preserved in the GitHub Pages branch

**Q: Can I still compare DFIR against timely/differential?**  
A: Yes, all comparison functionality is retained

**Q: Do I need to update my workflow?**  
A: Only if you regularly run benchmarks locally - you'll need to clone the deps repository

**Q: How do I add a new benchmark?**  
A: Add it to the deps repository's `benches/benches/` directory and update `benches/Cargo.toml`

**Q: Will this slow down benchmark execution?**  
A: No, benchmark execution time is unchanged

**Q: What if I need timely/differential in the main repo?**  
A: Consider if it's truly needed for core functionality. If so, discuss with the team before adding it back.

## Related Changes

This migration is part of a broader effort to:
- Improve build performance
- Reduce dependency complexity  
- Establish clearer architectural boundaries
- Follow microservices principles

## Support

For questions or issues:
- **Main Repository Issues:** Use the main repository issue tracker
- **Benchmark Issues:** Use this repository's issue tracker
- **Performance Questions:** Contact the Performance Engineering team
- **General Questions:** See main repository CONTRIBUTING.md

## Timeline

- **Migration Date:** 2025-12-02
- **Main Repository Commit:** b161bc10 (removal)
- **Deps Repository Commit:** (addition)
- **Status:** Complete ✅
