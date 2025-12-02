# Benchmark Migration Guide

This document explains the migration of benchmarks from the main Hydro repository to this dedicated benchmarks repository.

## Background

The benchmarks with dependencies on `timely-dataflow` and `differential-dataflow` have been moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to this separate repository. This change:

1. **Reduces dependency bloat** in the main repository
2. **Preserves performance comparison capabilities** by maintaining benchmarks in a dedicated space
3. **Simplifies CI/CD** by isolating heavy dependencies
4. **Maintains historical benchmark data** while keeping the main repo focused on core functionality

## What Was Moved

The following components were moved from `benches/` in the main repository:

### Benchmark Files
- `arithmetic.rs` - Arithmetic operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Futures-based operation benchmarks
- `identity.rs` - Identity transformation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String transformation benchmarks
- `words_diamond.rs` - Word processing diamond pattern

### Data Files
- `reachability_edges.txt` - Graph edges for reachability benchmarks
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - English word list (from https://github.com/dwyl/english-words)

### Configuration Files
- `Cargo.toml` - Package configuration with dependencies
- `build.rs` - Build script for generated code
- `README.md` - Benchmark documentation

## Dependency Changes

### Main Repository (bigweaver-agent-canary-hydro-zeta)

**Removed:**
- `benches/` workspace member
- `timely-dataflow` transitive dependencies
- `differential-dataflow` transitive dependencies
- `.github/workflows/benchmark.yml` workflow

**Updated:**
- `CONTRIBUTING.md` - Added reference to benchmarks repository
- `README.md` - Added link to benchmarks repository

### This Repository (bigweaver-agent-canary-zeta-hydro-deps)

**Added:**
- Complete `benches/` package with all benchmark code
- Git dependencies for `dfir_rs` and `sinktools` pointing to main repository
- Direct dependencies on `timely-dataflow` and `differential-dataflow`

## Running Benchmarks

### Before Migration
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### After Migration
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

The command syntax remains the same, only the repository location has changed.

## Performance Comparison Workflow

The migration preserves the ability to run performance comparisons:

1. **Clone both repositories:**
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Run benchmarks from the deps repository:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

3. **Benchmarks automatically use the latest Hydro code** via git dependencies, ensuring comparisons are always against the current implementation.

## For Developers

### Adding New Benchmarks

Add new benchmarks to this repository (`bigweaver-agent-canary-zeta-hydro-deps`):

1. Create benchmark file in `benches/benches/`
2. Add `[[bench]]` entry in `benches/Cargo.toml`
3. Follow existing patterns for Hydro vs. timely/differential comparisons

### Updating Existing Benchmarks

Benchmarks that compare Hydro implementations should:
- Use git dependencies that automatically track the main branch
- Run `cargo update` to get latest Hydro changes
- Ensure comparisons remain fair and use equivalent algorithms

### CI/CD Considerations

The separation means:
- Main repository CI is faster (no heavy benchmark compilation)
- Benchmark CI can be run independently
- Performance regression tracking can be specialized for benchmarks
- Both repositories can be released independently

## Git History

The benchmark files retain their full git history in the main repository. To view history:

```bash
cd bigweaver-agent-canary-hydro-zeta
git log --follow -- benches/benches/arithmetic.rs
```

## Questions?

If you have questions about the migration:
1. Check the [README.md](README.md) in this repository
2. Refer to [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines
3. See the main repository's documentation for Hydro-specific questions
4. Open an issue if something is unclear

## Timeline

- **Migration Date:** December 2, 2025
- **Main Repository Commit:** b161bc10 (removed benchmarks)
- **Last Commit With Benchmarks:** 484e6fdd (before removal)
- **This Repository Created:** Benchmarks added with full functionality preserved
