# Benchmarks for bigweaver-agent-canary-hydro-zeta

## Overview

This repository (`bigweaver-agent-canary-zeta-hydro-deps`) now houses the complete dependencies and benchmark code that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Benchmark Code - ✅ MIGRATION COMPLETE

Benchmark code comparing Hydroflow with timely and differential-dataflow has been successfully migrated from the main repository and is fully operational here.

### What Benchmarks Are Here

The following benchmark implementations have been migrated from the main repository:

1. **arithmetic.rs** - Arithmetic pipeline benchmarks
2. **fan_in.rs** - Fan-in pattern benchmarks
3. **fan_out.rs** - Fan-out pattern benchmarks
4. **fork_join.rs** - Fork-join pattern benchmarks
5. **futures.rs** - Futures-based async benchmarks
6. **identity.rs** - Identity transformation benchmarks
7. **join.rs** - Join operation benchmarks
8. **micro_ops.rs** - Micro-operation benchmarks
9. **reachability.rs** - Graph reachability benchmarks
10. **symmetric_hash_join.rs** - Symmetric hash join benchmarks
11. **upcase.rs** - String transformation benchmarks
12. **words_diamond.rs** - Diamond pattern word processing benchmarks

### Required Dependencies - ✅ CONFIGURED

All required dependencies are now configured in `benches/Cargo.toml`:

```toml
[dev-dependencies]
criterion = { version = "0.5.0", features = ["async_tokio", "html_reports"] }
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = ["debugging"] }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
futures = "0.3"
nameof = "1.0.0"
rand = "0.8.0"
rand_distr = "0.4.3"
seq-macro = "0.2.0"
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
static_assertions = "1.0.0"
timely = { package = "timely-master", version = "0.13.0-dev.1" }
tokio = { version = "1.29.0", features = ["rt-multi-thread"] }
```

Note: `dfir_rs` and `sinktools` are now git dependencies pointing to the main repository, ensuring benchmarks always use the latest version.

### Required Data Files - ✅ INCLUDED

All benchmark data files are included in the repository:

1. **reachability_edges.txt** (524K) - Graph edge data
2. **reachability_reachable.txt** (40K) - Reachable nodes data
3. **words_alpha.txt** (3.7M) - English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)

## Setting Up Benchmarks - ✅ COMPLETE

The benchmarks are fully set up and ready to run. No additional setup is required.

### What Was Done

The complete benchmark suite was extracted from the main repository's git history (commit 484e6fdd) and migrated here with:
- All 12 benchmark implementations
- All 3 required data files
- Complete Cargo configuration
- Build script for code generation
- Git dependencies configured for dfir_rs and sinktools

### Verification

To verify the setup:

```bash
# Build the benchmarks
cargo build --release

# Run a quick test
cargo bench --bench identity
```

## Running Benchmarks

The benchmarks are ready to run:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Generate HTML reports (with criterion feature)
# Reports will be in target/criterion/
```

### Available Benchmarks

All 12 benchmarks are configured and ready:
- arithmetic
- fan_in
- fan_out
- fork_join
- identity
- upcase
- join
- reachability
- micro_ops
- symmetric_hash_join
- words_diamond
- futures

## Performance Comparison

These benchmarks allow comparison between:

- **Hydroflow** - The main dataflow framework
- **Timely Dataflow** - For performance baseline comparison
- **Differential Dataflow** - For incremental computation comparison
- **Raw Rust** - For theoretical minimum overhead

## Benefits of Separation

1. **Main Repository**: Cleaner, faster builds, focused on core functionality
2. **Deps Repository**: Can maintain and update benchmarks independently
3. **Performance Testing**: Can still run comprehensive performance comparisons
4. **Dependency Management**: Benchmark dependencies don't affect main project

## Documentation References

For more information about the benchmark removal:

- **Main Repository**: See `BENCHMARK_REMOVAL.md` in bigweaver-agent-canary-hydro-zeta
- **Changes Summary**: See `CHANGES_SUMMARY.md` in main repository
- **Quick Reference**: See `QUICK_REFERENCE.md` in main repository

## Future Plans

This repository can be used for:

1. **Benchmark Code**: Housing all performance benchmarks
2. **Separated Dependencies**: Managing dependencies not needed by main project
3. **Performance Testing**: Regular performance regression testing
4. **Comparison Studies**: Framework performance comparisons
5. **Development Tools**: Other development utilities separate from main codebase

## Contributing

When adding benchmarks:

1. Follow the structure used in the original benchmark code
2. Use criterion for consistent benchmarking
3. Include documentation for what each benchmark tests
4. Add data files to `.gitignore` if they're very large
5. Document any special requirements or setup needed

## Questions?

For questions about:
- **Benchmark Setup**: See this file and main repository documentation
- **Running Benchmarks**: See criterion documentation
- **Performance Issues**: Contact main repository maintainers
- **Adding New Benchmarks**: Follow existing patterns and document thoroughly

## Status

**Current Status**: ✅ Benchmarks fully operational and ready to use

**Completed**: 
1. ✅ Benchmark code migrated from main repository history (commit 484e6fdd)
2. ✅ Cargo workspace configured with proper dependencies
3. ✅ All data files included and accessible
4. ✅ Git dependencies configured for dfir_rs and sinktools
5. ✅ Build script and configuration files in place
6. ✅ All 12 benchmarks ready to run

**Next Steps** (Optional): 
1. Configure CI/CD for automated benchmark runs
2. Set up performance tracking over time
3. Add additional performance testing tools
4. Create benchmark result comparison tools

## Related Repositories

- **Main Repository**: `bigweaver-agent-canary-hydro-zeta` - Core Hydro/DFIR code
- **Deps Repository**: `bigweaver-agent-canary-zeta-hydro-deps` - This repository
