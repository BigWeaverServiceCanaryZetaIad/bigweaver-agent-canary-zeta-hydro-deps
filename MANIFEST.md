# Repository Manifest

## Overview

Complete listing of all files in the bigweaver-agent-canary-zeta-hydro-deps repository with descriptions.

## Root Directory Files

| File | Type | Size | Purpose |
|------|------|------|---------|
| README.md | Documentation | ~8KB | Main repository documentation and overview |
| BENCHMARKS.md | Documentation | ~20KB | Detailed benchmark documentation and methodology |
| QUICKSTART.md | Documentation | ~10KB | Quick start guide for running benchmarks |
| MANIFEST.md | Documentation | ~4KB | This file - complete repository file listing |
| verify_benchmarks.sh | Script | ~8KB | Verification script to check benchmark setup |
| run_comparison.sh | Script | ~6KB | Performance comparison script |

## Benchmark Directory Structure

### benches/

Main benchmark package directory.

| File | Type | Purpose |
|------|------|---------|
| Cargo.toml | Configuration | Package configuration and dependencies |
| build.rs | Build Script | Build-time configuration |
| README.md | Documentation | Benchmark-specific documentation |

### benches/benches/

Benchmark implementations and test data.

#### Benchmark Files

| File | Size | Dependencies | Purpose |
|------|------|--------------|---------|
| arithmetic.rs | ~8KB | timely | Arithmetic operation performance comparison |
| fan_in.rs | ~4KB | timely | Fan-in pattern benchmarks |
| fan_out.rs | ~4KB | timely | Fan-out pattern benchmarks |
| fork_join.rs | ~8KB | timely | Fork-join concurrency pattern benchmarks |
| identity.rs | ~8KB | timely | Identity operation baseline benchmarks |
| join.rs | ~8KB | timely | Join operation benchmarks |
| reachability.rs | ~16KB | timely, differential | Graph reachability algorithm benchmarks |
| upcase.rs | ~4KB | timely | String transformation benchmarks |

#### Test Data Files

| File | Size | Format | Purpose |
|------|------|--------|---------|
| reachability_edges.txt | 524KB | Text | Graph edge data for reachability benchmarks |
| reachability_reachable.txt | 40KB | Text | Expected reachability results for verification |
| words_alpha.txt | 3.7MB | Text | English word list for text processing benchmarks |

#### Configuration Files

| File | Purpose |
|------|---------|
| .gitignore | Git ignore patterns for benchmark artifacts |

## File Descriptions

### Documentation Files

#### README.md
- Main entry point for repository documentation
- Overview of purpose and structure
- Quick start instructions
- Benchmark descriptions
- Dependencies and prerequisites
- Migration information
- License and contact information

#### BENCHMARKS.md
- Comprehensive benchmark documentation
- Detailed descriptions of each benchmark
- Running instructions and examples
- Performance comparison methodology
- Test data descriptions
- Results interpretation guide
- Best practices and troubleshooting

#### QUICKSTART.md
- Fast-start guide (5 minutes to first benchmark)
- Essential commands reference
- Common use cases
- Troubleshooting quick fixes
- Quick reference card

#### MANIFEST.md
- This file
- Complete file listing
- Size and type information
- Purpose descriptions

### Script Files

#### verify_benchmarks.sh
Comprehensive verification script that checks:
- Directory structure
- Benchmark file presence
- Test data files
- Configuration files
- Dependencies in Cargo.toml
- Main repository access
- Benchmark declarations
- Build success
- Documentation files
- Quick benchmark test

Exit codes:
- 0: All checks passed
- 1: One or more critical checks failed

#### run_comparison.sh
Performance comparison automation script that:
- Checks repository setup
- Runs dfir_rs benchmarks (from main repo)
- Runs external framework benchmarks
- Collects results
- Generates comparison report
- Saves criterion outputs
- Provides HTML report links

Output directory: `comparison_results/`

### Configuration Files

#### benches/Cargo.toml
Package configuration file containing:
- Package metadata (name, version, edition)
- Dependencies:
  - criterion (benchmarking framework)
  - dfir_rs (from main repository)
  - differential-dataflow (v0.13.0-dev.1)
  - timely (v0.13.0-dev.1)
  - Supporting libraries (futures, rand, tokio, etc.)
- Benchmark declarations for all 8 benchmarks

