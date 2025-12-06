# Benchmark Migration Analysis

## Overview

This document provides a comprehensive analysis of the timely and differential-dataflow benchmarks migration from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Details

### Source Information

- **Source Repository**: bigweaver-agent-canary-hydro-zeta
- **Removal Commit**: b161bc10 ("chore(benches): remove timely/differential-dataflow dependencies and benchmarks")
- **Retrieval Method**: Git history extraction from parent commit (b161bc10^)

### Destination Information

- **Target Repository**: bigweaver-agent-canary-zeta-hydro-deps
- **New Location**: `/benches` directory with workspace structure

## Migrated Files

### Configuration Files

1. **Cargo.toml** (Root workspace)
   - **Location**: `/Cargo.toml`
   - **Purpose**: Workspace configuration for the deps repository
   - **Contents**: 
     - Workspace member declaration for benches
     - Build profile configurations (release, profile)
     - Workspace-level package metadata

2. **benches/Cargo.toml**
   - **Location**: `/benches/Cargo.toml`
   - **Purpose**: Benchmark package configuration
   - **Key Dependencies**:
     - `criterion` (v0.5.0) - Benchmarking framework
     - `timely` (timely-master v0.13.0-dev.1) - Timely dataflow
     - `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1) - Differential dataflow
     - `dfir_rs` - Referenced from main repository via relative path
     - `sinktools` - Referenced from main repository via relative path
     - Supporting libraries: futures, rand, tokio, etc.
   - **Path Updates**: Updated dfir_rs and sinktools paths from `../` to `../../bigweaver-agent-canary-hydro-zeta/`

3. **benches/build.rs**
   - **Location**: `/benches/build.rs`
   - **Purpose**: Build script for generating fork_join benchmark code
   - **Functionality**: Generates `fork_join_20.hf` file with dfir_syntax macro content

4. **benches/README.md**
   - **Location**: `/benches/README.md`
   - **Purpose**: Instructions for running benchmarks
   - **Content**: Command examples and wordlist attribution

5. **benches/benches/.gitignore**
   - **Location**: `/benches/benches/.gitignore`
   - **Purpose**: Git ignore rules for benchmark build artifacts

### Benchmark Source Files

All benchmark files are located in `/benches/benches/` directory:

1. **arithmetic.rs** (7.6 KB)
   - **Purpose**: Benchmark arithmetic operations in different dataflow patterns
   - **Benchmarks**:
     - Pipeline implementation
     - Raw copy baseline
     - Timely dataflow implementation
     - Hydro implementation
   - **Dependencies**: dfir_rs, timely, criterion

2. **fan_in.rs** (3.5 KB)
   - **Purpose**: Benchmark fan-in dataflow patterns
   - **Pattern**: Multiple input streams merging into a single output
   - **Implementations**: Timely and Hydro variants

3. **fan_out.rs** (3.6 KB)
   - **Purpose**: Benchmark fan-out dataflow patterns
   - **Pattern**: Single input stream splitting to multiple outputs
   - **Implementations**: Timely and Hydro variants

4. **fork_join.rs** (4.3 KB)
   - **Purpose**: Benchmark fork-join parallelism patterns
   - **Pattern**: Work distribution and result aggregation
   - **Implementations**: Multiple variants for comparison

5. **futures.rs** (4.8 KB)
   - **Purpose**: Benchmark async futures-based implementations
   - **Focus**: Asynchronous dataflow operations
   - **Dependencies**: futures, tokio, criterion

6. **identity.rs** (6.8 KB)
   - **Purpose**: Benchmark identity transformation (passthrough) operations
   - **Use Case**: Baseline performance measurement
   - **Implementations**: Timely and Hydro variants

7. **join.rs** (4.4 KB)
   - **Purpose**: Benchmark join operations on data streams
   - **Pattern**: Relational-style join operations
   - **Implementations**: Timely and Hydro variants

8. **micro_ops.rs** (12 KB)
   - **Purpose**: Micro-benchmarks for individual operations
   - **Coverage**: Fine-grained operation performance testing
   - **Operations**: Various low-level dataflow primitives

9. **reachability.rs** (14 KB)
   - **Purpose**: Benchmark graph reachability algorithms
   - **Use Case**: Iterative dataflow computation
   - **Data Files**: Uses reachability_edges.txt and reachability_reachable.txt
   - **Implementations**: Differential-dataflow and Hydro variants

10. **symmetric_hash_join.rs** (4.5 KB)
    - **Purpose**: Benchmark symmetric hash join operations
    - **Pattern**: Equi-join using hash-based approach
    - **Implementations**: Multiple join strategies

11. **upcase.rs** (3.1 KB)
    - **Purpose**: Benchmark string transformation operations
    - **Operation**: Simple uppercase conversion
    - **Use Case**: String processing pipeline benchmarks

12. **words_diamond.rs** (7.0 KB)
    - **Purpose**: Benchmark diamond-shaped dataflow patterns
    - **Pattern**: Split, process in parallel, merge operations
    - **Data File**: Uses words_alpha.txt

### Data Files

1. **reachability_edges.txt** (521 KB)
   - **Purpose**: Graph edge data for reachability benchmark
   - **Format**: Edge list for graph connectivity

2. **reachability_reachable.txt** (38 KB)
   - **Purpose**: Expected reachability results for validation
   - **Use**: Benchmark correctness verification

3. **words_alpha.txt** (3.7 MB)
   - **Purpose**: English word list for word processing benchmarks
   - **Source**: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
   - **Size**: Large dataset for realistic performance testing

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                 # Workspace configuration
├── README.md                   # Repository overview and instructions
├── analysis.md                 # This file
└── benches/
    ├── Cargo.toml              # Benchmark package configuration
    ├── README.md               # Benchmark-specific instructions
    ├── build.rs                # Build script for code generation
    └── benches/
        ├── .gitignore
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_alpha.txt
        └── words_diamond.rs
```

