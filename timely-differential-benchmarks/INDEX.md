# File Index

Complete index of all files in the Timely/Differential Dataflow Benchmarks suite.

## Documentation Files

### Main Documentation
- **README.md** - Complete benchmark suite documentation with descriptions of all 8 benchmarks, usage instructions, and performance comparison guidance
- **QUICKSTART.md** - Fast 5-minute getting started guide with common commands and quick reference
- **INDEX.md** - This file; complete inventory of all files in the repository

### Detailed Guides
- **MIGRATION.md** - Detailed migration documentation from source repository, what was migrated, changes made, and verification steps
- **TESTING.md** - Comprehensive testing and validation guide with troubleshooting and CI/CD recommendations
- **BENCHMARK_COMPARISON.md** - Performance comparison methodology for comparing with Hydro and other systems

## Configuration Files

- **Cargo.toml** - Rust package configuration with dependencies and 8 benchmark targets
- **src/lib.rs** - Minimal library with shared constants and utilities

## Benchmark Source Files (8 total)

### Core Benchmarks
- **benches/arithmetic.rs** - Chain of arithmetic operations (1M integers, 20 operations)
- **benches/fan_in.rs** - Multiple stream concatenation (20 streams of 1M integers)
- **benches/fan_out.rs** - Single stream splitting (1M integers to 20 consumers)
- **benches/fork_join.rs** - Iterative fork-join patterns (100K integers, 20 iterations)
- **benches/identity.rs** - Pass-through operations testing baseline overhead (1M integers, 20 ops)

### Advanced Benchmarks
- **benches/join.rs** - Hash join operations for usize and String types (100K tuples each)
- **benches/reachability.rs** - Graph reachability with Timely AND Differential (55K edges, 7.8K nodes) **CRITICAL**
- **benches/upcase.rs** - String transformations with 3 variants (100K strings, 20 ops)

## Test Data Files (3 total)

- **benches/reachability_edges.txt** - Graph edge data (521 KB, 55,008 edges)
- **benches/reachability_reachable.txt** - Expected reachable nodes (38 KB, 7,855 nodes)
- **benches/words_alpha.txt** - Dictionary data for string processing (3.7 MB)

## File Organization

```
timely-differential-benchmarks/
│
├── Documentation (6 files)
│   ├── README.md                    [Main documentation]
│   ├── QUICKSTART.md                [Quick start guide]
│   ├── MIGRATION.md                 [Migration details]
│   ├── TESTING.md                   [Testing guide]
│   ├── BENCHMARK_COMPARISON.md      [Comparison guide]
│   └── INDEX.md                     [This file]
│
├── Configuration (2 files)
│   ├── Cargo.toml                   [Package config]
│   └── src/
│       └── lib.rs                   [Library root]
│
├── Benchmarks (8 files)
│   └── benches/
│       ├── arithmetic.rs            [Arithmetic ops]
│       ├── fan_in.rs                [Stream merging]
│       ├── fan_out.rs               [Stream splitting]
│       ├── fork_join.rs             [Fork-join patterns]
│       ├── identity.rs              [Baseline overhead]
│       ├── join.rs                  [Hash joins]
│       ├── reachability.rs          [Graph algorithms]
│       └── upcase.rs                [String ops]
│
└── Test Data (3 files)
    └── benches/
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── words_alpha.txt
```

## File Count Summary

| Category | Count |
|----------|-------|
| Documentation | 6 files |
| Configuration | 2 files |
| Benchmarks | 8 files |
| Test Data | 3 files |
| **Total** | **19 files** |

## Quick File Lookup