Key dependencies:
```toml
[dev-dependencies]
criterion = "0.5.0"
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

#### benches/build.rs
Build script for compile-time configuration.

### Benchmark Implementation Files

#### arithmetic.rs
Compares different approaches to arithmetic operations:
- Pipeline pattern using threads and channels
- Raw memory copy approach
- Iterator-based processing
- Timely dataflow implementation

Test parameters:
- NUM_OPS: 20 operations
- NUM_INTS: 1,000,000 integers

#### fan_in.rs
Tests fan-in patterns where multiple streams merge:
- Multiple input streams converging to single output
- Tests with 2, 4, 8, and 16 input streams
- Measures throughput and synchronization overhead

#### fan_out.rs
Tests fan-out patterns where one stream splits:
- Single input broadcasting to multiple outputs
- Tests with 2, 4, 8, and 16 output streams
- Measures data duplication and distribution overhead

#### fork_join.rs
Tests fork-join concurrency patterns:
- Fork: Split work into parallel branches
- Process: Independent computation in each branch
- Join: Merge results back together
- Tests balanced and unbalanced workloads

#### identity.rs
Baseline benchmark measuring minimum overhead:
- Identity transformation (input = output)
- No actual computation performed
- Measures framework overhead
- Baseline for comparing other benchmarks

#### join.rs
Tests join operation performance:
- Inner joins between two streams
- Various data sizes (small, medium, large)
- Different distributions (even, skewed)
- Compares hash join implementations

#### reachability.rs
Graph reachability algorithm benchmarks:
- Uses differential dataflow for incremental computation
- Tests graph traversal algorithms
- Measures initial computation vs. incremental updates
- Uses real graph data (524KB edges)

Graph format:
```
source_node destination_node
1 2
1 3
...
```

#### upcase.rs
String transformation benchmarks:
- Converts strings to uppercase
- Streams from large word file (3.7MB)
- Tests text processing performance
- Measures I/O and transformation overhead

### Test Data Files

#### reachability_edges.txt (524KB)
Graph edge list for reachability benchmarks:
- Format: Space-separated node pairs
- One edge per line
- Integer node IDs
- Directed graph representation

#### reachability_reachable.txt (40KB)
Expected reachability results:
- Format: One node per line
- Integer node IDs
- Used for correctness verification
- Represents nodes reachable from start node

#### words_alpha.txt (3.7MB)
English word list:
- Format: One word per line
- Alphabetic characters only
- ~370,000 words
- Used for text processing benchmarks

## Directory Structure Diagram

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                      # Main documentation
├── BENCHMARKS.md                  # Detailed benchmark docs
├── QUICKSTART.md                  # Quick start guide
├── MANIFEST.md                    # This file
├── verify_benchmarks.sh           # Verification script
├── run_comparison.sh              # Comparison script
├── .git/                          # Git repository
└── benches/                       # Benchmark package
    ├── Cargo.toml                 # Package configuration
    ├── build.rs                   # Build script
    ├── README.md                  # Benchmark docs
    └── benches/                   # Benchmark implementations
        ├── .gitignore             # Git ignore patterns
        ├── arithmetic.rs          # 8KB - Arithmetic benchmarks
        ├── fan_in.rs              # 4KB - Fan-in benchmarks
        ├── fan_out.rs             # 4KB - Fan-out benchmarks
        ├── fork_join.rs           # 8KB - Fork-join benchmarks
        ├── identity.rs            # 8KB - Identity benchmarks
        ├── join.rs                # 8KB - Join benchmarks
        ├── reachability.rs        # 16KB - Reachability benchmarks
        ├── upcase.rs              # 4KB - String benchmarks
        ├── reachability_edges.txt # 524KB - Graph edges
        ├── reachability_reachable.txt # 40KB - Expected results
        └── words_alpha.txt        # 3.7MB - Word list
```

## Generated Files and Directories

These files are created during build and benchmark execution:

### target/
Cargo build output directory:
- `target/release/` - Release builds
- `target/debug/` - Debug builds
- `target/criterion/` - Benchmark results

### target/criterion/
Criterion benchmark results:
- Individual benchmark subdirectories
- HTML reports
- Statistical data
- Historical comparisons

### comparison_results/
Output from run_comparison.sh:
- Timestamped comparison reports
- Log files
- Copied criterion results
- Markdown comparison reports

## File Sizes Summary

| Category | Count | Total Size |
|----------|-------|------------|
| Documentation | 4 files | ~42KB |
| Scripts | 2 files | ~14KB |
| Benchmark Code | 8 files | ~60KB |
| Test Data | 3 files | ~4.3MB |
| Configuration | 2 files | ~4KB |
| **Total** | **19 files** | **~4.4MB** |

## Dependencies Summary

### External Crates
- criterion 0.5.0
- timely-master 0.13.0-dev.1
- differential-dataflow-master 0.13.0-dev.1
- futures 0.3
- rand 0.8.0
- rand_distr 0.4.3
- tokio 1.29.0

### Internal Dependencies (from main repo)
- dfir_rs (with debugging features)
- sinktools

### Supporting Libraries
- nameof 1.0.0
- seq-macro 0.2.0
- static_assertions 1.0.0

## Maintenance Information

### Adding New Benchmarks

To add a new benchmark:

1. Create `benches/benches/new_benchmark.rs`
2. Add `[[bench]]` declaration to `Cargo.toml`
3. Update this MANIFEST.md
4. Update BENCHMARKS.md with description
5. Add verification to verify_benchmarks.sh
6. Test with `cargo bench --bench new_benchmark`

### Updating Documentation

When changing structure:
1. Update README.md
2. Update BENCHMARKS.md if benchmark-related
3. Update QUICKSTART.md if affecting usage
4. Update this MANIFEST.md
5. Update verification scripts if needed

### Version Control

All files are tracked in Git except:
- target/ directory (build artifacts)
- comparison_results/ directory (generated reports)
- *.swp, *.swo (editor temporary files)
- Cargo.lock (managed by Cargo)

## Related Documentation

- Main repository: `../bigweaver-agent-canary-hydro-zeta/`
- Migration docs: `../bigweaver-agent-canary-hydro-zeta/MIGRATION_NOTES.md`
- Removal summary: `../bigweaver-agent-canary-hydro-zeta/REMOVAL_SUMMARY.md`
- Changes readme: `../bigweaver-agent-canary-hydro-zeta/CHANGES_README.md`

## Version History

- **v1.0** - Initial repository setup
  - 8 benchmark suites
  - Complete test data
  - Comprehensive documentation
  - Verification and comparison scripts

---

Last updated: 2024
Maintained by: BigWeaverServiceCanaryZetaIad team
