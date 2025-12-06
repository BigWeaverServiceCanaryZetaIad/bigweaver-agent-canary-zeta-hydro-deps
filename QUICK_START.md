# Quick Start Guide

## Prerequisites

Ensure both repositories are cloned as siblings:

```bash
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/  # ← You are here
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all 12 benchmarks and generate detailed reports in `target/criterion/`.

### Run Specific Benchmark

```bash
# Graph reachability (includes timely, differential, and dfir implementations)
cargo bench -p benches --bench reachability

# Arithmetic operations (includes timely and dfir implementations)
cargo bench -p benches --bench arithmetic

# Join operations
cargo bench -p benches --bench join

# Fan-in/fan-out patterns
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out

# Other benchmarks
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench upcase
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

### Filter Benchmark Functions

Run only benchmarks matching a pattern:

```bash
# Run only timely implementations
cargo bench -p benches -- timely

# Run only differential implementations
cargo bench -p benches -- differential

# Run only dfir implementations
cargo bench -p benches -- dfir

# Run specific benchmark function
cargo bench -p benches --bench reachability -- timely
```

## Understanding Results

### Console Output

Benchmarks will display:
- Time per iteration
- Performance relative to previous runs (if available)
- Statistical confidence intervals

Example:
```
reachability/timely     time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-2.3456% -1.2345% +0.1234%] (p = 0.15 > 0.05)
                        No change in performance detected.
```

### HTML Reports

Detailed reports are generated in `target/criterion/`:

```bash
# Open reports in browser
open target/criterion/report/index.html
```

Reports include:
- Performance graphs
- Statistical analysis
- Comparison with previous runs
- Detailed timing breakdowns

## Benchmark Implementations

### Timely Dataflow Benchmarks

These benchmarks compare DFIR against **Timely Dataflow**:

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Multiple sources to single destination
- `fan_out` - Single source to multiple destinations  
- `fork_join` - Fork-join pattern
- `identity` - Identity transformation
- `join` - Join operations
- `reachability` - Graph reachability (also has differential)
- `upcase` - String transformation

### Differential Dataflow Benchmarks

These benchmarks compare DFIR against **Differential Dataflow**:

- `reachability` - Incremental graph reachability computation

### DFIR-Only Benchmarks

These focus on DFIR performance characteristics:

- `micro_ops` - Fine-grained operation benchmarks
- `symmetric_hash_join` - Hash join implementation
- `words_diamond` - Diamond pattern processing
- `futures` - Async operations

## Common Tasks

### Compare Performance Changes

```bash
# Run baseline
git checkout main
cargo bench -p benches

# Make changes in main repository
cd ../bigweaver-agent-canary-hydro-zeta
# ... make your changes ...

# Compare with baseline
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

Criterion will automatically compare against previous runs.

### Profile Specific Benchmark

```bash
# Build with profiling symbols
cargo bench -p benches --bench reachability --profile=profile

# Use with profiling tools (e.g., perf, flamegraph)
perf record -g cargo bench -p benches --bench reachability --profile=profile
perf report
```

### Clean Benchmark Data

```bash
# Remove old benchmark results
rm -rf target/criterion

# Clean build artifacts
cargo clean
```

## Troubleshooting

### Error: "can't find crate for `dfir_rs`"

Ensure the main repository is present as a sibling:
```bash
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

### Error: "can't find crate for `sinktools`"

Same as above - check sibling repository structure.

### Benchmarks Take Too Long

Run a subset of benchmarks:
```bash
# Just the fast ones
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

### Performance Results Vary Widely

Ensure system is idle:
- Close other applications
- Disable CPU frequency scaling (if possible)
- Run benchmarks multiple times to establish consistency

## Next Steps

For detailed information:
- See [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) for comprehensive documentation
- See [README.md](README.md) for repository overview
- See [benches/README.md](benches/README.md) for benchmark-specific details

## Getting Help

If you encounter issues:
1. Check the [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) troubleshooting section
2. Verify repository structure (siblings)
3. Ensure Rust toolchain matches `rust-toolchain.toml`
4. Open an issue in the repository
