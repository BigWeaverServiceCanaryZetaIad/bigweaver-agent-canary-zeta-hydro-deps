# Performance Comparison Guide

This guide explains how to run performance comparisons between different versions of the main repository using the benchmarks in this repository.

## Overview

The benchmarks in this repository depend on code from the main `bigweaver-agent-canary-hydro-zeta` repository via git dependencies. By changing the git revision referenced in `benches/Cargo.toml`, you can benchmark different versions of the code and compare their performance.

## Prerequisites

- Rust toolchain (automatically configured via `rust-toolchain.toml`)
- Git
- Criterion benchmarking framework (included as a dependency)

## Quick Start

### Running All Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Running a Specific Benchmark

```bash
cargo bench -p benches --bench identity
```

## Performance Comparison Workflow

### Step 1: Create a Baseline

First, run the benchmarks with the current version to establish a baseline:

```bash
# Run benchmarks and save baseline
cargo bench -p benches --bench identity -- --save-baseline baseline-484e6fdd
```

### Step 2: Update to a Different Version

Edit `benches/Cargo.toml` and change the `rev` field in the git dependencies:

```toml
[dev-dependencies]
dfir_rs = { git = "...", rev = "NEW_COMMIT_HASH", features = [ "debugging" ] }
sinktools = { git = "...", rev = "NEW_COMMIT_HASH" }
```

### Step 3: Run Comparison

Run the benchmarks again, comparing against the baseline:

```bash
# This will show performance differences vs the baseline
cargo bench -p benches --bench identity -- --baseline baseline-484e6fdd
```

## Interpreting Results

Criterion will output results like:

```
identity/dfir          time:   [12.345 ms 12.456 ms 12.567 ms]
                       change: [-5.2341% -4.1234% -3.0123%] (p = 0.00 < 0.05)
                       Performance has improved.
```

- **time**: Current run's performance measurement
- **change**: Percentage change compared to baseline
  - Negative values indicate improvement (faster)
  - Positive values indicate regression (slower)
- **p value**: Statistical significance (< 0.05 means the change is significant)

## Available Benchmarks

| Benchmark | Description | Typical Runtime |
|-----------|-------------|----------------|
| `arithmetic` | Arithmetic operations on streams | ~10-30s |
| `fan_in` | Multiple inputs converging to one output | ~5-15s |
| `fan_out` | One input splitting to multiple outputs | ~5-15s |
| `fork_join` | Fork-join pattern with filtering | ~10-30s |
| `futures` | Async futures processing | ~10-30s |
| `identity` | Identity operations (baseline overhead) | ~10-30s |
| `join` | Join operations between streams | ~10-30s |
| `micro_ops` | Individual operation microbenchmarks | ~30-60s |
| `reachability` | Graph reachability computations | ~30-60s |
| `symmetric_hash_join` | Symmetric hash join operations | ~10-30s |
| `upcase` | String transformation operations | ~5-15s |
| `words_diamond` | Diamond pattern on word streams | ~30-60s |

## Advanced Usage

### Comparing Multiple Versions

To compare multiple versions:

```bash
# Baseline (version A)
git checkout <commit-A>
cargo bench -p benches --bench identity -- --save-baseline version-A

# Version B
# Update rev in benches/Cargo.toml to commit-B
cargo bench -p benches --bench identity -- --baseline version-A --save-baseline version-B

# Version C
# Update rev in benches/Cargo.toml to commit-C
cargo bench -p benches --bench identity -- --baseline version-B
```

### Filtering Benchmark Tests

Run specific tests within a benchmark:

```bash
# Run only dfir-related tests in identity benchmark
cargo bench -p benches --bench identity -- dfir

# Run only timely-related tests
cargo bench -p benches --bench identity -- timely
```

### Saving Detailed Reports

Criterion automatically saves HTML reports to `target/criterion/`:

```bash
# After running benchmarks, open the report
open target/criterion/identity/report/index.html
```

### Performance Profiling

For detailed profiling, use:

```bash
# Generate flamegraph
cargo bench -p benches --bench identity -- --profile-time=5
```

## Automating Comparisons

### Shell Script Example

```bash
#!/bin/bash
# compare_versions.sh

BENCHMARK="identity"
VERSIONS=("484e6fdd" "abc123" "def456")

for i in "${!VERSIONS[@]}"; do
    version="${VERSIONS[$i]}"
    echo "Testing version: $version"
    
    # Update Cargo.toml with new version
    sed -i "s/rev = \".*\"/rev = \"$version\"/" benches/Cargo.toml
    
    # Run benchmark
    if [ $i -eq 0 ]; then
        # First version - create baseline
        cargo bench -p benches --bench $BENCHMARK -- --save-baseline version-$version
    else
        # Subsequent versions - compare to previous
        prev="${VERSIONS[$i-1]}"
        cargo bench -p benches --bench $BENCHMARK -- --baseline version-$prev --save-baseline version-$version
    fi
done
```

## Troubleshooting

### Compilation Errors

If benchmarks fail to compile after changing the git revision:

1. Check if the API of `dfir_rs` or `sinktools` has changed
2. Update benchmark code to match the new API
3. Consider using a compatible commit

### Inconsistent Results

For more stable results:

1. Close other applications
2. Disable CPU frequency scaling:
   ```bash
   sudo cpupower frequency-set --governor performance
   ```
3. Run benchmarks multiple times:
   ```bash
   cargo bench -p benches --bench identity -- --sample-size 100
   ```

### Git Dependency Issues

If cargo cannot fetch git dependencies:

1. Ensure you have access to the repository
2. Check network connectivity
3. Try clearing the cargo cache:
   ```bash
   rm -rf ~/.cargo/git
   ```

## Best Practices

1. **Consistent Environment**: Run comparisons on the same machine with similar system load
2. **Multiple Runs**: Run benchmarks multiple times to account for variance
3. **Document Changes**: Record the commit hashes and any relevant changes being tested
4. **Baseline Versioning**: Use descriptive baseline names like `version-1.2.3` or `commit-abc123`
5. **Full Rebuild**: Run `cargo clean` between version changes to ensure clean builds

## CI/CD Integration

To integrate these benchmarks into CI/CD:

```yaml
# Example GitHub Actions workflow
name: Performance Benchmarks
on: [pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Rust
        uses: actions-rs/toolchain@v1
      - name: Run Benchmarks
        run: |
          cd bigweaver-agent-canary-zeta-hydro-deps
          cargo bench -p benches -- --save-baseline pr-${{ github.event.pull_request.number }}
      - name: Upload Results
        uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: target/criterion
```

## Further Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Main Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
