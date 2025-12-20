# Benchmark Migration and Cross-Repository Comparison Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository, and provides guidance on conducting cross-repository performance comparisons.

## Migration Details

### What Was Moved

The following benchmark implementations were extracted and moved to the deps repository:

1. **arithmetic_timely.rs**
   - Timely implementation of arithmetic operations (addition)
   - Tests 20 sequential arithmetic operations on 1M elements

2. **fan_in_timely.rs**
   - Timely implementation of stream concatenation/merging
   - Tests merging 20 separate streams into one

3. **fan_out_timely.rs**
   - Timely implementation of stream splitting
   - Tests distributing one stream to 20 consumers

4. **fork_join_timely.rs**
   - Timely implementation of fork-join pattern
   - Tests forking to 2 branches and rejoining, repeated 10 times

5. **identity_timely.rs**
   - Timely implementation of identity mapping
   - Tests 20 sequential identity operations

6. **join_timely.rs**
   - Timely implementation of hash join
   - Tests join on both `usize` and `String` key types

7. **reachability_timely_differential.rs**
   - Both timely and differential-dataflow implementations
   - Tests graph reachability algorithm on real graph data

8. **upcase_timely.rs**
   - Timely implementation of string transformations
   - Tests three variants: in-place, allocating, and concatenating

### What Remained

The main repository retained:

- Hydroflow implementations (scheduled and compiled)
- Babyflow implementations
- Spinachflow implementations
- Baseline implementations (raw loops, iterators, etc.)
- All shared test data (e.g., `reachability_edges.txt`)

### Dependency Changes

**Main Repository (`bigweaver-agent-canary-hydro-zeta`)**

Removed from `benches/Cargo.toml`:
```toml
timely = "*"
differential-dataflow = "*"
```

**Deps Repository (`bigweaver-agent-canary-zeta-hydro-deps`)**

Added to `timely-differential-benches/Cargo.toml`:
```toml
timely = "0.12"
differential-dataflow = "0.12"
```

## Performance Comparison Methodology

### Prerequisites

1. Both repositories must be checked out in the same parent directory:
   ```
   parent_dir/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Ensure Rust toolchain is up to date:
   ```bash
   rustup update
   ```

3. Close unnecessary applications to minimize system load

### Running Comparisons

#### Option 1: Automated Comparison Script

Use the provided comparison script:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

This script will:
1. Run benchmarks in both repositories
2. Collect results from criterion output
3. Generate a consolidated comparison report
4. Save results with timestamps for historical tracking

#### Option 2: Manual Comparison

##### Step 1: Run Main Repository Benchmarks

```bash
cd bigweaver-agent-canary-hydro-zeta/benches
cargo bench 2>&1 | tee ../../hydro_results_$(date +%Y%m%d_%H%M%S).txt
```

##### Step 2: Run Deps Repository Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
cargo bench 2>&1 | tee ../../timely_results_$(date +%Y%m%d_%H%M%S).txt
```

##### Step 3: Analyze Criterion Reports

Criterion generates HTML reports in `target/criterion/`. Open these in a browser for visual comparison:

```bash
# Main repository results
open bigweaver-agent-canary-hydro-zeta/benches/target/criterion/report/index.html

# Deps repository results
open bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches/target/criterion/report/index.html
```

### Interpreting Results

#### Benchmark Naming Conventions

- **Main Repository**: `<benchmark>/<implementation>` (e.g., `fan_in/hydroflow`, `fan_in/babyflow`)
- **Deps Repository**: `<benchmark>/timely` or `<benchmark>/differential` (e.g., `fan_in/timely`)

#### Key Metrics

1. **Time (Mean)**: Average execution time - lower is better
2. **Throughput**: Elements processed per second - higher is better
3. **Standard Deviation**: Consistency of results - lower is better
4. **R²**: Statistical confidence - closer to 1.0 is better

#### Fair Comparison Guidelines

When comparing implementations:

1. **Same Data Scale**: Ensure all implementations use the same input sizes
2. **Same Operations**: Compare semantically equivalent operations
3. **Consider Overhead**: Some frameworks have different initialization costs
4. **Multiple Runs**: Run each benchmark at least 3 times on different days
5. **System State**: Ensure similar system load (check with `htop` or similar)

### Example Comparison

Given these results:
- `fan_in/hydroflow`: 45.2 ms ± 1.1 ms
- `fan_in/timely`: 38.7 ms ± 0.9 ms
- `fan_in/babyflow`: 52.3 ms ± 1.4 ms

Analysis:
- Timely is ~14% faster than Hydroflow for this workload
- Babyflow is ~16% slower than Hydroflow
- All implementations show good consistency (low std dev)

## Benchmark-Specific Notes

### Arithmetic and Identity

These benchmarks test pure throughput with minimal logic. They're useful for understanding framework overhead.

### Fan-In and Fan-Out

These test the efficiency of stream routing and merging, which is critical for complex dataflow graphs.

### Fork-Join

Tests the ability to split computation and merge results, common in parallel processing patterns.

### Join

Hash join is a computationally expensive operation. Results here show how frameworks handle stateful operations.

### Reachability

This is the most complex benchmark, testing:
- Iterative computation
- State management
- Graph algorithms

The differential-dataflow implementation uses incremental computation, which may show different performance characteristics.

## Maintaining Performance Parity

### When Adding New Benchmarks

1. **Implement in Main Repository First**
   - Add Hydroflow/Babyflow/Spinachflow implementations
   - Ensure they work correctly
   - Document parameters and expected behavior

2. **Extract Timely/Differential Implementations**
   - Create corresponding `*_timely.rs` file in deps repository
   - Use identical constants and test data
   - Verify results match expected output

3. **Update Documentation**
   - Update this guide with new benchmark details
   - Add to comparison script
   - Document any special considerations

### When Modifying Existing Benchmarks

If benchmark parameters change in the main repository:

1. Update the corresponding file in deps repository
2. Ensure constants match (e.g., `NUM_INTS`, `NUM_OPS`)
3. Re-run comparison to update baseline
4. Document the change in both repositories

## Troubleshooting

### Benchmarks Take Too Long

Some benchmarks process millions of elements. To get faster feedback during development:

1. Create a `--features quick` variant with smaller data sizes
2. Use `cargo bench --bench <specific_bench>` to run one at a time
3. Adjust criterion sample size in `Cargo.toml`:
   ```toml
   [dev-dependencies.criterion]
   version = "0.3"
   features = ["async_tokio"]
   default-features = false
   ```

### Results Are Inconsistent

If you see high variance:

1. Close unnecessary applications
2. Disable CPU frequency scaling:
   ```bash
   sudo cpupower frequency-set --governor performance
   ```
3. Run benchmarks multiple times and average
4. Check for thermal throttling with `sensors` or similar tools

### Compilation Errors

If benchmarks fail to compile:

1. **Main Repository**: Ensure no timely/differential imports remain
2. **Deps Repository**: Ensure all necessary types and traits are imported
3. Check Rust version compatibility
4. Clear build cache: `cargo clean`

## Future Enhancements

Potential improvements to the comparison workflow:

1. **Automated CI Comparisons**: Run benchmarks on each PR
2. **Historical Tracking**: Database of benchmark results over time
3. **Regression Detection**: Alert when performance degrades
4. **Cross-Platform Results**: Compare across different architectures
5. **Flamegraph Integration**: Profile CPU usage for detailed analysis

## References

- Criterion.rs Documentation: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Hydroflow: (main repository)
