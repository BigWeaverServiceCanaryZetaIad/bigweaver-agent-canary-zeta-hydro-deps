# Benchmark Migration Documentation

## Overview

This document describes the benchmarks that have been migrated from the bigweaver-agent-canary-hydro-zeta repository to this dedicated repository for timely and differential-dataflow performance comparisons.

## Migrated Benchmarks

The following benchmarks were migrated to this repository:

### Timely Dataflow Benchmarks

1. **arithmetic.rs** (255 lines)
   - Tests arithmetic operations in a pipeline
   - Compares timely dataflow with raw Rust, Tokio, and DFIR implementations
   - Performs 20 sequential increment operations on 1 million integers

2. **fan_in.rs** (114 lines)
   - Tests fan-in pattern where multiple streams merge into one
   - Compares timely dataflow with DFIR implementations
   - Uses 10 input channels merging to a single output

3. **fan_out.rs** (112 lines)
   - Tests fan-out pattern where one stream splits into multiple streams
   - Compares timely dataflow with DFIR implementations
   - Splits one input into 10 output channels

4. **fork_join.rs** (143 lines)
   - Tests fork-join pattern with alternating filter operations
   - Compares timely dataflow with DFIR implementations
   - Uses build.rs to generate complex fork-join graphs

5. **identity.rs** (244 lines)
   - Tests identity (pass-through) operations
   - Compares timely dataflow with raw channels and DFIR
   - Baseline benchmark for minimal overhead measurement

6. **join.rs** (132 lines)
   - Tests join operations with different value types
   - Compares timely dataflow with DFIR implementations
   - Benchmarks both usize and String joins

7. **upcase.rs** (120 lines)
   - Tests string transformation operations
   - Compares timely dataflow with DFIR implementations
   - Processes text file with uppercase transformation

### Differential Dataflow Benchmarks

8. **reachability.rs** (385 lines)
   - Tests graph reachability algorithms
   - Compares differential dataflow with DFIR implementations
   - Uses real graph data from included text files
   - Most comprehensive benchmark comparing incremental computation

### Data Files

- **reachability_edges.txt** (55,008 lines)
  - Graph edge data for reachability benchmark
  - Format: source_node destination_node

- **reachability_reachable.txt** (7,855 lines)
  - Expected reachability results for validation
  - Used to verify correctness of implementations

### Build Script

- **build.rs** (41 lines)
  - Generates fork_join benchmark code at compile time
  - Creates complex dataflow graphs programmatically

## Dependencies

The benchmarks require the following dependencies (specified in benches/Cargo.toml):

### External Dataflow Frameworks
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`

### DFIR/Hydro Dependencies
- `dfir_rs` - Referenced via git from bigweaver-agent-canary-hydro-zeta
- `sinktools` - Referenced via git from bigweaver-agent-canary-hydro-zeta

### Supporting Dependencies
- `criterion` - For benchmarking framework
- `futures` - For async operations
- `tokio` - For async runtime in some benchmarks
- `rand` and `rand_distr` - For random data generation
- `seq-macro` - For macro generation
- `static_assertions` - For compile-time assertions
- `nameof` - For variable name introspection

## Running Benchmarks

### Prerequisites

1. Rust toolchain 1.91.1 (specified in rust-toolchain.toml)
2. Access to the bigweaver-agent-canary-hydro-zeta repository (for dfir_rs and sinktools dependencies)

### Commands

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

Run with specific features or options:
```bash
# Save baseline for future comparisons
cargo bench -p benches -- --save-baseline before

# Compare against baseline
cargo bench -p benches -- --baseline before
```

### Interpreting Results

Criterion will generate:
- Console output with benchmark results
- HTML reports in `target/criterion/`
- Statistical analysis including mean, std dev, outliers

Lower times indicate better performance. Pay attention to:
- Mean execution time
- Standard deviation (lower is more consistent)
- Comparison with baseline if using `--baseline`

## Performance Comparison Strategy

These benchmarks are designed to compare equivalent operations across frameworks:

1. **DFIR (Hydro)** - The main framework being developed
2. **Timely Dataflow** - Established dataflow framework for comparison
3. **Differential Dataflow** - Incremental computation framework
4. **Raw Rust** - Baseline for minimal overhead (in some benchmarks)
5. **Tokio** - Async runtime comparison (in some benchmarks)

Each benchmark typically implements the same operation in multiple ways to enable fair comparison.

## Migration Rationale

These benchmarks were moved to a separate repository to:

1. **Reduce main repository complexity** - The bigweaver-agent-canary-hydro-zeta repository no longer needs timely/differential-dataflow dependencies
2. **Isolate external frameworks** - Keep comparison code separate from core implementation
3. **Maintain comparison capabilities** - Retain ability to measure performance against established frameworks
4. **Enable independent evolution** - Benchmarks can evolve without affecting main repository

## Contributing New Benchmarks

When adding new benchmarks that compare Hydro with timely or differential-dataflow:

1. Add benchmark file to `benches/benches/`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Follow existing patterns for fair comparison
4. Implement same operation in multiple frameworks
5. Use appropriate data sizes for meaningful measurements
6. Document the benchmark's purpose and operation

### Benchmark Structure Template

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use timely::dataflow::operators::*;
use dfir_rs::dfir_syntax;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("benchmark_name/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("benchmark_name/dfir", |b| {
        b.iter(|| {
            // DFIR implementation
        });
    });
}

criterion_group!(benches, benchmark_timely, benchmark_dfir);
criterion_main!(benches);
```

## Maintenance

### Updating Dependencies

When updating timely or differential-dataflow versions:

1. Update versions in `benches/Cargo.toml`
2. Run `cargo update -p benches`
3. Run full benchmark suite to verify compatibility
4. Check for API changes that may require code updates

### Syncing with Main Repository

The benchmarks depend on dfir_rs from the main repository:

- Dependency is specified via git URL
- Automatically pulls latest from main branch
- May need updates if dfir_rs API changes
- Consider pinning to specific commit/tag for stability

## Verification

To verify all benchmarks work correctly:

```bash
# Check that all benchmarks compile
cargo check -p benches

# Run quick test (shorter iterations)
cargo bench -p benches -- --quick

# Run full benchmark suite
cargo bench -p benches
```

## File Summary

| File | Lines | Purpose |
|------|-------|---------|
| arithmetic.rs | 255 | Arithmetic operation benchmarks |
| fan_in.rs | 114 | Fan-in pattern benchmarks |
| fan_out.rs | 112 | Fan-out pattern benchmarks |
| fork_join.rs | 143 | Fork-join pattern benchmarks |
| identity.rs | 244 | Identity/pass-through benchmarks |
| join.rs | 132 | Join operation benchmarks |
| reachability.rs | 385 | Graph reachability benchmarks |
| upcase.rs | 120 | String transformation benchmarks |
| reachability_edges.txt | 55,008 | Graph edge data |
| reachability_reachable.txt | 7,855 | Expected reachability results |
| build.rs | 41 | Build-time code generation |

**Total:** 8 benchmark files, 2 data files, 1 build script

## Links

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion Documentation: https://bheisler.github.io/criterion.rs/book/
