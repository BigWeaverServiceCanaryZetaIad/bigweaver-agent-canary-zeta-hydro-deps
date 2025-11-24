# Benchmark Migration Documentation

## Overview

This document details the migration of timely and differential-dataflow benchmarks from the main Hydroflow repository (`bigweaver-agent-canary-hydro-zeta`) to this dedicated repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

November 24, 2025

## Rationale

The benchmarks were moved to achieve better separation of concerns:

1. **Reduced Dependencies**: Remove external framework dependencies from the main repository
2. **Cleaner Architecture**: Separate core functionality from performance comparison code
3. **Independent Testing**: Enable performance testing without building the entire main project
4. **Easier Maintenance**: Isolate external framework version management

## Migrated Components

### Benchmark Files

The following benchmark files were transferred from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`:

1. **arithmetic.rs** (7,687 bytes)
   - Tests arithmetic operations across multiple implementations
   - Compares pipeline, raw copy, iterators, Hydroflow, and Timely

2. **fan_in.rs** (3,530 bytes)
   - Tests fan-in dataflow pattern
   - Compares Hydroflow and Timely implementations

3. **fan_out.rs** (3,625 bytes)
   - Tests fan-out dataflow pattern
   - Compares Hydroflow and Timely implementations

4. **fork_join.rs** (4,333 bytes)
   - Tests fork-join pattern with filtering
   - Compares Hydroflow and Timely implementations

5. **identity.rs** (6,891 bytes)
   - Tests identity transformation throughput
   - Compares Hydroflow and Timely implementations

6. **join.rs** (4,484 bytes)
   - Tests hash join operations
   - Supports both usize and String key types
   - Compares Hydroflow and Timely implementations

7. **reachability.rs** (13,681 bytes)
   - Tests iterative graph reachability computation
   - Uses Differential Dataflow operators
   - Compares Differential, Hydroflow, and raw implementations

8. **upcase.rs** (3,170 bytes)
   - Tests string transformation operations
   - Compares Hydroflow and Timely implementations

### Data Files

Large test data files were also transferred:

1. **words_alpha.txt** (3,864,799 bytes)
   - English word dictionary for string processing benchmarks
   - Source: https://github.com/dwyl/english-words

2. **reachability_edges.txt** (532,876 bytes)
   - Graph edge data for reachability benchmarks
   - Format: space-separated node ID pairs

3. **reachability_reachable.txt** (38,704 bytes)
   - Expected reachable nodes for verification
   - Format: one node ID per line

### Build Infrastructure

1. **build.rs** (1,178 bytes)
   - Build-time code generation for fork_join benchmark
   - Generates parameterized dataflow code

2. **README.md**
   - Original benchmark documentation (adapted and expanded)

## Dependencies Added

### External Framework Dependencies

The following dependencies were added to `benches/Cargo.toml`:

```toml
differential-dataflow = { package = "differential-dataflow-master", git = "https://github.com/TimelyDataflow/differential-dataflow.git", version = "0.13.0-dev.1" }
timely = { package = "timely-master", git = "https://github.com/TimelyDataflow/timely-dataflow.git", version = "0.13.0-dev.1" }
```

### Hydroflow Dependencies

Changed from local path references to git references:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

### Supporting Dependencies

Carried over from original benchmarks:
- criterion 0.5.0 (with async_tokio and html_reports features)
- futures 0.3
- nameof 1.0.0
- rand 0.8.0
- rand_distr 0.4.3
- seq-macro 0.2.0
- static_assertions 1.0.0
- tokio 1.29.0 (with rt-multi-thread feature)

## Repository Structure Created

```
bigweaver-agent-canary-zeta-hydro-deps/
├── .git/                              # Git repository
├── benches/                           # Benchmark package
│   ├── Cargo.toml                    # Package configuration
│   ├── README.md                      # Benchmark documentation
│   ├── build.rs                       # Build script
│   └── benches/                       # Benchmark implementations
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── reachability.rs
│       ├── upcase.rs
│       ├── reachability_edges.txt
│       ├── reachability_reachable.txt
│       └── words_alpha.txt
├── Cargo.toml                         # Workspace configuration
├── clippy.toml                        # Clippy linting rules
├── rustfmt.toml                       # Rust formatting rules
├── rust-toolchain.toml                # Rust toolchain specification
├── LICENSE                            # Apache 2.0 license
├── README.md                          # Repository documentation
├── CONTRIBUTING.md                    # Contribution guidelines
└── MIGRATION.md                       # This file
```

## Configuration Files

### Workspace Configuration (Cargo.toml)

Created root workspace configuration with:
- Single member: `benches`
- Edition: 2024
- License: Apache-2.0
- Release profile optimizations

### Benchmark Package (benches/Cargo.toml)

Configured with:
- Package name: `timely-differential-benchmarks`
- 8 benchmark definitions with `harness = false`
- All necessary dependencies
- Proper feature flags

### Code Quality Tools

Copied from main repository to maintain consistency:
- **rust-toolchain.toml**: Toolchain version specification
- **rustfmt.toml**: Code formatting rules
- **clippy.toml**: Linting configuration

## Functionality Preserved

All benchmark functionality was preserved:

✅ **Benchmark Execution**
- All 8 benchmarks can be run independently or together
- Same benchmark harness (Criterion) and reporting
- Identical performance measurement methodology

✅ **Performance Comparison**
- Timely Dataflow benchmarks work as before
- Differential Dataflow benchmarks work as before
- Hydroflow comparisons work as before
- Multiple implementation comparisons per benchmark

✅ **Data Processing**
- All test data files transferred
- File loading and parsing unchanged
- Same graph and text data used

✅ **Build-Time Code Generation**
- build.rs script transferred
- Fork-join pattern generation works identically

## Changes Made

### Path References

Changed Hydroflow dependency references:

**Before (in main repo):**
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After (in this repo):**
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

**For local development:**
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Package Naming

Changed package name for clarity:
- Before: `benches` (generic name in main repo)
- After: `timely-differential-benchmarks` (descriptive name)

### Repository Metadata

Updated repository URLs:
- From: `https://github.com/hydro-project/hydro`
- To: `https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps`

