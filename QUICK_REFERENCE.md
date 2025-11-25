# Quick Reference

Fast reference guide for common benchmark operations.

## Table of Contents

- [Setup](#setup)
- [Running Benchmarks](#running-benchmarks)
- [Common Commands](#common-commands)
- [Benchmark List](#benchmark-list)
- [Results](#results)
- [Troubleshooting](#troubleshooting)

## Setup

### Initial Setup

```bash
# Clone repositories side by side
cd /projects/sandbox
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps

# Verify setup
cd bigweaver-agent-canary-zeta-hydro-deps
./verify_setup.sh
```

### Verify Installation

```bash
./verify_setup.sh         # Full verification
cargo check --workspace   # Quick compilation check
```

## Running Benchmarks

### Quick Commands

```bash
# Run all benchmarks
./run_benchmarks.sh

# Run specific benchmark
./run_benchmarks.sh reachability

# List available benchmarks
./run_benchmarks.sh --list

# Get help
./run_benchmarks.sh --help
```

### Cargo Commands

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Quick test run (reduced samples)
cargo bench -p benches -- --sample-size 10

# Run specific test within benchmark
cargo bench -p benches --bench reachability -- "reachability/timely"
```

## Common Commands

### Performance Tracking

```bash
# Save baseline
cargo bench -p benches -- --save-baseline main

# Compare with baseline
cargo bench -p benches -- --baseline main

# Compare specific benchmark
cargo bench -p benches --bench reachability -- --baseline main
```

### Development

```bash
# Check compilation
cargo check -p benches

# Format code
cargo fmt --all

# Run linter
cargo clippy --workspace -- -D warnings

# Clean build
cargo clean
```

### Testing

```bash
# Quick validation (10 samples, 1 second measurement)
cargo bench -p benches -- --sample-size 10 --measurement-time 1

# Verbose output
cargo bench -p benches -- --verbose

# Test specific implementation
cargo bench -p benches --bench reachability -- "differential"
```

## Benchmark List

### All Available Benchmarks

| Benchmark | File | Description |
|-----------|------|-------------|
| **arithmetic** | `arithmetic.rs` | Mathematical operations |
| **fan_in** | `fan_in.rs` | Multiple sources merging |
| **fan_out** | `fan_out.rs` | Single source splitting |
| **fork_join** | `fork_join.rs` | Fork-join parallelism |
| **futures** | `futures.rs` | Async operations |
| **identity** | `identity.rs` | Pass-through operations |
| **join** | `join.rs` | Join operations |
| **micro_ops** | `micro_ops.rs` | Micro-operations |
| **reachability** | `reachability.rs` | Graph reachability |
| **symmetric_hash_join** | `symmetric_hash_join.rs` | Symmetric hash joins |
| **upcase** | `upcase.rs` | String transformations |
| **words_diamond** | `words_diamond.rs` | Diamond pattern processing |

### Quick Select

```bash
# Graph operations
./run_benchmarks.sh reachability
./run_benchmarks.sh join

# Data flow patterns
./run_benchmarks.sh fan_in
./run_benchmarks.sh fan_out
./run_benchmarks.sh fork_join

# Real-world scenarios
./run_benchmarks.sh words_diamond
./run_benchmarks.sh upcase

# Micro benchmarks
./run_benchmarks.sh micro_ops
./run_benchmarks.sh identity
```

## Results

### Viewing Results

```bash
# HTML report (recommended)
open target/criterion/report/index.html

# Or navigate to:
# target/criterion/report/index.html

# Individual benchmark results
ls target/criterion/
```

### Result Locations

```
target/criterion/
├── report/
│   ├── index.html          # Main report
│   └── ...
├── reachability/           # Reachability results
├── arithmetic/             # Arithmetic results
└── ...                     # Other benchmarks
```

### Understanding Output

```
benchmark_name          time:   [lower bound estimate upper bound]
                        change: [lower% change% upper%] (p = 0.XX)
                        Performance has improved/regressed/stayed the same.
```

**Interpreting changes**:
- **Negative %**: Performance improved (faster)
- **Positive %**: Performance regressed (slower)
- **p < 0.05**: Statistically significant change

## Troubleshooting

### Quick Fixes

| Issue | Solution |
|-------|----------|
| "dependency not found" | Check repository structure: `../bigweaver-agent-canary-hydro-zeta/` must exist |
| Compilation errors | `cargo clean && cargo check --workspace` |
| Benchmark timeout | Use `--sample-size 10 --measurement-time 1` |
| Permission denied | `chmod +x run_benchmarks.sh verify_setup.sh` |
| Inconsistent results | Ensure no background processes, run multiple times |

### Verification Commands

```bash
# Full verification
./verify_setup.sh

# Check workspace
cargo check --workspace

# Check benches package
cargo check -p benches

# Verify paths
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
ls ../bigweaver-agent-canary-hydro-zeta/sinktools
```

## Performance Comparison Workflow

### Standard Workflow

```bash
# 1. Save baseline (on main branch)
git checkout main
cargo bench -p benches -- --save-baseline main

# 2. Make changes (on feature branch)
git checkout feature/my-optimization

# 3. Run comparison
cargo bench -p benches -- --baseline main

# 4. Review results
open target/criterion/report/index.html
```

### Quick Comparison

```bash
# Compare specific benchmark only
cargo bench -p benches --bench reachability -- --baseline main

# Quick test (fewer samples)
cargo bench -p benches --bench reachability -- --baseline main --sample-size 10
```

## Useful Flags

### Criterion Flags

| Flag | Description |
|------|-------------|
| `--sample-size N` | Number of samples to collect (default: 100) |
| `--measurement-time N` | Measurement time in seconds (default: 5) |
| `--save-baseline NAME` | Save results as baseline |
| `--baseline NAME` | Compare against saved baseline |
| `--verbose` | Verbose output |
| `--quick` | Quick mode (fewer samples) |

### Cargo Flags

| Flag | Description |
|------|-------------|
| `-p benches` | Run only benches package |
| `--bench NAME` | Run specific benchmark |
| `--profile profile` | Use profile mode (with debug symbols) |
| `--no-run` | Build but don't run |
| `--release` | Build in release mode (default for bench) |

## Examples

### Compare Two Implementations

```bash
# Run only timely and differential versions
cargo bench -p benches --bench reachability -- "timely\|differential"
```

### Fast Iteration During Development

```bash
# Quick runs for testing changes
cargo bench -p benches --bench micro_ops -- --sample-size 10 --measurement-time 1
```

### Full Performance Validation

```bash
# Complete benchmark suite with default settings
cargo bench -p benches

# Results saved automatically in target/criterion/
```

### CI/CD Quick Check

```bash
# Fast validation for CI
cargo bench -p benches -- --sample-size 10 --measurement-time 2
```

## Links

- **Detailed Guide**: [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Main README**: [README.md](README.md)
- **Main Repository**: [../bigweaver-agent-canary-hydro-zeta/](../bigweaver-agent-canary-hydro-zeta/)

## Cheat Sheet

```bash
# Most common operations
./run_benchmarks.sh                                    # Run all
./run_benchmarks.sh reachability                       # Run one
./run_benchmarks.sh --list                             # List all
cargo bench -p benches -- --sample-size 10             # Quick test
cargo bench -p benches -- --save-baseline main         # Save baseline
cargo bench -p benches -- --baseline main              # Compare
open target/criterion/report/index.html                # View results
./verify_setup.sh                                      # Verify setup
```
