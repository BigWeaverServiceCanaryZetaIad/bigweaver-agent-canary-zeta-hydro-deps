# Scripts

## compare_benchmarks.sh

A convenience script for running performance comparisons between different dataflow implementations.

### Usage

```bash
./scripts/compare_benchmarks.sh
```

### Options

- `--baseline NAME` - Compare against a saved baseline
- `--save-baseline NAME` - Save current results as a baseline
- `--bench BENCHMARK` - Run a specific benchmark

### Examples

```bash
# Run all benchmarks
./scripts/compare_benchmarks.sh

# Run specific benchmark
./scripts/compare_benchmarks.sh --bench arithmetic

# Save baseline
./scripts/compare_benchmarks.sh --save-baseline before-optimization

# Compare against baseline
./scripts/compare_benchmarks.sh --baseline before-optimization
```

### What It Does

1. Checks that both repositories are cloned side-by-side
2. Optionally uncomments path dependencies in Cargo.toml
3. Runs cargo bench with appropriate options
4. Offers to open the HTML report

### Requirements

- Both `bigweaver-agent-canary-hydro-zeta` and `bigweaver-agent-canary-zeta-hydro-deps` repositories cloned in the same parent directory
- Rust toolchain installed
- Bash shell