### Need to...
- **Get started quickly?** → QUICKSTART.md
- **Understand benchmarks?** → README.md
- **Validate migration?** → MIGRATION.md
- **Test benchmarks?** → TESTING.md
- **Compare performance?** → BENCHMARK_COMPARISON.md
- **Configure package?** → Cargo.toml
- **Find test data?** → benches/*.txt files

### Looking for specific benchmark?
- **Arithmetic operations** → benches/arithmetic.rs
- **Stream merging** → benches/fan_in.rs
- **Stream splitting** → benches/fan_out.rs
- **Complex patterns** → benches/fork_join.rs
- **Baseline overhead** → benches/identity.rs
- **Hash joins** → benches/join.rs
- **Graph algorithms** → benches/reachability.rs ⭐
- **String processing** → benches/upcase.rs

⭐ = Includes Differential Dataflow implementation

## File Sizes

### Documentation
- README.md: ~6 KB
- QUICKSTART.md: ~4 KB
- MIGRATION.md: ~8 KB
- TESTING.md: ~9 KB
- BENCHMARK_COMPARISON.md: ~12 KB
- INDEX.md: ~3 KB

### Source Code
- arithmetic.rs: ~700 bytes
- fan_in.rs: ~900 bytes
- fan_out.rs: ~700 bytes
- fork_join.rs: ~1 KB
- identity.rs: ~700 bytes
- join.rs: ~3 KB
- reachability.rs: ~4 KB ⭐
- upcase.rs: ~2 KB

### Test Data
- reachability_edges.txt: 521 KB
- reachability_reachable.txt: 38 KB
- words_alpha.txt: 3.7 MB

**Total repository size**: ~4.3 MB

## Key Files

### Must Read (Start Here)
1. **QUICKSTART.md** - Get running in 5 minutes
2. **README.md** - Complete reference

### Important Documentation
3. **TESTING.md** - Validation procedures
4. **BENCHMARK_COMPARISON.md** - Performance comparison

### Reference
5. **MIGRATION.md** - Historical context
6. **INDEX.md** - This inventory

### Critical Benchmark
7. **benches/reachability.rs** - Only file with Differential Dataflow

## Dependencies by File

### All benchmark files depend on:
- `criterion` - Statistical benchmarking
- `timely` - Timely Dataflow

### Only reachability.rs depends on:
- `differential-dataflow` - Differential Dataflow

### Data dependencies:
- reachability.rs → reachability_edges.txt, reachability_reachable.txt
- upcase.rs → words_alpha.txt (indirectly)

## Modification History

Files created during migration from bigweaver-agent-canary-hydro-zeta:

### Newly Created
- All documentation files (6)
- Cargo.toml (new configuration)
- src/lib.rs (minimal library)

### Extracted and Modified
- All benchmark files (8) - Extracted Timely/Differential code only
- Removed Hydro-specific implementations
- Removed non-Timely/Differential baseline benchmarks

### Copied Unchanged
- All test data files (3)
- Data files used directly via include_bytes!()

## Usage Patterns

### Reading Order for New Users
1. QUICKSTART.md
2. README.md (skim)
3. Run benchmarks
4. TESTING.md (as needed)
5. BENCHMARK_COMPARISON.md (for comparisons)

### Maintenance Reference
- Cargo.toml - Add new benchmarks here
- src/lib.rs - Add shared utilities
- MIGRATION.md - Understand history
- TESTING.md - Validation procedures

### Development Workflow
1. Read QUICKSTART.md
2. Create new benchmark in benches/
3. Add to Cargo.toml
4. Update README.md
5. Test per TESTING.md
6. Document in appropriate files

## Completeness Checklist

### Documentation ✓
- [x] Main README
- [x] Quick start guide
- [x] Migration documentation
- [x] Testing guide
- [x] Comparison guide
- [x] File index

### Code ✓
- [x] All 8 benchmarks
- [x] Package configuration
- [x] Library structure
- [x] No Hydro dependencies

### Data ✓
- [x] Graph data (edges)
- [x] Expected results (reachable)
- [x] Dictionary data (words)

### Functionality ✓
- [x] Timely implementations (8)
- [x] Differential implementation (1)
- [x] Criterion integration
- [x] Validation logic

## Navigation Tips

### From this file:
- Want to run benchmarks? → See QUICKSTART.md
- Need detailed info? → See README.md
- Testing/validation? → See TESTING.md
- Performance comparison? → See BENCHMARK_COMPARISON.md
- Historical context? → See MIGRATION.md

### From any benchmark:
- Configuration → ../Cargo.toml
- Shared code → ../src/lib.rs
- Test data → Same directory (*.txt)
- Documentation → ../*.md

## Maintenance Notes

### Adding a New Benchmark
1. Create benches/new_benchmark.rs
2. Add [[bench]] section to Cargo.toml
3. Add description to README.md
4. Add testing notes to TESTING.md
5. Update this INDEX.md
6. Add comparison notes to BENCHMARK_COMPARISON.md

### Updating Documentation
- README.md - Benchmark descriptions, usage
- TESTING.md - New validation procedures
- BENCHMARK_COMPARISON.md - New comparison methodologies
- QUICKSTART.md - New quick commands
- INDEX.md - New files or changes

### Version Control
- All files are under version control
- See git log for detailed change history
- Refer to MIGRATION.md for original source

## Related Files in Parent Repository

In `/projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/`:
- **README.md** - Parent repository overview
- **MIGRATION_SUMMARY.md** - High-level migration summary

## Summary

This benchmark suite contains:
- **19 total files**
- **6 documentation files** providing comprehensive guidance
- **8 benchmark implementations** covering key dataflow patterns
- **3 test data files** for realistic benchmarking
- **1 Differential Dataflow implementation** (reachability)
- **Complete functionality** with no dependencies on source repository

All files are organized, documented, and ready for use.
