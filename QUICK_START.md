# Quick Start Guide

## Prerequisites

- Rust toolchain (version 1.91.1 or later)
- Cargo package manager

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run a Specific Benchmark

```bash
# Run the reachability benchmark
cargo bench --bench reachability

# Run the arithmetic benchmark
cargo bench --bench arithmetic

# Run the join benchmark
cargo bench --bench join
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `futures` - Futures handling
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Reachability algorithm
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String upper-casing
- `words_diamond` - Diamond pattern with word processing

## Viewing Results

After running benchmarks, criterion generates HTML reports in:
```
target/criterion/<benchmark-name>/report/index.html
```

Open these files in a web browser to see detailed performance analysis, including:
- Throughput measurements
- Latency distributions
- Performance comparisons between runs
- Statistical analysis

## Saving Baselines

To save a baseline for future comparisons:

```bash
cargo bench -- --save-baseline my-baseline
```

To compare against a saved baseline:

```bash
cargo bench -- --baseline my-baseline
```

## Cross-Repository Comparison

To compare performance with the main bigweaver-agent-canary-hydro-zeta repository:

1. Run benchmarks here and save a baseline:
   ```bash
   cargo bench -- --save-baseline timely-baseline
   ```

2. Navigate to the main repository and run equivalent benchmarks:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -- --save-baseline hydro-baseline
   ```

3. Compare the HTML reports or use custom comparison scripts

## Troubleshooting

### Build Errors

If you encounter build errors related to dependencies:

1. Ensure you have network access to fetch git dependencies
2. Check that the main bigweaver-agent-canary-hydro-zeta repository is accessible
3. Try cleaning and rebuilding:
   ```bash
   cargo clean
   cargo build
   ```

### Missing Dependencies

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main repository (via git)
- `timely` and `differential-dataflow` from crates.io

These should be automatically fetched by Cargo.

## More Information

- See [README.md](README.md) for repository overview
- See [benches/MIGRATION.md](benches/MIGRATION.md) for migration details
- See [benches/README.md](benches/README.md) for benchmark-specific documentation