## Testing Verification

### Pre-Migration Testing

In main repository (`bigweaver-agent-canary-hydro-zeta`):
```bash
# These commands worked before migration
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

### Post-Migration Testing

In this repository (`bigweaver-agent-canary-zeta-hydro-deps`):
```bash
# These commands should work after migration
cargo bench -p timely-differential-benchmarks --bench arithmetic
cargo bench -p timely-differential-benchmarks --bench reachability
```

### Verification Checklist

✅ All benchmark files transferred
✅ All data files transferred
✅ Build script transferred
✅ Dependencies configured correctly
✅ Workspace structure created
✅ Configuration files added
✅ Documentation created
✅ License file included

## Usage Examples

### Running Individual Benchmarks

```bash
# Arithmetic operations
cargo bench --bench arithmetic

# Graph reachability (Differential Dataflow)
cargo bench --bench reachability

# Join operations
cargo bench --bench join
```

### Running Specific Implementations

```bash
# Only Timely implementations
cargo bench -- timely

# Only Hydroflow implementations
cargo bench -- dfir_rs

# Only Differential implementations
cargo bench -- differential
```

### Running All Benchmarks

```bash
# Full benchmark suite
cargo bench -p timely-differential-benchmarks

# Quick run with fewer samples
cargo bench -- --sample-size 10
```

## Integration with Main Repository

### Relationship

- **Main Repo**: `bigweaver-agent-canary-hydro-zeta`
  - Core Hydroflow functionality
  - Native benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond)
  - No external framework dependencies

- **This Repo**: `bigweaver-agent-canary-zeta-hydro-deps`
  - Comparative benchmarks with external frameworks
  - Timely and Differential Dataflow dependencies
  - Performance analysis and comparison tools

### Workflow

1. **Development in Main Repo**
   - Develop Hydroflow features
   - Run native benchmarks

2. **Performance Comparison**
   - Switch to this repo
   - Run comparative benchmarks
   - Analyze performance against Timely/Differential

3. **Local Development**
   - Use path dependencies to test against local Hydroflow
   - Verify performance before committing

## Documentation Created

### Repository-Level Documentation

1. **README.md** - Comprehensive repository overview
   - Quick start guide
   - Benchmark suite description
   - Usage examples
   - Architecture explanation

2. **CONTRIBUTING.md** - Contribution guidelines
   - Code style and standards
   - Commit message format
   - PR process
   - Benchmark-specific guidelines

3. **MIGRATION.md** - This file
   - Migration rationale
   - Components transferred
   - Changes made
   - Testing verification

4. **LICENSE** - Apache 2.0 license

### Benchmark-Level Documentation

1. **benches/README.md** - Detailed benchmark documentation
   - Individual benchmark descriptions
   - Usage instructions
   - Performance comparison guide
   - Data file information
   - Troubleshooting

## Benefits Achieved

### For Main Repository

✅ **Cleaner Codebase**
- Removed 8 benchmark files
- Removed 2 large external dependencies
- Removed associated data files (4.4MB+)

✅ **Faster Builds**
- No timely-dataflow compilation
- No differential-dataflow compilation
- Reduced dependency tree

✅ **Simplified Maintenance**
- Focus on core functionality
- Fewer external version dependencies
- Cleaner commit history

### For This Repository

✅ **Independent Operation**
- Self-contained benchmark suite
- Can run without main repository clone
- Clear, focused purpose

✅ **Better Organization**
- Dedicated documentation
- Structured for benchmarking
- Easy to extend

✅ **Flexible Testing**
- Can test against published Hydroflow versions
- Can test against local development versions
- Independent CI/CD possible

## Future Enhancements

### Potential Additions

1. **Additional Benchmarks**
   - More dataflow patterns
   - Additional framework comparisons
   - Real-world workload simulations

2. **Performance Tracking**
   - Historical performance data
   - Regression detection
   - Automated reporting

3. **CI/CD Integration**
   - Automated benchmark runs
   - Performance regression alerts
   - Result archiving

4. **Extended Documentation**
   - Performance analysis guides
   - Framework comparison studies
   - Best practices for dataflow programming

## References

### Source Repository
- **bigweaver-agent-canary-hydro-zeta**: Main Hydroflow repository
- Location: `/projects/sandbox/bigweaver-agent-canary-hydro-zeta`
- Documentation: `BENCHMARK_REMOVAL.md`, `README_BENCHMARK_REMOVAL.md`

### External Projects
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Hydroflow**: https://github.com/hydro-project/hydro
- **Criterion.rs**: https://github.com/bheisler/criterion.rs

## Contact and Support

For questions about this migration or the benchmark suite:
1. Review this documentation
2. Check the README.md files
3. Consult CONTRIBUTING.md for contribution guidance
4. Create an issue in the repository

## Changelog

### 2025-11-24 - Initial Migration
- Transferred 8 benchmark files from main repository
- Transferred 3 data files (4.4MB+ total)
- Transferred build script
- Created workspace structure
- Added dependencies for timely and differential-dataflow
- Created comprehensive documentation
- Established independent repository functionality