## How to Run Benchmarks

### Prerequisites

1. **Repository Setup**: Ensure both repositories are cloned as siblings:
   ```
   /projects/sandbox/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. **Rust Toolchain**: Install Rust with cargo (see rust-toolchain.toml in main repository)

3. **Dependencies**: The benchmarks will automatically resolve dependencies from:
   - crates.io (timely, differential-dataflow, criterion, etc.)
   - Local paths (dfir_rs, sinktools from main repository)

### Running Individual Benchmarks

To run a specific benchmark:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench <benchmark_name>
```

**Available benchmarks:**
- `arithmetic` - Arithmetic operations and pipeline benchmarks
- `fan_in` - Fan-in dataflow pattern benchmarks
- `fan_out` - Fan-out dataflow pattern benchmarks
- `fork_join` - Fork-join parallelism benchmarks
- `futures` - Async futures-based benchmarks
- `identity` - Identity/passthrough operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithm benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String transformation benchmarks
- `words_diamond` - Diamond pattern word processing benchmarks

### Running All Benchmarks

To run all benchmarks at once:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

Or from the workspace root:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Benchmark Output

Benchmark results are saved to `target/criterion/` directory with:
- HTML reports for visualization
- Statistical analysis of performance
- Historical comparison data

To view HTML reports:
```bash
open target/criterion/report/index.html
```

## Performance Comparisons

### Comparing Different Implementations

Many benchmarks include multiple implementations for comparison:
1. **Timely/Differential-Dataflow** - Original timely dataflow implementations
2. **Hydro (dfir_rs)** - Hydro-based implementations
3. **Baseline** - Raw/pipeline implementations without frameworks

Example from arithmetic.rs:
- `arithmetic/pipeline` - Thread-based pipeline
- `arithmetic/raw` - Minimal overhead baseline
- `arithmetic/timely` - Timely dataflow implementation
- `arithmetic/hydro` - Hydro implementation

### Performance Metrics

Criterion provides:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Statistical Analysis**: Mean, median, standard deviation
- **Regression Detection**: Automatic performance regression alerts
- **Comparison**: Against previous runs and baselines

### Cross-Repository Comparisons

To compare performance between repository versions:

1. **Baseline Run** - Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench --bench <name> -- --save-baseline before
   ```

2. **Make Changes** - Modify code in bigweaver-agent-canary-hydro-zeta

3. **Comparison Run** - Run benchmarks again:
   ```bash
   cargo bench --bench <name> -- --baseline before
   ```

4. **View Results** - Check for performance regressions or improvements

## Dependencies Management

### External Crate Dependencies

The following external dependencies are automatically fetched from crates.io:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `criterion` (v0.5.0)
- `futures` (v0.3)
- `rand` (v0.8.0)
- `tokio` (v1.29.0)
- And others as specified in Cargo.toml

### Local Path Dependencies

The following dependencies reference the main repository:
- `dfir_rs` - Path: `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- `sinktools` - Path: `../../bigweaver-agent-canary-hydro-zeta/sinktools`

