# Timely and Differential-Dataflow Benchmarks

This package contains benchmarks for timely and differential-dataflow implementations, comparing them with dfir_rs (Hydroflow) implementations.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to reduce dependency complexity and improve build times in the main codebase. By isolating these benchmarks in a dedicated repository, we can:

- Maintain performance comparison capabilities
- Avoid timely and differential-dataflow dependencies in the main repository
- Keep build times optimized for core development
- Preserve historical benchmark data for performance analysis

## Available Benchmarks

### Arithmetic Operations (`arithmetic.rs`)
Benchmarks basic arithmetic operations across different dataflow implementations:
- **Pipeline**: Multi-threaded pipeline using channels
- **Raw Copy**: Minimal overhead baseline
- **Iterator**: Rust iterator chain
- **Iterator with Collect**: Iterator with intermediate collections
- **Hydroflow (dfir_rs)**: Both compiled and interpreted versions
- **Timely**: Timely dataflow implementation

### Fan-In Pattern (`fan_in.rs`)
Tests multiple inputs converging to a single output:
- Compares Hydroflow and Timely implementations
- Measures throughput and latency

### Fan-Out Pattern (`fan_out.rs`)
Tests single input distributing to multiple outputs:
- Compares Hydroflow and Timely implementations
- Measures distribution overhead

### Fork-Join Pattern (`fork_join.rs`)
Tests parallel computation with synchronization:
- Compares Hydroflow and Timely implementations
- Measures coordination overhead

### Identity Operation (`identity.rs`)
Measures baseline dataflow overhead with no-op operations:
- Provides performance baseline
- Compares all three implementations (Hydroflow compiled, Hydroflow interpreted, Timely)

### Join Operations (`join.rs`)
Tests relational join implementations:
- Compares Hydroflow and Timely implementations
- Measures join performance with different data sizes

### Graph Reachability (`reachability.rs`)
Complex benchmark for graph algorithms:
- Uses differential-dataflow for incremental computation
- Compares with Hydroflow implementation
- Includes test data files:
  - `reachability_edges.txt` (~520 KB): Graph edge data
  - `reachability_reachable.txt` (~38 KB): Expected reachability results

### String Uppercase (`upcase.rs`)
Simple string transformation benchmark:
- Compares Hydroflow and Timely implementations
- Measures string processing throughput

## Running Benchmarks

### Prerequisites

- Rust toolchain (matching the version in `rust-toolchain.toml` of the main repository)
- Git access to the main repository (for dfir_rs and sinktools dependencies)

### Run All Benchmarks

```bash
cargo bench -p timely-differential-benches
```

### Run Specific Benchmarks

```bash
# Individual benchmarks
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
```

### Run Specific Benchmark Variants

```bash
# Run only Hydroflow variants of arithmetic benchmark
cargo bench -p timely-differential-benches --bench arithmetic -- dfir

# Run only Timely variants
cargo bench -p timely-differential-benches --bench arithmetic -- timely
```

## Performance Comparison

These benchmarks are designed to provide comparative performance data between:

1. **Hydroflow (dfir_rs)**: The main dataflow system
   - Compiled variant: Optimized compilation
   - Interpreted variant: Dynamic execution

2. **Timely Dataflow**: Reference implementation for dataflow systems
   - Industry-standard dataflow framework
   - Used for performance baseline comparison

3. **Differential Dataflow**: Incremental computation framework
   - Built on Timely
   - Used for incremental/streaming algorithms

### Interpreting Results

Benchmark results are generated using Criterion and include:
- Mean execution time
- Standard deviation
- Throughput measurements
- Comparison with previous runs (if available)

Results are saved in `target/criterion/` directory with detailed HTML reports.

## Integration with Main Repository

These benchmarks maintain dependencies on the main repository for:
- `dfir_rs`: The Hydroflow dataflow implementation
- `sinktools`: Utilities for sink operations

These dependencies are specified as git dependencies pointing to the main repository, ensuring benchmarks always test against the latest version.

## Data Files

### Reachability Benchmark Data

The reachability benchmark includes two data files:

- **reachability_edges.txt** (~520 KB): Contains graph edges in the format `source target`
- **reachability_reachable.txt** (~38 KB): Contains expected reachability pairs

These files are used to test graph traversal algorithms with realistic data.

## Continuous Integration

To integrate these benchmarks into CI/CD:

1. **Manual Trigger**: Run benchmarks on-demand for performance validation
2. **Scheduled Runs**: Compare performance trends over time
3. **PR Validation**: Ensure performance regressions are detected

Example CI configuration:

```yaml
- name: Run timely/differential benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench -p timely-differential-benches
```

## Maintenance Notes

### Updating Dependencies

When updating dfir_rs or related APIs in the main repository:

1. These benchmarks will automatically use the latest version (via git dependency)
2. Check benchmark compilation after significant API changes
3. Update benchmark code if API changes break compatibility

### Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Follow the existing benchmark structure using Criterion
3. Add a `[[bench]]` entry in `Cargo.toml`
4. Update this README with benchmark description
5. Include comparative implementations (Hydroflow, Timely, Differential)

### Performance Regression Detection

If benchmarks show performance regression:

1. Compare with baseline results in `target/criterion/`
2. Review recent changes in main repository
3. Profile specific benchmark variants
4. Document findings and optimization opportunities

## Migration History

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta/benches` to this dedicated repository to:
- Separate heavy dependencies (timely, differential-dataflow) from main repository
- Improve build times for main development workflow
- Maintain performance comparison capabilities
- Enable independent benchmark evolution

For more details, see `REMOVAL_SUMMARY.md` in the main repository.

## Contact

For questions or issues with these benchmarks, please refer to the main repository's issue tracker.
