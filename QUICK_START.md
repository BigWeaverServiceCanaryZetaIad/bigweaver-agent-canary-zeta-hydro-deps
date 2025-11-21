# Quick Start Guide

## Benchmark Migration Complete! ✅

All timely and differential-dataflow benchmarks have been successfully migrated and are ready to use.

## Quick Commands

### Run All Benchmarks
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench reachability    # Graph reachability
cargo bench --bench arithmetic      # Arithmetic operations
cargo bench --bench join            # Join operations
cargo bench --bench identity        # Identity transformations
```

### List All Available Benchmarks
```bash
cargo bench --list
```

## What's Available

### 12 Benchmarks Ready to Run
1. **arithmetic** - Arithmetic pipeline benchmarks
2. **fan_in** - Fan-in pattern benchmarks
3. **fan_out** - Fan-out pattern benchmarks
4. **fork_join** - Fork-join pattern benchmarks
5. **identity** - Identity transformation benchmarks
6. **upcase** - String transformation benchmarks
7. **join** - Join operation benchmarks
8. **reachability** - Graph reachability benchmarks
9. **micro_ops** - Micro-operation benchmarks
10. **symmetric_hash_join** - Symmetric hash join benchmarks
11. **words_diamond** - Diamond pattern word processing
12. **futures** - Futures-based async benchmarks

### Performance Comparisons Included
- ✅ Hydroflow implementations
- ✅ Timely dataflow implementations
- ✅ Differential dataflow implementations
- ✅ Raw Rust baselines

### Data Files Included
- ✅ reachability_edges.txt (521KB)
- ✅ reachability_reachable.txt (38KB)
- ✅ words_alpha.txt (3.7MB)

## Results Location

Benchmark results are generated in:
```
target/criterion/
├── report/
│   └── index.html    # Main report (open in browser)
└── [benchmark-name]/ # Individual benchmark results
```

## Documentation

- **README.md** - Repository overview
- **SETUP.md** - Complete setup and usage guide
- **MIGRATION_SUMMARY.md** - Details of the migration
- **VALIDATION_CHECKLIST.md** - Validation results
- **BENCHMARKS_INFO.md** - Comprehensive benchmark information
- **QUICK_START.md** - This file

## Dependencies

All dependencies are properly configured:
- **timely-master** v0.13.0-dev.1 (Timely dataflow)
- **differential-dataflow-master** v0.13.0-dev.1 (Differential dataflow)
- **criterion** v0.5.0 (Benchmarking framework)
- **dfir_rs** (git dependency from main repository)
- **sinktools** (git dependency from main repository)
- Plus supporting dependencies (futures, rand, tokio, etc.)

## Build and Run

First time setup (downloads dependencies):
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo build --release
```

Run benchmarks:
```bash
cargo bench
```

## Status

✅ Migration Complete  
✅ All 12 benchmarks operational  
✅ All dependencies configured  
✅ All data files present  
✅ Documentation complete  
✅ Ready for immediate use  

## Questions?

See the comprehensive documentation:
- **Quick usage**: benches/README.md
- **Detailed setup**: SETUP.md
- **Migration details**: MIGRATION_SUMMARY.md
- **Validation**: VALIDATION_CHECKLIST.md

## Next Steps

1. **Run a quick test**: `cargo bench --bench identity`
2. **Run all benchmarks**: `cargo bench`
3. **View HTML reports**: Open `target/criterion/report/index.html`
4. **Explore results**: Browse individual benchmark reports

Happy benchmarking! 🚀
