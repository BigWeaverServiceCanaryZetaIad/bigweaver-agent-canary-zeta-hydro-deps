# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` packages, which have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency management and reduce compilation time.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks that use timely and differential-dataflow. These benchmarks were moved from the main repository to isolate heavy dependencies.

#### Available Benchmarks:

**Timely Dataflow Benchmarks:**
- `arithmetic` - Tests arithmetic operations in dataflow streams
- `fan_in` - Tests stream concatenation and fan-in patterns
- `fan_out` - Tests stream splitting and fan-out patterns  
- `fork_join` - Tests fork-join dataflow patterns
- `identity` - Tests identity operations (baseline performance)
- `join` - Tests join operations between streams
- `upcase` - Tests string transformation operations

**Differential Dataflow Benchmarks:**
- `reachability` - Tests graph reachability using differential dataflow

**Other Benchmarks:**
- `futures` - Tests async futures integration
- `micro_ops` - Tests various micro-operations
- `symmetric_hash_join` - Tests symmetric hash join operations
- `words_diamond` - Tests diamond-pattern dataflow with word processing

## Running Benchmarks

### Prerequisites

1. Clone both repositories as siblings:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. The benchmarks reference `dfir_rs` and `sinktools` from the main repository using relative paths.

### Running a Benchmark

From the `bigweaver-agent-canary-zeta-hydro-deps` directory:

```bash
cd benches
cargo bench --bench <benchmark_name>
```

For example, to run the reachability benchmark:

```bash
cargo bench --bench reachability
```

To run all benchmarks:

```bash
cargo bench
```

## Performance Comparison

To compare performance between different versions or changes in the main repository:

1. Checkout the baseline version in `bigweaver-agent-canary-hydro-zeta`
2. Run benchmarks and save results: `cargo bench -- --save-baseline baseline`
3. Make your changes in `bigweaver-agent-canary-hydro-zeta`
4. Run benchmarks again: `cargo bench -- --baseline baseline`

Criterion will automatically compare results and show performance differences.

### Comparing Across Branches

To compare performance between two different branches:

```bash
# Run baseline on main branch
cd bigweaver-agent-canary-hydro-zeta
git checkout main
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline main

# Run comparison on feature branch
cd ../../bigweaver-agent-canary-hydro-zeta
git checkout feature-branch
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --baseline main
```

### Continuous Integration

For CI/CD pipelines, you can generate machine-readable output:

```bash
cargo bench -- --output-format bencher
```

## Dependencies

This repository maintains dependencies on:
- `timely-master` (0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` (from main repository) - DFIR runtime
- `sinktools` (from main repository) - Sink utilities

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                      # Workspace configuration
├── README.md                       # This file
└── benches/                        # Benchmark package
    ├── Cargo.toml                  # Benchmark dependencies
    ├── README.md                   # Benchmark-specific docs
    ├── build.rs                    # Build script for code generation
    └── benches/                    # Benchmark source files
        ├── *.rs                    # Individual benchmark files
        ├── reachability_edges.txt  # Test data for reachability
        ├── reachability_reachable.txt
        └── words_alpha.txt         # English word list
```

## Why This Repository Exists

The `timely` and `differential-dataflow` dependencies significantly increase build times and binary sizes. By moving benchmarks that require these dependencies to a separate repository, we:

1. Keep the main repository lean and fast to compile
2. Reduce dependency footprint for regular development
3. Maintain ability to run performance comparisons when needed
4. Allow independent versioning of benchmark code

## Contributing

When adding new benchmarks that use timely or differential-dataflow:

1. Add them to this repository, not the main repository
2. Add the benchmark configuration to `benches/Cargo.toml`
3. Update this README with the new benchmark name and description
4. Ensure the benchmark follows the existing patterns and uses criterion harness

### Adding a New Benchmark

1. Create a new file in `benches/benches/<benchmark_name>.rs`
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "<benchmark_name>"
   harness = false
   ```
3. Test the benchmark:
   ```bash
   cargo bench --bench <benchmark_name>
   ```

## Troubleshooting

### Build Errors

**Error: `dfir_rs` or `sinktools` not found**
- Ensure both repositories are cloned as siblings
- Check that the relative paths in `benches/Cargo.toml` are correct

**Error: Compilation fails with timely/differential-dataflow**
- Verify that the dependency versions match between repositories
- Try running `cargo clean` and rebuilding

### Performance Issues

**Benchmarks run slowly**
- Ensure you're running in release mode (cargo bench automatically uses release)
- Check that no other resource-intensive processes are running
- Consider increasing the sample size if results are too variable

**Inconsistent results**
- Run benchmarks multiple times to account for variance
- Ensure system is not under load during benchmarking
- Use `--save-baseline` and `--baseline` for reliable comparisons