**Important**: These paths assume the repositories are siblings in the filesystem. If you clone them differently, update the paths in `benches/Cargo.toml`.

## Verification of Main Repository

### Removed Dependencies

The following dependencies have been successfully removed from `bigweaver-agent-canary-hydro-zeta`:
- ✅ No `timely` or `timely-master` references in any Cargo.toml
- ✅ No `differential-dataflow` references in any Cargo.toml
- ✅ No benchmark files in the benches/ directory (directory removed)
- ✅ Workspace configuration cleaned (benches removed from members list)

### Verification Commands

To verify the main repository is clean:

```bash
cd bigweaver-agent-canary-hydro-zeta

# Check for timely/differential-dataflow dependencies
find . -name "Cargo.toml" -exec grep -l "timely\|differential" {} \;
# Should return no results

# Check for benchmark directory
ls benches/ 2>/dev/null
# Should return "No such file or directory"

# Verify workspace members
grep "benches" Cargo.toml
# Should return no results
```

## Migration Benefits

### Separation of Concerns

1. **Clean Main Repository**
   - Main repository no longer carries timely/differential-dataflow dependencies
   - Reduced dependency tree complexity
   - Faster builds for users not interested in benchmarks

2. **Focused Benchmarking**
   - Dedicated repository for performance testing
   - Easier to maintain and evolve benchmarks independently
   - Clear separation between production code and performance testing

3. **Flexible Development**
   - Benchmarks can be updated without affecting main repository
   - Can test against different versions of main repository
   - Easier to compare performance across versions

### Maintained Capabilities

1. **Performance Comparison Preserved**
   - All original benchmarks retained
   - Ability to compare Timely, Differential-Dataflow, and Hydro implementations
   - Historical performance data continues to accumulate

2. **Independent Evolution**
   - Benchmarks can be enhanced without main repository changes
   - New benchmarks can be added easily
   - Benchmark dependencies can be updated independently

3. **Cross-Version Testing**
   - Can benchmark against different commits of main repository
   - Facilitates performance regression testing
   - Supports A/B performance comparisons

## Maintenance Guidelines

### Adding New Benchmarks

1. Create benchmark file in `benches/benches/<name>.rs`
2. Add `[[bench]]` entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "<name>"
   harness = false
   ```
3. Follow criterion benchmarking patterns
4. Update this analysis.md file

### Updating Dependencies

To update benchmark dependencies:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo update
```

To update timely or differential-dataflow versions:
- Edit version in `benches/Cargo.toml`
- Run `cargo update -p timely-master` or `cargo update -p differential-dataflow-master`

### Syncing with Main Repository

When main repository changes affect dfir_rs or sinktools:
1. No action needed - path dependencies automatically use latest
2. Rerun benchmarks to measure impact
3. Update this analysis if benchmark behavior changes

## Troubleshooting

### Path Dependency Issues

If you get errors about dfir_rs or sinktools not being found:
1. Verify repository layout (should be siblings)
2. Update paths in `benches/Cargo.toml` if needed
3. Ensure main repository is up to date

### Build Errors

If benchmarks fail to compile:
1. Check that main repository is present and buildable
2. Verify Rust toolchain version matches main repository
3. Run `cargo clean` and rebuild

### Benchmark Failures

If benchmarks fail to run:
1. Check data files are present (reachability_*.txt, words_alpha.txt)
2. Verify build.rs generated files successfully
3. Review benchmark-specific error messages

## Summary

This migration successfully:
- ✅ Extracted 12 benchmark files from git history
- ✅ Retrieved 3 data files (521KB + 38KB + 3.7MB)
- ✅ Configured standalone workspace structure
- ✅ Updated dependency paths for independence
- ✅ Preserved all benchmarking capabilities
- ✅ Maintained performance comparison features
- ✅ Cleaned main repository of timely/differential-dataflow dependencies
- ✅ Provided comprehensive documentation

The benchmarks are now independently maintainable while retaining the ability to perform performance comparisons against the main bigweaver-agent-canary-hydro-zeta repository.
